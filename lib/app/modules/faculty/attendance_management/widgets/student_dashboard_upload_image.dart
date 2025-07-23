import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../controllers/faculty_student_attendance_controller.dart';

class StudentDashboardUploadImage extends StatelessWidget {
  StudentDashboardUploadImage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Rx variable to hold the picked file path
  final Rxn<String> _pickedFilePath = Rxn<String>();
  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final FacultyStudentAttendanceController controller =
        Get.find<FacultyStudentAttendanceController>();
    return Scaffold(
      backgroundColor: AppColors.lightGreyBackground,
      appBar: AppBar(
        title: const Text(
          'Upload Photo',
          style: TextStyle(color: AppColors.darkText),
        ),
        backgroundColor: AppColors.cardBackground,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: AppColors.darkText),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload Photo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[800],
                ),
              ),
              Text(
                'Fill this form to submit a leave request to your department',
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
              const SizedBox(height: 20),

              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Obx(() {
                    return Column(
                      children: [
                        if (_pickedFilePath.value == null)
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: 40,
                            color: AppColors.greyText,
                          )
                        else
                          Icon(
                            Icons.image, // Show image icon if file is picked
                            size: 40,
                            color: AppColors.primaryBlue,
                          ),
                        const SizedBox(height: 8),
                        Text(
                          _pickedFilePath.value == null
                              ? 'Click to upload or Drag and drop'
                              : 'File Selected: ${_pickedFilePath.value!.split('/').last}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.darkText,
                          ),
                        ),
                        Text(
                          'PDF, JPG, PNG (max. 5MB)',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.greyText,
                          ),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: _pickImage,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primaryBlue,
                            side: BorderSide(color: AppColors.primaryBlue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Choose File'),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: 'Notes (Optional)',
                  hintText: 'Add any relevant notes for attendance marking',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Obx(
          () => ElevatedButton(
            onPressed:
                controller.isLoading.value || _pickedFilePath.value == null
                ? null
                : () async {
                    if (_formKey.currentState!.validate() &&
                        _pickedFilePath.value != null) {
                      bool success = await controller.startAttendanceMarking(
                        _pickedFilePath.value!,
                        _notesController.text,
                      );
                      // After successful API call, the controller will navigate back
                      if (success) {
                        // Clear the form fields upon successful upload
                        _pickedFilePath.value = null;
                        _notesController.clear();
                      }
                      // Error snackbar is already handled by the controller
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: controller.isLoading.value
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
                    'Upload Image',
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null && result.files.single.path != null) {
      _pickedFilePath.value = result.files.single.path!;
    } else {
      _pickedFilePath.value = null; // User canceled the picker
      Get.snackbar(
        'Selection Canceled',
        'No image was selected.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }
}
