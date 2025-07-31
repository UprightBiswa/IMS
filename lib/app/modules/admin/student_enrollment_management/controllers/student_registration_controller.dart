// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../constants/api_endpoints.dart';
// import '../../../../services/api_service.dart';
// import '../models/course_model.dart';
// import '../models/deepartment_model.dart';
// import '../models/semester_model.dart';
// import '../models/student_model.dart';
// import '../models/student_model_list.dart';
// import '../models/user_model.dart';

// class StudentRegistrationController extends GetxController {
//   final ApiService _apiService = ApiService();
//   RxList<StudentModelList> recentStudents = <StudentModelList>[].obs;
//   RxList<StudentModelList> idGeneratedList = <StudentModelList>[].obs;

//   // Form Controllers for User Registration
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();
//   final emailController = TextEditingController();
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();

//   // Student specific fields
//   final studentIdController = TextEditingController();
//   final enrollmentDateController = TextEditingController();

//   // Observables for dropdowns and API states
//   var departments = <Department>[].obs;
//   var selectedDepartment = Rx<Department?>(null);
//   var semesters = <SemesterData>[].obs; // Use SemesterData from semester_model
//   var selectedSemester = Rx<SemesterData?>(null);
//   var courses = <Course>[].obs;
//   var selectedCourses = <Course>[].obs; // For multi-select courses

//   // User and Student IDs after successful creation
//   var createdUserId = Rx<int?>(null);
//   var createdStudentInternalId = Rx<int?>(
//     null,
//   ); // This is the 'id' from the student creation response

//   // Loading and Error states
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadDummyData();
//     fetchDepartments();
//   }

//   @override
//   void onClose() {
//     usernameController.dispose();
//     passwordController.dispose();
//     emailController.dispose();
//     firstNameController.dispose();
//     lastNameController.dispose();
//     studentIdController.dispose();
//     enrollmentDateController.dispose();
//     super.onClose();
//   }

//   void loadDummyData() {
//     recentStudents.value = [
//       StudentModelList(
//         name: "Anaya Verma",
//         department: "B.Sc 1A",
//         status: "Present",
//       ),
//       StudentModelList(
//         name: "Rohan Mehta",
//         department: "B.Com 2B",
//         status: "Present",
//       ),
//       StudentModelList(
//         name: "Kavita Nair",
//         department: "B.Tech 3C",
//         status: "Absent",
//       ),
//       StudentModelList(
//         name: "Vikram Joshi",
//         department: "BBA 2A",
//         status: "Working",
//       ),
//     ];

//     idGeneratedList.value = [
//       StudentModelList(
//         name: "Anaya Verma",
//         studentId: "BSC2024IMS2005",
//         password: "TEST#123",
//         department: "",
//         status: "",
//       ),
//       StudentModelList(
//         name: "Rohan Mehta",
//         studentId: "BCOM2024IMS2025",
//         password: "TEST#123",
//         department: "",
//         status: "",
//       ),
//       StudentModelList(
//         name: "Kavita Nair",
//         studentId: "BTECH2024IMS2028",
//         password: "TEST#123",
//         department: "",
//         status: "",
//       ),
//       StudentModelList(
//         name: "Vikram Joshi",
//         studentId: "BBA2023IMS2125",
//         password: "TEST#123",
//         department: "",
//         status: "",
//       ),
//     ];
//   }
//   // --- API Calls ---

//   Future<void> fetchDepartments() async {
//     isLoading(true);
//     errorMessage('');
//     try {
//       final response = await _apiService.get(ApiEndpoints.departments);
//       if (response.statusCode == 200) {
//         departments.value =
//             DepartmentResponse.fromJson(response.data).items ?? [];
//         // Optionally pre-select the first department or clear if needed
//         selectedDepartment.value = null; // Clear previous selection
//       } else {
//         errorMessage.value =
//             'Failed to load departments: ${response.statusMessage}';
//       }
//     } catch (e) {
//       errorMessage.value = 'Error fetching departments: ${e.toString()}';
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<void> fetchSemesters(int departmentId) async {
//     isLoading(true);
//     errorMessage('');
//     try {
//       // Preference for semestersByDepartment endpoint if available
//       final response = await _apiService.get(
//         ApiEndpoints.allSemesters,
//       ); // Using ApiEndpoints
//       // Note: If you have an endpoint like /departments/{departmentId}/semesters,
//       // use it: `apiService.get(ApiEndpoints.semestersByDepartment(departmentId));`
//       // and adjust the parsing of `response.data` accordingly if its structure differs.

//       if (response.statusCode == 200) {
//         // Assuming /semesters returns a list under an 'items' key similar to departments
//         final List<dynamic> semesterListJson =
//             response.data['items']; // Adjust key based on actual API
//         semesters.value = semesterListJson
//             .map((json) => SemesterData.fromJson(json))
//             .where((s) => s.departmentId == departmentId)
//             .toList();
//         selectedSemester.value = null;
//       } else {
//         errorMessage.value =
//             'Failed to load semesters: ${response.statusMessage}';
//       }
//     } catch (e) {
//       errorMessage.value = 'Error fetching semesters: ${e.toString()}';
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<void> fetchCourses(int semesterId) async {
//     isLoading(true);
//     errorMessage('');
//     try {
//       final response = await _apiService.get(
//         ApiEndpoints.coursesBySemester(semesterId),
//       ); // Using ApiEndpoints
//       if (response.statusCode == 200) {
//         courses.value = CourseResponse.fromJson(response.data).data ?? [];
//         selectedCourses.clear(); // Clear previous selections
//       } else {
//         errorMessage.value =
//             'Failed to load courses: ${response.statusMessage}';
//       }
//     } catch (e) {
//       errorMessage.value = 'Error fetching courses: ${e.toString()}';
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<void> registerUser() async {
//     isLoading(true);
//     errorMessage('');
//     try {
//       final response = await _apiService.post(
//         ApiEndpoints.registerUser,
//         data: {
//           "username": usernameController.text,
//           "password": passwordController.text,
//           "email": emailController.text,
//           "first_name": firstNameController.text,
//           "last_name": lastNameController.text,
//           "role": "student",
//         },
//       );

//       if (response.statusCode == 201) {
//         final userModel = UserModel.fromJson(response.data);
//         createdUserId.value = userModel.user?.id;
//         Get.snackbar(
//           'Success',
//           'User registered successfully!',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green.shade100,
//         );
//       } else {
//         errorMessage.value =
//             response.data['message'] ??
//             'Failed to register user. Status: ${response.statusCode}';
//         Get.snackbar(
//           'Error',
//           errorMessage.value,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red.shade100,
//         );
//       }
//     } catch (e) {
//       errorMessage.value = 'Error registering user: ${e.toString()}';
//       Get.snackbar(
//         'Error',
//         errorMessage.value,
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red.shade100,
//       );
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<void> createStudent() async {
//     if (createdUserId.value == null || selectedSemester.value?.id == null) {
//       errorMessage.value = 'User not registered or semester not selected.';
//       Get.snackbar(
//         'Error',
//         errorMessage.value,
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red.shade100,
//       );
//       return;
//     }
//     isLoading(true);
//     errorMessage('');
//     try {
//       final response = await _apiService.post(
//         ApiEndpoints.createStudent,
//         data: {
//           "user_id": createdUserId.value,
//           "student_id": studentIdController.text,
//           "semester_id": selectedSemester.value!.id,
//           "enrollment_date": enrollmentDateController.text.isEmpty
//               ? DateTime.now().toIso8601String().split(
//                   'T',
//                 )[0] // Default to today
//               : enrollmentDateController.text,
//         },
//       );

//       if (response.statusCode == 201) {
//         final studentResponse = StudentCreationResponse.fromJson(response.data);
//         createdStudentInternalId.value = studentResponse.data?.id;
//         Get.snackbar(
//           'Success',
//           'Student created successfully!',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green.shade100,
//         );
//       } else {
//         errorMessage.value =
//             response.data['message'] ??
//             'Failed to create student. Status: ${response.statusCode}';
//         Get.snackbar(
//           'Error',
//           errorMessage.value,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red.shade100,
//         );
//       }
//     } catch (e) {
//       errorMessage.value = 'Error creating student: ${e.toString()}';
//       Get.snackbar(
//         'Error',
//         errorMessage.value,
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red.shade100,
//       );
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<void> enrollCourses() async {
//     if (createdStudentInternalId.value == null || selectedCourses.isEmpty) {
//       errorMessage.value = 'Student not created or no courses selected.';
//       Get.snackbar(
//         'Error',
//         errorMessage.value,
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red.shade100,
//       );
//       return;
//     }

//     isLoading(true);
//     errorMessage('');
//     try {
//       for (var course in selectedCourses) {
//         final response = await _apiService.post(
//           ApiEndpoints.enrollments,
//           data: {
//             "course_id": course.id,
//             "student_id": createdStudentInternalId.value,
//             "academic_year":
//                 selectedSemester.value?.academicYear ??
//                 DateTime.now().year.toString(), // Get from semester or default
//             "enrollment_date": DateTime.now().toIso8601String().split(
//               'T',
//             )[0], // Use current date for enrollment
//           },
//         );

//         if (response.statusCode != 201) {
//           errorMessage.value =
//               'Failed to enroll in course ${course.title}: ${response.data['message'] ?? response.statusMessage}';
//           Get.snackbar(
//             'Error',
//             errorMessage.value,
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.red.shade100,
//           );
//           isLoading(false);
//           return; // Stop on first error
//         }
//       }
//       Get.snackbar(
//         'Success',
//         'Student enrolled in selected courses successfully!',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green.shade100,
//       );
//     } catch (e) {
//       errorMessage.value = 'Error enrolling courses: ${e.toString()}';
//       Get.snackbar(
//         'Error',
//         errorMessage.value,
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red.shade100,
//       );
//     } finally {
//       isLoading(false);
//     }
//   }

//   // --- UI Helpers ---

//   void onDepartmentSelected(Department? department) {
//     selectedDepartment.value = department;
//     selectedSemester.value = null; // Clear semester when department changes
//     courses.clear(); // Clear courses
//     selectedCourses.clear(); // Clear selected courses
//     if (department != null && department.id != null) {
//       fetchSemesters(department.id!);
//     } else {
//       semesters.clear();
//     }
//   }

//   void onSemesterSelected(SemesterData? semester) {
//     selectedSemester.value = semester;
//     courses.clear(); // Clear courses
//     selectedCourses.clear(); // Clear selected courses
//     if (semester != null && semester.id != null) {
//       fetchCourses(semester.id!);
//     } else {
//       courses.clear();
//     }
//   }

//   void toggleCourseSelection(Course course) {
//     if (selectedCourses.contains(course)) {
//       selectedCourses.remove(course);
//     } else {
//       selectedCourses.add(course);
//     }
//   }

//   void resetForm() {
//     usernameController.clear();
//     passwordController.clear();
//     emailController.clear();
//     firstNameController.clear();
//     lastNameController.clear();
//     studentIdController.clear();
//     enrollmentDateController.clear();

//     selectedDepartment.value = null;
//     departments.clear(); // Refetch departments on reset
//     selectedSemester.value = null;
//     semesters.clear();
//     courses.clear();
//     selectedCourses.clear();

//     createdUserId.value = null;
//     createdStudentInternalId.value = null;
//     errorMessage.value = '';
//     fetchDepartments(); // Re-fetch departments to restart
//   }
// }

// lib/app/modules/student_registration/controllers/student_registration_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/api_endpoints.dart'; // Adjust path if necessary
import '../../../../services/api_service.dart'; // Adjust path if necessary
import '../models/course_model.dart';
import '../models/deepartment_model.dart'; // Corrected spelling based on your import
import '../models/semester_model.dart';
import '../models/student_model.dart';
import '../models/student_model_list.dart';
import '../models/user_model.dart'; // Assuming this is still needed for dummy data

class StudentRegistrationController extends GetxController {
  final ApiService _apiService = ApiService();

  RxList<StudentModelList> recentStudents = <StudentModelList>[].obs;
  RxList<StudentModelList> idGeneratedList = <StudentModelList>[].obs;

  // Form Controllers for User Registration
  final usernameController = TextEditingController();
  final passwordController = TextEditingController(
    text: 'test123#',
  ); // Pre-filled password
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  // Student specific fields
  final studentIdController = TextEditingController();
  final enrollmentDateController = TextEditingController();

  // Observables for dropdowns and API states
  var departments = <Department>[].obs;
  var selectedDepartment = Rx<Department?>(null);
  var semesters = <SemesterData>[].obs;
  var selectedSemester = Rx<SemesterData?>(null);
  var courses = <Course>[].obs;
  var selectedCourses = <Course>[].obs; // For multi-select courses

  // User and Student IDs after successful creation
  var createdUserId = Rx<int?>(null);
  var createdStudentInternalId = Rx<int?>(
    null,
  ); // This is the 'id' from the student creation response

  // Loading and Error states
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize password here if you want to allow clearing it later
    // passwordController.text = 'test123#';
    loadDummyData(); // Keep your dummy data loading if needed
    fetchDepartments();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    studentIdController.dispose();
    enrollmentDateController.dispose();
    super.onClose();
  }

  void loadDummyData() {
    // Your existing dummy data loading logic
    recentStudents.value = [
      StudentModelList(
        name: "Anaya Verma",
        department: "B.Sc 1A",
        status: "Present",
      ),
      StudentModelList(
        name: "Rohan Mehta",
        department: "B.Com 2B",
        status: "Present",
      ),
      StudentModelList(
        name: "Kavita Nair",
        department: "B.Tech 3C",
        status: "Absent",
      ),
      StudentModelList(
        name: "Vikram Joshi",
        department: "BBA 2A",
        status: "Working",
      ),
    ];

    idGeneratedList.value = [
      StudentModelList(
        name: "Anaya Verma",
        studentId: "BSC2024IMS2005",
        password: "TEST#123",
        department: "",
        status: "",
      ),
      StudentModelList(
        name: "Rohan Mehta",
        studentId: "BCOM2024IMS2025",
        password: "TEST#123",
        department: "",
        status: "",
      ),
      StudentModelList(
        name: "Kavita Nair",
        studentId: "BTECH2024IMS2028",
        password: "TEST#123",
        department: "",
        status: "",
      ),
      StudentModelList(
        name: "Vikram Joshi",
        studentId: "BBA2023IMS2125",
        password: "TEST#123",
        department: "",
        status: "",
      ),
    ];
  }

  // --- API Calls ---

  Future<void> fetchDepartments() async {
    isLoading(true);
    errorMessage('');
    try {
      final response = await _apiService.get(ApiEndpoints.departments);
      if (response.statusCode == 200) {
        departments.value =
            DepartmentResponse.fromJson(response.data).items ?? [];
        selectedDepartment.value = null; // Clear previous selection
      } else {
        errorMessage.value =
            'Failed to load departments: ${response.statusMessage}';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching departments: ${e.toString()}';
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchSemesters(int departmentId) async {
    isLoading(true);
    errorMessage('');
    try {
      // Using the specific endpoint for semesters by department
      final response = await _apiService.get(
        ApiEndpoints.semestersByDepartment(departmentId),
      );

      if (response.statusCode == 200) {
        // Parse the entire response using your SemesterResponse model
        final semesterResponse = SemesterResponse.fromJson(response.data);

        // Assign the list of SemesterData from the 'data' field
        semesters.value = semesterResponse.data ?? [];
        selectedSemester.value = null;
      } else {
        errorMessage.value =
            'Failed to load semesters: ${response.statusMessage}';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching semesters: ${e.toString()}';
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchCourses(int semesterId) async {
    isLoading(true);
    errorMessage('');
    try {
      final response = await _apiService.get(
        ApiEndpoints.coursesBySemester(semesterId),
      );
      if (response.statusCode == 200) {
        courses.value = CourseResponse.fromJson(response.data).data ?? [];
        selectedCourses.clear(); // Clear previous selections
      } else {
        errorMessage.value =
            'Failed to load courses: ${response.statusMessage}';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching courses: ${e.toString()}';
    } finally {
      isLoading(false);
    }
  }

  Future<void> registerUser() async {
    isLoading(true);
    errorMessage('');
    try {
      final response = await _apiService.post(
        ApiEndpoints.registerUser,
        data: {
          "username": usernameController.text,
          "password": passwordController.text, // Will be pre-filled
          "email": emailController.text,
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "role": "student", // Default role
        },
      );

      if (response.statusCode == 201) {
        final userModel = UserModel.fromJson(response.data);
        createdUserId.value = userModel.user?.id;
        Get.snackbar(
          'Success',
          'User registered successfully! User ID: ${createdUserId.value}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
        );
      } else {
        errorMessage.value =
            response.data['message'] ??
            'Failed to register user. Status: ${response.statusCode}';
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
        );
      }
    } catch (e) {
      errorMessage.value = 'Error registering user: ${e.toString()}';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> createStudent() async {
    if (createdUserId.value == null || selectedSemester.value?.id == null) {
      errorMessage.value = 'User not registered or semester not selected.';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
      return;
    }
    isLoading(true);
    errorMessage('');
    try {
      final response = await _apiService.post(
        ApiEndpoints.createStudent,
        data: {
          "user_id": createdUserId.value, // Using the ID from user registration
          "student_id": studentIdController.text,
          "semester_id": selectedSemester.value!.id,
          "enrollment_date": enrollmentDateController.text.isEmpty
              ? DateTime.now().toIso8601String().split('T')[0]
              : enrollmentDateController.text,
        },
      );

      if (response.statusCode == 201) {
        final studentResponse = StudentCreationResponse.fromJson(response.data);
        createdStudentInternalId.value =
            studentResponse.data?.id; // Storing the internal student ID
        Get.snackbar(
          'Success',
          'Student created successfully! Student Internal ID: ${createdStudentInternalId.value}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
        );
      } else {
        errorMessage.value =
            response.data['message'] ??
            'Failed to create student. Status: ${response.statusCode}';
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
        );
      }
    } catch (e) {
      errorMessage.value = 'Error creating student: ${e.toString()}';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> enrollCourses() async {
    if (createdStudentInternalId.value == null || selectedCourses.isEmpty) {
      errorMessage.value = 'Student not created or no courses selected.';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
      return;
    }

    isLoading(true);
    errorMessage('');
    try {
      for (var course in selectedCourses) {
        final response = await _apiService.post(
          ApiEndpoints.enrollments,
          data: {
            "course_id": course.id,
            "student_id":
                createdStudentInternalId.value, // Using the internal student ID
            "academic_year":
                selectedSemester.value?.academicYear ??
                DateTime.now().year.toString(),
            "enrollment_date": DateTime.now().toIso8601String().split('T')[0],
          },
        );

        if (response.statusCode != 201) {
          errorMessage.value =
              'Failed to enroll in course ${course.title}: ${response.data['message'] ?? response.statusMessage}';
          Get.snackbar(
            'Error',
            errorMessage.value,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.shade100,
          );
          isLoading(false);
          return; // Stop on first error
        }
      }
      Get.snackbar(
        'Success',
        'Student enrolled in selected courses successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
      );
    } catch (e) {
      errorMessage.value = 'Error enrolling courses: ${e.toString()}';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
    } finally {
      isLoading(false);
    }
  }

  // --- UI Helpers ---

  void onDepartmentSelected(Department? department) {
    selectedDepartment.value = department;
    selectedSemester.value = null; // Clear semester when department changes
    courses.clear(); // Clear courses
    selectedCourses.clear(); // Clear selected courses
    if (department != null && department.id != null) {
      fetchSemesters(department.id!);
    } else {
      semesters.clear();
    }
  }

  void onSemesterSelected(SemesterData? semester) {
    selectedSemester.value = semester;
    courses.clear(); // Clear courses
    selectedCourses.clear(); // Clear selected courses
    if (semester != null && semester.id != null) {
      fetchCourses(semester.id!);
    } else {
      courses.clear();
    }
  }

  void toggleCourseSelection(Course course) {
    if (selectedCourses.contains(course)) {
      selectedCourses.remove(course);
    } else {
      selectedCourses.add(course);
    }
  }

  void resetForm() {
    usernameController.clear();
    // Keep password pre-filled or clear it based on preference after successful registration
    // passwordController.clear();
    emailController.clear();
    firstNameController.clear();
    lastNameController.clear();
    studentIdController.clear();
    enrollmentDateController.clear();

    selectedDepartment.value = null;
    departments.clear(); // Refetch departments on reset
    selectedSemester.value = null;
    semesters.clear();
    courses.clear();
    selectedCourses.clear();

    createdUserId.value = null;
    createdStudentInternalId.value = null;
    errorMessage.value = '';
    fetchDepartments(); // Re-fetch departments to restart
  }
}
