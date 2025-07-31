// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/student_registration_controller.dart';
// import '../models/deepartment_model.dart';
// import '../models/semester_model.dart';

// class AddNewStudentView extends StatelessWidget {
//   const AddNewStudentView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Add New Student")),
//       body: StudentRegistrationView(),
//     );
//   }
// }

// class StudentRegistrationView extends StatefulWidget {
//   const StudentRegistrationView({super.key});

//   @override
//   State<StudentRegistrationView> createState() => _StudentRegistrationViewState();
// }

// class _StudentRegistrationViewState extends State<StudentRegistrationView> {
//   final StudentRegistrationController controller = Get.find<StudentRegistrationController>();
//   int _currentStep = 0;
//   final _userFormKey = GlobalKey<FormState>();
//   final _studentFormKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//         () => Stepper(
//           type: StepperType.vertical,
//           currentStep: _currentStep,
//           onStepContinue: () {
//             final isLastStep = _currentStep == getSteps().length - 1;
//             if (isLastStep) {
//               // Handle final submission (e.g., show summary or navigate back)
//               controller.enrollCourses().then((_) {
//                if (!controller.isLoading.value && controller.errorMessage.isEmpty) {

//                   Get.snackbar('Success', 'Student registration and course enrollment complete!', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green.shade100);
//                   controller.resetForm(); // Reset form after successful completion
//                   setState(() => _currentStep = 0); // Go back to first step
//                 }
//               });

//             } else {
//               if (_currentStep == 0) {
//                 if (_userFormKey.currentState?.validate() ?? false) {
//                   controller.registerUser().then((_) {
//                     if (controller.createdUserId.value != null) {
//                       setState(() => _currentStep += 1);
//                     }
//                   });
//                 }
//               } else if (_currentStep == 1) {
//                 if (_studentFormKey.currentState?.validate() ?? false) {
//                   controller.createStudent().then((_) {
//                     if (controller.createdStudentInternalId.value != null) {
//                       setState(() => _currentStep += 1);
//                     }
//                   });
//                 }
//               } else {
//                 setState(() => _currentStep += 1);
//               }
//             }
//           },
//           onStepCancel: () {
//             if (_currentStep > 0) {
//               setState(() => _currentStep -= 1);
//             } else {
//               Get.back(); // Go back if on the first step
//           },
//           controlsBuilder: (context, details) {
//             return Padding(
//               padding: const EdgeInsets.only(top: 16.0),
//               child: Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: details.onStepContinue,
//                       child: Text(_currentStep == getSteps().length - 1 ? 'Finish Enrollment' : 'Continue'),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   if (_currentStep != 0)
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: details.onStepCancel,
//                         child: const Text('Back'),
//                       ),
//                     ),
//                 ],
//               ),
//             );
//           },
//           steps: getSteps(),
//         ),
//       ),
//     );
//   }

//   List<Step> getSteps() => [
//         Step(
//           title: const Text('User Registration'),
//           content: Form(
//             key: _userFormKey,
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: controller.usernameController,
//                   decoration: const InputDecoration(labelText: 'Username'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter username';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: controller.passwordController,
//                   decoration: const InputDecoration(labelText: 'Password'),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter password';
//                     }
//                     if (value.length < 6) {
//                       return 'Password must be at least 6 characters';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: controller.emailController,
//                   decoration: const InputDecoration(labelText: 'Email'),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter email';
//                     }
//                     if (!GetUtils.isEmail(value)) {
//                       return 'Please enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: controller.firstNameController,
//                   decoration: const InputDecoration(labelText: 'First Name'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter first name';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: controller.lastNameController,
//                   decoration: const InputDecoration(labelText: 'Last Name'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter last name';
//                     }
//                     return null;
//                   },
//                 ),
//                 if (controller.isLoading.value) const LinearProgressIndicator(),
//                 if (controller.errorMessage.isNotEmpty)
//                   Text(
//                     controller.errorMessage.value,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//               ],
//             ),
//           ),
//           isActive: _currentStep >= 0,
//           state: _currentStep > 0 ? StepState.complete : StepState.indexed,
//         ),
//         Step(
//           title: const Text('Student Details & Enrollment'),
//           content: Form(
//             key: _studentFormKey,
//             child: Column(
//               children: [
//                 Text('User ID: ${controller.createdUserId.value ?? 'N/A'}'),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: controller.studentIdController,
//                   decoration: const InputDecoration(labelText: 'Student ID (e.g., STU001)'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter student ID';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: controller.enrollmentDateController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enrollment Date (YYYY-MM-DD)',
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                   readOnly: true,
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2101),
//                     );
//                     if (pickedDate != null) {
//                       controller.enrollmentDateController.text =
//                           pickedDate.toIso8601String().split('T')[0];
//                     }
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please select enrollment date';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 Obx(() => DropdownButtonFormField<Department>(
//                       decoration: const InputDecoration(labelText: 'Select Department'),
//                       value: controller.selectedDepartment.value,
//                       items: controller.departments.map((department) {
//                         return DropdownMenuItem<Department>(
//                           value: department,
//                           child: Text(department.name ?? 'N/A'),
//                         );
//                       }).toList(),
//                       onChanged: controller.onDepartmentSelected,
//                       validator: (value) {
//                         if (value == null) {
//                           return 'Please select a department';
//                         }
//                         return null;
//                       },
//                       hint: const Text('Select a department'),
//                     )),
//                 const SizedBox(height: 16),
//                 Obx(() => DropdownButtonFormField<SemesterData>(
//                       decoration: const InputDecoration(labelText: 'Select Semester'),
//                       value: controller.selectedSemester.value,
//                       items: controller.semesters.map((semester) {
//                         return DropdownMenuItem<SemesterData>(
//                           value: semester,
//                           child: Text(semester.name ?? 'N/A'),
//                         );
//                       }).toList(),
//                       onChanged: controller.onSemesterSelected,
//                       validator: (value) {
//                         if (value == null) {
//                           return 'Please select a semester';
//                         }
//                         return null;
//                       },
//                       hint: const Text('Select a semester'),
//                       // Disable until department is selected
//                       isDense: true,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                     )),
//                 if (controller.isLoading.value) const LinearProgressIndicator(),
//                 if (controller.errorMessage.isNotEmpty)
//                   Text(
//                     controller.errorMessage.value,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//               ],
//             ),
//           ),
//           isActive: _currentStep >= 1,
//           state: _currentStep > 1 ? StepState.complete : StepState.indexed,
//         ),
//         Step(
//           title: const Text('Enroll in Courses'),
//           content: Obx(() {
//             if (controller.isLoading.value) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (controller.errorMessage.isNotEmpty) {
//               return Text(controller.errorMessage.value, style: const TextStyle(color: Colors.red));
//             }
//             if (controller.courses.isEmpty) {
//               return const Text('No courses available for selected semester.');
//             }
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text('Select Courses:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 8),
//                 ...controller.courses.map((course) {
//                   return CheckboxListTile(
//                     title: Text(course.title ?? 'Unknown Course'),
//                     subtitle: Text('Code: ${course.courseCode ?? 'N/A'} - Credits: ${course.credits ?? 'N/A'}'),
//                     value: controller.selectedCourses.contains(course),
//                     onChanged: (bool? value) {
//                       controller.toggleCourseSelection(course);
//                     },
//                   );
//                 }).toList(),
//               ],
//             );
//           }),
//           isActive: _currentStep >= 2,
//           state: _currentStep > 2 ? StepState.complete : StepState.indexed,
//         ),
//       ];
// }

// lib/app/modules/student_registration/views/student_registration_view.dart

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/student_registration_controller.dart';
// import '../models/deepartment_model.dart'; // Corrected spelling
// import '../models/semester_model.dart';

// class AddNewStudentView extends StatelessWidget {
//   const AddNewStudentView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Make sure to bind your controller before using Get.find()
//     // For example, in your binding file for this module:
//     // Get.lazyPut(() => StudentRegistrationController(apiService: Get.find<ApiService>()));
//     // Or if you instantiate ApiService directly in the controller:
//     Get.lazyPut(() => StudentRegistrationController()); // If ApiService is instantiated inside the controller

//     return Scaffold(
//       appBar: AppBar(title: const Text("Add New Student")),
//       body: StudentRegistrationStepperView(), // Renamed to avoid confusion with StatelessWidget name
//     );
//   }
// }

// class StudentRegistrationStepperView extends StatefulWidget {
//   const StudentRegistrationStepperView({super.key});

//   @override
//   State<StudentRegistrationStepperView> createState() => _StudentRegistrationStepperViewState();
// }

// class _StudentRegistrationStepperViewState extends State<StudentRegistrationStepperView> {
//   final StudentRegistrationController controller = Get.find<StudentRegistrationController>();
//   int _currentStep = 0;
//   final _userFormKey = GlobalKey<FormState>();
//   final _studentFormKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Stepper(
//         type: StepperType.vertical,
//         currentStep: _currentStep,
//         onStepContinue: () async {
//           final isLastStep = _currentStep == getSteps().length - 1;

//           if (_currentStep == 0) {
//             // Step 1: User Registration
//             if (_userFormKey.currentState?.validate() ?? false) {
//               await controller.registerUser();
//               if (controller.createdUserId.value != null && controller.errorMessage.isEmpty) {
//                 setState(() => _currentStep += 1);
//               }
//             }
//           } else if (_currentStep == 1) {
//             // Step 2: Student Details & Enrollment
//             if (_studentFormKey.currentState?.validate() ?? false) {
//               await controller.createStudent();
//               if (controller.createdStudentInternalId.value != null && controller.errorMessage.isEmpty) {
//                 setState(() => _currentStep += 1);
//               }
//             }
//           } else if (isLastStep) {
//             // Step 3: Enroll in Courses (Final Step)
//             if (controller.selectedCourses.isEmpty) {
//               Get.snackbar('Error', 'Please select at least one course.', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red.shade100);
//               return;
//             }
//             await controller.enrollCourses();
//             if (!controller.isLoading.value && controller.errorMessage.isEmpty) {
//               Get.snackbar('Success', 'Student registration and course enrollment complete!', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green.shade100);
//               controller.resetForm(); // Reset form after successful completion
//               setState(() => _currentStep = 0); // Go back to first step
//             }
//           } else {
//             // Generic step increment for future steps if any
//             setState(() => _currentStep += 1);
//           }
//         },
//         onStepCancel: () {
//           if (_currentStep > 0) {
//             setState(() => _currentStep -= 1);
//           } else {
//             Get.back(); // Go back if on the first step
//           }
//         },
//         controlsBuilder: (context, details) {
//           return Padding(
//             padding: const EdgeInsets.only(top: 16.0),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: details.onStepContinue,
//                     child: controller.isLoading.value
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : Text(_currentStep == getSteps().length - 1 ? 'Finish Enrollment' : 'Continue'),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 if (_currentStep != 0)
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: details.onStepCancel,
//                       child: const Text('Back'),
//                     ),
//                   ),
//               ],
//             ),
//           );
//         },
//         steps: getSteps(),
//       ),
//     );
//   }

//   List<Step> getSteps() => [
//         Step(
//           title: const Text('User Registration'),
//           content: Form(
//             key: _userFormKey,
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: controller.usernameController,
//                   decoration: const InputDecoration(labelText: 'Username'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter username';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: controller.passwordController,
//                   decoration: const InputDecoration(labelText: 'Password'),
//                   obscureText: true,
//                   readOnly: true, // Make it read-only since it's pre-filled
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter password';
//                     }
//                     if (value.length < 6) {
//                       return 'Password must be at least 6 characters';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: controller.emailController,
//                   decoration: const InputDecoration(labelText: 'Email'),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter email';
//                     }
//                     if (!GetUtils.isEmail(value)) {
//                       return 'Please enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: controller.firstNameController,
//                   decoration: const InputDecoration(labelText: 'First Name'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter first name';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: controller.lastNameController,
//                   decoration: const InputDecoration(labelText: 'Last Name'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter last name';
//                     }
//                     return null;
//                   },
//                 ),
//                 // The role field is removed as it's defaulted in the controller
//                 if (controller.isLoading.value) const LinearProgressIndicator(),
//                 if (controller.errorMessage.isNotEmpty)
//                   Text(
//                     controller.errorMessage.value,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//               ],
//             ),
//           ),
//           isActive: _currentStep >= 0,
//           state: _currentStep > 0 ? StepState.complete : StepState.indexed,
//         ),
//         Step(
//           title: const Text('Student Details & Semester'),
//           content: Form(
//             key: _studentFormKey,
//             child: Column(
//               children: [
//                 Text('User ID (from previous step): ${controller.createdUserId.value ?? 'N/A'}'),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: controller.studentIdController,
//                   decoration: const InputDecoration(labelText: 'Student ID (e.g., STU001)'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter student ID';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: controller.enrollmentDateController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enrollment Date (YYYY-MM-DD)',
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                   readOnly: true,
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2101),
//                     );
//                     if (pickedDate != null) {
//                       controller.enrollmentDateController.text =
//                           pickedDate.toIso8601String().split('T')[0];
//                     }
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please select enrollment date';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 Obx(() => DropdownButtonFormField<Department>(
//                       decoration: const InputDecoration(labelText: 'Select Department'),
//                       value: controller.selectedDepartment.value,
//                       items: controller.departments.map((department) {
//                         return DropdownMenuItem<Department>(
//                           value: department,
//                           child: Text(department.name ?? 'N/A'),
//                         );
//                       }).toList(),
//                       onChanged: controller.onDepartmentSelected,
//                       validator: (value) {
//                         if (value == null) {
//                           return 'Please select a department';
//                         }
//                         return null;
//                       },
//                       hint: const Text('Select a department'),
//                       isExpanded: true, // Make dropdown expand
//                     )),
//                 const SizedBox(height: 16),
//                 Obx(() => DropdownButtonFormField<SemesterData>(
//                       decoration: const InputDecoration(labelText: 'Select Semester'),
//                       value: controller.selectedSemester.value,
//                       items: controller.semesters.map((semester) {
//                         return DropdownMenuItem<SemesterData>(
//                           value: semester,
//                           child: Text(semester.name ?? 'N/A'),
//                         );
//                       }).toList(),
//                       onChanged: controller.onSemesterSelected,
//                       validator: (value) {
//                         if (value == null) {
//                           return 'Please select a semester';
//                         }
//                         return null;
//                       },
//                       hint: const Text('Select a semester'),
//                       isExpanded: true,
//                       // Disable until department is selected
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                     )),
//                 if (controller.isLoading.value) const LinearProgressIndicator(),
//                 if (controller.errorMessage.isNotEmpty)
//                   Text(
//                     controller.errorMessage.value,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//               ],
//             ),
//           ),
//           isActive: _currentStep >= 1,
//           state: _currentStep > 1 ? StepState.complete : StepState.indexed,
//         ),
//         Step(
//           title: const Text('Enroll in Courses'),
//           content: Obx(() {
//             if (controller.isLoading.value) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (controller.errorMessage.isNotEmpty) {
//               return Text(controller.errorMessage.value, style: const TextStyle(color: Colors.red));
//             }
//             if (controller.courses.isEmpty) {
//               return const Text('No courses available for selected semester. Please select department and semester.');
//             }
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Student Internal ID: ${controller.createdStudentInternalId.value ?? 'N/A'}'),
//                 const SizedBox(height: 16),
//                 const Text('Select Courses:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 8),
//                 ...controller.courses.map((course) {
//                   return CheckboxListTile(
//                     title: Text(course.title ?? 'Unknown Course'),
//                     subtitle: Text('Code: ${course.courseCode ?? 'N/A'} - Credits: ${course.credits ?? 'N/A'}'),
//                     value: controller.selectedCourses.contains(course),
//                     onChanged: (bool? value) {
//                       controller.toggleCourseSelection(course);
//                     },
//                   );
//                 }).toList(),
//               ],
//             );
//           }),
//           isActive: _currentStep >= 2,
//           state: _currentStep > 2 ? StepState.complete : StepState.indexed,
//         ),
//       ];
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/student_registration_controller.dart';
import '../models/deepartment_model.dart'; // Corrected spelling
import '../models/semester_model.dart';

class AddNewStudentView extends StatelessWidget {
  const AddNewStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    // Make sure to bind your controller before using Get.find()
    // For example, in your binding file for this module:
    // Get.lazyPut(() => StudentRegistrationController(apiService: Get.find<ApiService>()));
    // Or if you instantiate ApiService directly in the controller:
    Get.lazyPut(
      () => StudentRegistrationController(),
    ); // If ApiService is instantiated inside the controller

    return Scaffold(
      appBar: AppBar(title: const Text("Add New Student")),
      body:
          StudentRegistrationStepperView(), // Renamed to avoid confusion with StatelessWidget name
    );
  }
}

class StudentRegistrationStepperView extends StatefulWidget {
  const StudentRegistrationStepperView({super.key});

  @override
  State<StudentRegistrationStepperView> createState() =>
      _StudentRegistrationStepperViewState();
}

class _StudentRegistrationStepperViewState
    extends State<StudentRegistrationStepperView> {
  final StudentRegistrationController controller =
      Get.find<StudentRegistrationController>();
  int _currentStep = 0;
  final _userFormKey = GlobalKey<FormState>();
  final _studentFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: () async {
          final isLastStep = _currentStep == getSteps().length - 1;

          if (_currentStep == 0) {
            // Step 1: User Registration
            if (_userFormKey.currentState?.validate() ?? false) {
              // Only attempt to register user if it hasn't been done for this session
              if (controller.createdUserId.value == null) {
                await controller.registerUser();
                if (controller.createdUserId.value != null &&
                    controller.errorMessage.isEmpty) {
                  setState(() => _currentStep += 1);
                }
              } else {
                // If user already created, just move to next step
                setState(() => _currentStep += 1);
              }
            }
          } else if (_currentStep == 1) {
            // Step 2: Student Details & Enrollment
            if (_studentFormKey.currentState?.validate() ?? false) {
              // Only attempt to create student if it hasn't been done for this session
              if (controller.createdStudentInternalId.value == null) {
                await controller.createStudent();
                if (controller.createdStudentInternalId.value != null &&
                    controller.errorMessage.isEmpty) {
                  setState(() => _currentStep += 1);
                }
              } else {
                // If student already created, just move to next step
                setState(() => _currentStep += 1);
              }
            }
          } else if (isLastStep) {
            // Step 3: Enroll in Courses (Final Step)
            if (controller.selectedCourses.isEmpty) {
              Get.snackbar(
                'Error',
                'Please select at least one course.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red.shade100,
              );
              return;
            }
            await controller.enrollCourses();
            if (!controller.isLoading.value &&
                controller.errorMessage.isEmpty) {
              Get.snackbar(
                'Success',
                'Student registration and course enrollment complete!',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green.shade100,
              );
              controller.resetForm(); // Reset form after successful completion
              setState(() => _currentStep = 0); // Go back to first step
            }
          } else {
            // Generic step increment for future steps if any
            setState(() => _currentStep += 1);
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          } else {
            Get.back(); // Go back if on the first step
          }
        },
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    // Disable the continue button if the current step has already been completed
                    // and there's a successful ID generated for that step.
                    onPressed:
                        (_currentStep == 0 &&
                                controller.createdUserId.value != null) ||
                            (_currentStep == 1 &&
                                controller.createdStudentInternalId.value !=
                                    null)
                        ? () {
                            // If the step is already completed, just allow moving to the next step
                            setState(() => _currentStep += 1);
                          }
                        : details
                              .onStepContinue, // Otherwise, use the default continue logic
                    child:
                        controller.isLoading.value &&
                            ((_currentStep == 0 &&
                                    controller.createdUserId.value == null) ||
                                (_currentStep == 1 &&
                                    controller.createdStudentInternalId.value ==
                                        null) ||
                                (_currentStep == 2))
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            _currentStep == getSteps().length - 1
                                ? 'Finish Enrollment'
                                : 'Continue',
                          ),
                  ),
                ),
                const SizedBox(width: 10),
                if (_currentStep != 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: details.onStepCancel,
                      child: const Text('Back'),
                    ),
                  ),
              ],
            ),
          );
        },
        steps: getSteps(),
      ),
    );
  }

  List<Step> getSteps() => [
    Step(
      title: const Text('User Registration'),
      content: Form(
        key: _userFormKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller.usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter username';
                }
                return null;
              },
              readOnly:
                  controller.createdUserId.value !=
                  null, // Make read-only if ID exists
            ),
            TextFormField(
              controller: controller.passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              readOnly:
                  controller.createdUserId.value !=
                  null, // Make read-only if ID exists
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            TextFormField(
              controller: controller.emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              readOnly:
                  controller.createdUserId.value !=
                  null, // Make read-only if ID exists
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                if (!GetUtils.isEmail(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: controller.firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter first name';
                }
                return null;
              },
              readOnly:
                  controller.createdUserId.value !=
                  null, // Make read-only if ID exists
            ),
            TextFormField(
              controller: controller.lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter last name';
                }
                return null;
              },
              readOnly:
                  controller.createdUserId.value !=
                  null, // Make read-only if ID exists
            ),
            // The role field is removed as it's defaulted in the controller
            if (controller.isLoading.value) const LinearProgressIndicator(),
            if (controller.errorMessage.isNotEmpty)
              Text(
                controller.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
      isActive: _currentStep >= 0,
      state: _currentStep > 0 ? StepState.complete : StepState.indexed,
    ),
    Step(
      title: const Text('Student Details & Semester'),
      content: Form(
        key: _studentFormKey,
        child: Column(
          children: [
            Text(
              'User ID (from previous step): ${controller.createdUserId.value ?? 'N/A'}',
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: controller.studentIdController,
              decoration: const InputDecoration(
                labelText: 'Student ID (e.g., STU001)',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter student ID';
                }
                return null;
              },
              readOnly:
                  controller.createdStudentInternalId.value !=
                  null, // Make read-only if ID exists
            ),
            TextFormField(
              controller: controller.enrollmentDateController,
              decoration: const InputDecoration(
                labelText: 'Enrollment Date (YYYY-MM-DD)',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly:
                  controller.createdStudentInternalId.value !=
                  null, // Make read-only if ID exists or
              // true, // Always read-only as it's a date picker
              onTap: controller.createdStudentInternalId.value != null
                  ? null
                  : () async {
                      // Disable onTap if ID exists
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        controller.enrollmentDateController.text = pickedDate
                            .toIso8601String()
                            .split('T')[0];
                      }
                    },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select enrollment date';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Obx(
              () => DropdownButtonFormField<Department>(
                decoration: const InputDecoration(
                  labelText: 'Select Department',
                ),
                value: controller.selectedDepartment.value,
                items: controller.departments.map((department) {
                  return DropdownMenuItem<Department>(
                    value: department,
                    child: Text('${department.name} ${department.id}' ?? 'N/A'),
                  );
                }).toList(),
                onChanged: controller.createdStudentInternalId.value != null
                    ? null
                    : controller
                          .onDepartmentSelected, // Disable onChanged if ID exists
                validator: (value) {
                  if (value == null) {
                    return 'Please select a department';
                  }
                  return null;
                },
                hint: const Text('Select a department'),
                isExpanded: true, // Make dropdown expand
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => DropdownButtonFormField<SemesterData>(
                decoration: const InputDecoration(labelText: 'Select Semester'),
                value: controller.selectedSemester.value,
                items: controller.semesters.map((semester) {
                  return DropdownMenuItem<SemesterData>(
                    value: semester,
                    child: Text(semester.name ?? 'N/A'),
                  );
                }).toList(),
                onChanged: controller.createdStudentInternalId.value != null
                    ? null
                    : controller
                          .onSemesterSelected, // Disable onChanged if ID exists
                validator: (value) {
                  if (value == null) {
                    return 'Please select a semester';
                  }
                  return null;
                },
                hint: const Text('Select a semester'),
                isExpanded: true,
                // Disable until department is selected
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            if (controller.isLoading.value) const LinearProgressIndicator(),
            if (controller.errorMessage.isNotEmpty)
              Text(
                controller.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
      isActive: _currentStep >= 1,
      state: _currentStep > 1 ? StepState.complete : StepState.indexed,
    ),
    Step(
      title: const Text('Enroll in Courses'),
      content: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.isNotEmpty) {
          return Text(
            controller.errorMessage.value,
            style: const TextStyle(color: Colors.red),
          );
        }
        if (controller.courses.isEmpty) {
          return const Text(
            'No courses available for selected semester. Please select department and semester.',
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student Internal ID: ${controller.createdStudentInternalId.value ?? 'N/A'}',
            ),
            const SizedBox(height: 16),
            const Text(
              'Select Courses:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...controller.courses.map((course) {
              return CheckboxListTile(
                title: Text(course.title ?? 'Unknown Course'),
                subtitle: Text(
                  'Code: ${course.courseCode ?? 'N/A'} - Credits: ${course.credits ?? 'N/A'}',
                ),
                value: controller.selectedCourses.contains(course),
                onChanged: (bool? value) {
                  controller.toggleCourseSelection(course);
                },
              );
            }).toList(),
          ],
        );
      }),
      isActive: _currentStep >= 2,
      state: _currentStep > 2 ? StepState.complete : StepState.indexed,
    ),
  ];
}
