import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart'; // Required for Size and Colors (for snackbar)
import 'package:flutter/services.dart'; // Required for DeviceOrientation
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

import '../views/captured_image_mdoel.dart'; // Required for InputImageRotationValue, InputImageFormatValue

class FacialAttendanceController extends GetxController {
  // final ApiClient _apiClient = Get.find<ApiClient>(); // Uncomment if you have ApiClient

  CameraController? cameraController;
  final RxBool isCameraInitialized = false.obs;
  final RxBool isDetectingFace = false.obs;
  final RxBool isBlinkDetected = false.obs;
  final RxBool isCapturing = false.obs;
  final RxString statusMessage = 'Initializing camera...'.obs;

  // ML Kit Face Detector instance
  late FaceDetector _faceDetector;

  // Blink Detection Logic Variables
  final RxDouble leftEyeOpenProb = 0.0.obs;
  final RxDouble rightEyeOpenProb = 0.0.obs;
  final List<double> _leftEyeHistory = [];
  final List<double> _rightEyeHistory = [];
  final double _blinkThreshold = 0.3; // Probability below this suggests eye is closing
  final double _openThreshold = 0.8; // Probability above this suggests eye is open
  final int _historyLength = 5; // How many frames to keep history for
  bool _readyForBlink = false; // Flag to indicate if eyes were open recently
  Timer? _blinkDebounceTimer;

  // For capturing the image (local path)
  String? _capturedImagePath;

  // Store available cameras and current camera index
  List<CameraDescription> _cameras = [];
  final RxInt _cameraIndex = 0.obs; // Default to first camera

  // Map for rotation compensation
  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  // --- NEW: Throttling variables ---
  DateTime? _lastProcessedTime;
  final Duration _processingInterval = const Duration(milliseconds: 100); // Process approx 10 frames per second

  @override
  void onInit() {
    super.onInit();
    _initializeFaceDetector(); // Initialize detector first
    _initializeCamera(); // Then initialize camera using detector
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        statusMessage.value = 'No cameras found.';
        return;
      }

      // Prefer front camera for selfies/attendance
      final frontCameraIndex = _cameras.indexWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );

      if (frontCameraIndex == -1) {
        statusMessage.value = 'Front camera not found. Using first available camera.';
        _cameraIndex.value = 0; // Fallback to first available camera if no front camera
      } else {
        _cameraIndex.value = frontCameraIndex;
      }

      await _setupCameraController(_cameras[_cameraIndex.value]);
    } catch (e) {
      print("Error initializing camera: $e");
      statusMessage.value = 'Error initializing camera: ${e.toString()}';
      isCameraInitialized.value = false;
    }
  }

  Future<void> _setupCameraController(CameraDescription cameraDescription) async {
    // Dispose previous controller if it exists
    if (cameraController != null) {
      await cameraController!.dispose();
    }

    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.low, // Use low resolution for performance with ML Kit
      enableAudio: false, // No audio needed for attendance
      // IMPORTANT: Use the correct ImageFormatGroup based on platform for ML Kit
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21 // For Android (YUV format)
          : ImageFormatGroup.bgra8888, // For iOS (BGRA format)
    );

    try {
      await cameraController!.initialize();
      isCameraInitialized.value = true;
      statusMessage.value = 'Align your face in the frame.';
      _startImageStream();
    } catch (e) {
      print("Error initializing camera controller: $e");
      statusMessage.value = 'Error setting up camera: ${e.toString()}';
      isCameraInitialized.value = false;
    }
  }

  void _initializeFaceDetector() {
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableContours: true, // Needed for eye landmarks
        enableClassification: true, // Needed for eye open probability
        performanceMode: FaceDetectorMode.fast, // Faster detection
      ),
    );
  }

  void _startImageStream() {
    if (!isCameraInitialized.value || cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }

    // Ensure image stream is stopped before starting a new one
    if (cameraController!.value.isStreamingImages) {
      cameraController!.stopImageStream();
    }

    cameraController!.startImageStream((CameraImage image) {
      // --- NEW: Frame Throttling Logic ---
      final currentTime = DateTime.now();
      if (_lastProcessedTime == null || currentTime.difference(_lastProcessedTime!) > _processingInterval) {
        _lastProcessedTime = currentTime; // Update last processed time

        // Prevent multiple detections or captures
        if (isDetectingFace.value || isCapturing.value) return;

        isDetectingFace.value = true; // Set lock before processing
        _processCameraImage(image).then((_) {
          isDetectingFace.value = false; // Release lock on success
        }).catchError((e) {
          print("Error processing image stream: $e");
          isDetectingFace.value = false; // Release lock on error
        });
      }
      // If not enough time has passed, simply drop the frame and wait for the next one
    });
  }

  Future<void> _processCameraImage(CameraImage image) async {
    final InputImage? inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) {
      // isDetectingFace.value = false; // This is handled by the .then().catchError() block in _startImageStream
      return;
    }

    try {
      final List<Face> faces = await _faceDetector.processImage(inputImage);

      if (faces.isEmpty) {
        statusMessage.value = 'No face detected.';
        isBlinkDetected.value = false;
        _resetBlinkDetection();
        return;
      }

      // Process the first detected face
      final Face face = faces.first;
      if (face.leftEyeOpenProbability != null && face.rightEyeOpenProbability != null) {
        leftEyeOpenProb.value = face.leftEyeOpenProbability!;
        rightEyeOpenProb.value = face.rightEyeOpenProbability!;

        _updateEyeHistory(face.leftEyeOpenProbability!, face.rightEyeOpenProbability!);
        _checkBlinkAndCapture();
        statusMessage.value = 'Face detected. Blink to capture.';
      } else {
        statusMessage.value = 'Eye detection not available. Ensure full face is visible.';
        isBlinkDetected.value = false;
        _resetBlinkDetection();
      }
    } catch (e) {
      print("Error processing image with ML Kit: $e");
      statusMessage.value = 'ML Kit error: ${e.toString()}';
      isBlinkDetected.value = false;
      _resetBlinkDetection();
    }
  }

  // --- REVISED _inputImageFromCameraImage ---
  InputImage? _inputImageFromCameraImage(CameraImage image) {
    // Get camera description for current camera
    final camera = _cameras[_cameraIndex.value];

    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;

    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation = _orientations[cameraController!.value.deviceOrientation];
      if (rotationCompensation == null) {
        print('Warning: Could not get rotation compensation for current device orientation.');
        return null;
      }

      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing camera
        // Compensate for the mirror effect and sensor orientation
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing camera
        rotationCompensation = (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) {
      print('Warning: Could not determine InputImageRotation.');
      return null;
    }

    Uint8List? bytes;
    int? bytesPerRow;
    InputImageFormat? inputFormat;

    // Handle Android YUV_420_888 (raw value 35) explicitly for NV21 conversion
    if (Platform.isAndroid && image.format.raw == 35 /* ImageFormat.YUV_420_888 */) {
      // For YUV_420_888 on Android, we need to concatenate the planes.
      // The `camera` plugin with `ImageFormatGroup.nv21` often gives 3 planes (Y, U, V).
      // ML Kit's InputImage.fromBytes for NV21 expects a single, concatenated buffer.
      bytes = _convertYUV420ToNV21(image); // Use the new, robust converter
      bytesPerRow = image.planes[0].bytesPerRow; // bytesPerRow is for the Y plane
      inputFormat = InputImageFormat.nv21; // Explicitly state it's NV21
    }
    // Handle iOS BGRA8888 (raw value 875708886)
    else if (Platform.isIOS && image.format.raw == 875708886 /* kCVPixelFormatType_32BGRA */) {
      if (image.planes.length != 1) {
        print('Unexpected number of planes for iOS BGRA8888: ${image.planes.length}');
        return null;
      }
      bytes = image.planes.first.bytes;
      bytesPerRow = image.planes.first.bytesPerRow;
      inputFormat = InputImageFormat.bgra8888; // Explicitly state it's BGRA8888
    }
    else {
      print('Unsupported image format or platform combination: raw=${image.format.raw} on ${Platform.operatingSystem}');
      return null;
    }

    if (bytes == null || bytesPerRow == null || inputFormat == null) {
      print('Failed to prepare InputImage: bytes, bytesPerRow, or inputFormat is null.');
      return null;
    }

    return InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: inputFormat,
        bytesPerRow: bytesPerRow,
      ),
    );
  }

  // --- NEW ROBUST NV21 CONVERTER (for Android YUV_420_888) ---
  Uint8List _convertYUV420ToNV21(CameraImage image) {
    final int width = image.width;
    final int height = image.height;
    final int yPlaneRowStride = image.planes[0].bytesPerRow;
    final int uvPlaneRowStride = image.planes[1].bytesPerRow; // U or V plane's row stride
    final int uvPixelStride = image.planes[1].bytesPerPixel ?? 2; // U or V plane's pixel stride (usually 2 for interleaved)

    // Calculate the size of the NV21 buffer
    // Y plane is width * height.
    // UV plane is (width/2 * height/2) * 2 bytes for interleaved VU.
    // Total: width * height + width * height / 2 = width * height * 1.5
    // Ensure integer division.
    final int nv21BufferSize = (width * height) + ((width * height) ~/ 2);
    final Uint8List nv21Bytes = Uint8List(nv21BufferSize);

    // Copy Y plane data
    final Uint8List yPlane = image.planes[0].bytes;
    int srcYOffset = 0;
    int destYOffset = 0;
    for (int i = 0; i < height; i++) {
      nv21Bytes.setRange(destYOffset, destYOffset + width, yPlane.sublist(srcYOffset, srcYOffset + width));
      srcYOffset += yPlaneRowStride; // Move to the next row in the source plane
      destYOffset += width; // Move to the next row in the destination buffer (no padding)
    }

    // Copy and interleave V and U planes (NV21 is Y + V then U interleaved)
    final Uint8List uPlane = image.planes[1].bytes;
    final Uint8List vPlane = image.planes[2].bytes;

    int srcUVOffset = 0;
    int destUVOffset = width * height; // Start after the Y plane in NV21 buffer
    for (int i = 0; i < height ~/ 2; i++) {
      for (int j = 0; j < width ~/ 2; j++) {
        final int uPixelIndex = srcUVOffset + (j * uvPixelStride);
        final int vPixelIndex = srcUVOffset + (j * uvPixelStride); // V and U typically have same indexing for their respective planes

        // Ensure indices are within bounds
        if (vPixelIndex < vPlane.length && uPixelIndex < uPlane.length) {
          nv21Bytes[destUVOffset++] = vPlane[vPixelIndex]; // V
          nv21Bytes[destUVOffset++] = uPlane[uPixelIndex]; // U
        } else {
          // This should ideally not happen if the camera provides valid plane data
          print('Warning: NV21 conversion - UV plane index out of bounds. Skipping remainder.');
          break; // Exit inner loop
        }
      }
      if (destUVOffset >= nv21BufferSize) {
          break; // Exit outer loop if buffer filled
      }
      srcUVOffset += uvPlaneRowStride; // Move to the next row in the source UV planes
    }
    return nv21Bytes;
  }

  void _updateEyeHistory(double leftProb, double rightProb) {
    _leftEyeHistory.add(leftProb);
    _rightEyeHistory.add(rightProb);
    if (_leftEyeHistory.length > _historyLength) {
      _leftEyeHistory.removeAt(0);
      _rightEyeHistory.removeAt(0);
    }
  }

  void _checkBlinkAndCapture() {
    if (_leftEyeHistory.length < _historyLength) return;

    // Check for "open -> closed -> open" sequence for both eyes
    bool leftEyeClosed = _leftEyeHistory.last < _blinkThreshold;
    bool rightEyeClosed = _rightEyeHistory.last < _blinkThreshold;

    // Check if eyes were open in the recent past (excluding the last frame)
    bool wasLeftOpen = _leftEyeHistory.sublist(0, _historyLength - 1).any((p) => p > _openThreshold);
    bool wasRightOpen = _rightEyeHistory.sublist(0, _historyLength - 1).any((p) => p > _openThreshold);

    if ((leftEyeClosed && rightEyeClosed) && (wasLeftOpen && wasRightOpen)) {
      // Eyes were open, now both are closed
      _readyForBlink = true;
    } else if (_readyForBlink && leftEyeOpenProb.value > _openThreshold && rightEyeOpenProb.value > _openThreshold) {
      // Eyes were closed, now both are open again - a blink!
      _readyForBlink = false; // Reset for next blink
      if (_blinkDebounceTimer?.isActive ?? false) _blinkDebounceTimer!.cancel();
      _blinkDebounceTimer = Timer(const Duration(milliseconds: 500), () {
        // Debounce to prevent multiple captures for a single blink
        isBlinkDetected.value = true;
        _captureAndUploadImage();
      });
    }
  }

  void _resetBlinkDetection() {
    _leftEyeHistory.clear();
    _rightEyeHistory.clear();
    _readyForBlink = false;
    _blinkDebounceTimer?.cancel();
  }

  Future<void> _captureAndUploadImage() async {
    if (isCapturing.value) return;

    isCapturing.value = true;
    statusMessage.value = 'Blink detected! Capturing image...';
    try {
      final XFile? file = await cameraController?.takePicture();
      if (file != null) {
        _capturedImagePath = file.path;
        statusMessage.value = 'Image captured. Uploading...';
        // --- NEW: Show the captured image in a modal ---
        Get.dialog(
          CapturedImageModal(imagePath: _capturedImagePath!),
          barrierDismissible: false, // User must tap OK or close icon
        ).then((_) {
            // This 'then' block executes when the modal is closed
            // Here, you can optionally proceed with upload or just reset
            statusMessage.value = 'Image displayed. Ready for next blink.';
            // For now, we'll just reset. If you want to upload here, call _uploadImage.
            // await _uploadImage(File(_capturedImagePath!));
        });
        // --- END NEW ---
        // await _uploadImage(File(file.path)); // Uncomment when ApiClient is ready
        Get.snackbar(
          'Success (Simulated)',
          'Attendance marked successfully (simulated)!',
          backgroundColor: Colors.green, // Using standard Colors for now
          colorText: Colors.white,
        );
        // statusMessage.value = 'Attendance marked!';
      } else {
        statusMessage.value = 'Failed to capture image.';
      }
    } catch (e) {
      print("Error capturing image: $e");
      statusMessage.value = 'Error capturing image: ${e.toString()}';
    } finally {
      isCapturing.value = false;
      isBlinkDetected.value = false;
      // _resetBlinkDetection(); // Reset blink state after capture attempt
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    statusMessage.value = 'Uploading image...';
    // try {
    //   // Your actual upload logic here
    //   const dummyUserId = 'test_user_123'; // Placeholder
    //   final response = await _apiClient.uploadAttendanceImage(imageFile, dummyUserId);
    //   if (response.statusCode == 200) {
    //     Get.snackbar('Success', 'Attendance marked successfully!', backgroundColor: Colors.green, colorText: Colors.white);
    //     statusMessage.value = 'Attendance marked!';
    //   } else {
    //     Get.snackbar('Error', 'Failed to upload image. Status: ${response.statusCode}', backgroundColor: Colors.red, colorText: Colors.white);
    //     statusMessage.value = 'Upload failed: ${response.statusCode}';
    //     print('Upload response: ${response.body}');
    //   }
    // } catch (e) {
    //   Get.snackbar('Upload Error', 'An error occurred during upload: ${e.toString()}', backgroundColor: Colors.red, colorText: Colors.white);
    //   statusMessage.value = 'Upload error: ${e.toString()}';
    //   print("Error uploading image: $e");
    // }
     print('Simulating upload of image: ${imageFile.path}');
     await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
     print('Simulated upload complete.');
  }

  @override
  void onClose() {
    cameraController?.dispose();
    _faceDetector.close();
    _blinkDebounceTimer?.cancel();
    super.onClose();
  }
}