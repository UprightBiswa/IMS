// lib/app/modules/facial_attendance/views/captured_image_modal.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CapturedImageModal extends StatelessWidget {
  final String imagePath;

  const CapturedImageModal({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            left: 20,
            top: 45,
            right: 20,
            bottom: 20,
          ),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: Colors.black26, offset: Offset(0, 10), blurRadius: 10),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the dialog size wrap its content
            children: <Widget>[
              const Text(
                "Captured Image",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15),
              // Display the captured image
              if (imagePath.isNotEmpty && File(imagePath).existsSync())
                Image.file(
                  File(imagePath),
                  fit: BoxFit.contain,
                  height: Get.height * 0.5, // Take up to 50% of screen height
                )
              else
                const Text("Image not found!"),
              const SizedBox(height: 22),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Get.back(); // Close the dialog
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              Get.back(); // Close the dialog
            },
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              radius: 20,
              child: Icon(Icons.close, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}