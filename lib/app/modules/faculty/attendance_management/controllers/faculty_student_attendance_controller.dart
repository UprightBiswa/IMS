// // lib/app/modules/faculty_student_attendance/controllers/faculty_student_attendance_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dio/dio.dart' as dio;
// import 'package:intl/intl.dart';

// import 'package:logger/logger.dart';
// import '../../../../constants/api_endpoints.dart';
// import '../../../../services/api_service.dart';
// import '../../../../theme/app_colors.dart';
// import '../models/attendance_marking_status_response_model.dart';
// import '../models/session_for_date_model.dart';
// import '../models/session_for_marking_model.dart';
// import '../models/student_attendance_model.dart'; // Import student attendance models

// class FacultyStudentAttendanceController extends GetxController {
//   final ApiService _apiService = ApiService();
//   final Logger _logger = Logger();

//   // Tabs for FacultyStudentAttendanceTab (Dashboard, Record, Mark)
//   final RxInt selectedStudentSubTab = 0.obs;

//   // Tabs for FacultyStudentAttendanceDashboardView (Overview, Classes, Students)
//   final RxInt selectedDashboardTab = 0.obs;

//   // Loading/Error states
//   final RxBool isLoading = true.obs;
//   final RxBool isError = false.obs;
//   final RxString errorMessage = ''.obs;

//   // --- Dashboard Data ---
//   final Rx<OverallStudentAttendanceSummary?> overallSummary =
//       Rx<OverallStudentAttendanceSummary?>(null);
//   final RxList<ClassAttendanceSnapshot> classSnapshots =
//       <ClassAttendanceSnapshot>[].obs;
//   final RxList<RecentClass> recentClasses = <RecentClass>[].obs;

//   // Mark Attendance Tab Data
//   final RxList<SessionForMarkingModel> todaySessions =
//       <SessionForMarkingModel>[].obs;
//   final Rx<SessionForMarkingModel?> selectedSession =
//       Rx<SessionForMarkingModel?>(null);

//   // NEW: Rx variable to store attendance marking status response
//   final Rx<AttendanceMarkingStatusResponse?> attendanceMarkingStatusResponse =
//       Rx<AttendanceMarkingStatusResponse?>(null);

//   final RxList<StudentBasicInfo> studentList = <StudentBasicInfo>[].obs;

//   // Filter properties for student-wise attendance
//   final RxList<String> departmentFilters =
//       <String>[].obs; // To store available department names
//   final RxnString selectedDepartmentFilter = RxnString(); // Selected department
//   final RxList<String> courseFilters =
//       <String>[].obs; // To store available course names
//   final RxnString selectedCourseFilter = RxnString(); // Selected course
//   final RxList<String> semesterFilters =
//       <String>[].obs; // To store available semester names
//   final RxnString selectedSemesterFilter = RxnString(); // Selected semester
//   final RxList<String> attendanceStatusFilters = [
//     'All',
//     'Present',
//     'Absent',
//     'Late',
//     'Excused',
//     'Low Attendance',
//   ].obs;
//   final RxString selectedAttendanceStatusFilter =
//       'All'.obs; // Selected attendance status

//   // For Mark UI (existing)
//   final RxList<String> courses = ['B.Sc Physics', 'B.Com', 'B.Tech', 'BBA'].obs;
//   final RxString selectedCourse = 'B.Sc Physics'.obs;
//   final RxList<String> sections = ['Section A', 'D', 'C'].obs; // Dummy sections
//   final RxString selectedSection = 'Section A'.obs;
//   final RxList<String> subjects = ['Mechanics', 'Thermodynamics', 'Optics'].obs;
//   final RxString selectedSubject = 'Mechanics'.obs;
//   final RxList<String> subSubjects = [
//     'BMGT 321',
//     'DESGN 401',
//     'HIST 201',
//   ].obs; // For Mark UI
//   final RxString selectedSubSubject = ''.obs; // Initially empty
//   final Rx<DateTime> markAttendanceDate = DateTime.now().obs;
//   final RxBool showPreviousAttendance = false.obs;
//   final RxList<StudentAttendanceMark> studentsForMarking =
//       <StudentAttendanceMark>[].obs;

//   // --- Attendance Records Tab Data ---
//   final RxInt selectedRecordView = 0.obs; // 0: List View, 1: Calendar Show
//   final RxList<String> recordSubjects = [
//     'Mechanics',
//     'Chemistry',
//     'Biology',
//   ].obs; // Filter options
//   final RxString selectedRecordSubject = 'Mechanics'.obs;
//   final RxList<String> recordSections = [
//     'Section A',
//     'Section B',
//     'Section C',
//   ].obs;
//   final RxString selectedRecordSection = 'Section A'.obs;
//   final Rx<DateTime> recordSelectedDate = DateTime.now().obs;
//   final RxList<StudentRecord> studentRecords = StudentRecord.dummyList().obs;
//   final RxString recordSearchQuery = ''.obs;

//   // Pagination for sessions
//   final RxInt currentPage = 1.obs;
//   final RxInt perPage = 20.obs;
//   final RxInt totalPages = 1.obs;
//   final RxInt totalSessions = 0.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     // Initialize data for mark attendance tab
//     fetchStudentAttendanceDashboard();
//     fetchTodaySessions();
//     fetchStudentWiseAttendance(); // Fetch student-wise attendance on init
//   }

//   void changeStudentSubTab(int index) {
//     selectedStudentSubTab.value = index;
//     if (index == 2) {
//       // If navigating to Mark tab
//       fetchTodaySessions(); // Ensure sessions are loaded
//     }
//   }

//   void changeDashboardTab(int index) {
//     selectedDashboardTab.value = index;
//   }

//   // --- Filter methods for student-wise attendance ---
//   void selectDepartmentFilter(String? department) {
//     if (department != null) {
//       selectedDepartmentFilter.value = department;
//       fetchStudentWiseAttendance();
//     }
//   }

//   void selectCourseFilter(String? course) {
//     if (course != null) {
//       selectedCourseFilter.value = course;
//       fetchStudentWiseAttendance();
//     }
//   }

//   void selectSemesterFilter(String? semester) {
//     if (semester != null) {
//       selectedSemesterFilter.value = semester;
//       fetchStudentWiseAttendance();
//     }
//   }

//   void selectAttendanceStatusFilter(String? status) {
//     if (status != null) {
//       selectedAttendanceStatusFilter.value = status;
//       fetchStudentWiseAttendance();
//     }
//   }

//   // --- API Calls ---
//   Future<void> fetchStudentAttendanceDashboard() async {
//     try {
//       isLoading.value = true;
//       isError.value = false;
//       errorMessage.value = '';

//       final response = await ApiService().get(
//         ApiEndpoints.FACULTY_STUDENT_ATTENDANCE_DASHBOARD_MAPP,
//       );

//       final data = response.data['data']['faculty_data'];

//       overallSummary.value = OverallStudentAttendanceSummary.fromJson(
//         data['overall_attendance'],
//       );

//       classSnapshots.value = (data['class_wise_attendance'] as List)
//           .map((e) => ClassAttendanceSnapshot.fromJson(e))
//           .toList();

//       recentClasses.value = (data['recent_classes'] as List)
//           .map((e) => RecentClass.fromJson(e))
//           .toList();
//     } catch (e) {
//       isError.value = true;
//       errorMessage.value = 'Error: ${e.toString()}';
//       // print('error:${e.toString()}');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> fetchStudentWiseAttendance({int? departmentId}) async {
//     try {
//       isLoading.value = true;
//       isError.value = false;
//       errorMessage.value = '';

//       // Construct query parameters based on selected filters
//       final Map<String, dynamic> queryParams = {};
//       if (departmentId != null) {
//         queryParams['department_id'] = departmentId;
//       }
//       if (selectedCourseFilter.value != null &&
//           selectedCourseFilter.value != 'All') {
//         // You'll need a way to map course names to IDs if your API expects IDs
//         queryParams['course_id'] = selectedCourseFilter.value; // Placeholder
//       }
//       if (selectedSemesterFilter.value != null &&
//           selectedSemesterFilter.value != 'All') {
//         // You'll need a way to map semester names to IDs if your API expects IDs
//         queryParams['semester_id'] =
//             selectedSemesterFilter.value; // Placeholder
//       }
//       if (selectedAttendanceStatusFilter.value != 'All') {
//         queryParams['attendance_filter'] = selectedAttendanceStatusFilter.value
//             .toLowerCase();
//       }

//       final response = await ApiService().get(
//         ApiEndpoints.FACULTY_STUDENTWISE_ATTENDANCE_MAPP,
//         queryParameters: queryParams,
//       );

//       final studentData = response.data['data']['student_data'];
//       final List<dynamic> studentsJson = studentData['student_wise_attendance'];
//       final Map<String, dynamic> filterInfo = studentData['filter_info'];
//       final Map<String, dynamic> contextInfo = studentData['context_info'];

//       studentList.value = studentsJson
//           .map((e) => StudentBasicInfo.fromJson(e))
//           .toList();

//       // Populate filter options from API response (if available in filter_info or metadata)
//       // This is a simplified example. In a real app, you'd likely have separate API endpoints for filter options.
//       if (contextInfo['department'] != null &&
//           contextInfo['department']['department_name'] != null) {
//         departmentFilters.value = [
//           contextInfo['department']['department_name'],
//         ];
//         // Set the selected department to the one returned by the API
//         selectedDepartmentFilter.value =
//             contextInfo['department']['department_name'];
//       } else {
//         departmentFilters.value = [
//           'Computer Science',
//           'Physics',
//           'Mathematics',
//           'Chemistry',
//         ]; // Dummy options
//         selectedDepartmentFilter.value = departmentFilters.first;
//       }
//       // Assuming 'courses' and 'semesters' arrays might be in filter_info or another endpoint
//       courseFilters.value = [
//         'All',
//         'Physics I',
//         'Mathematics I',
//         'Database Systems',
//         'Programming Fundamentals',
//       ]; // Dummy options
//       semesterFilters.value = [
//         'All',
//         'Semester 1',
//         'Semester 2',
//       ]; // Dummy options
//     } catch (e) {
//       isError.value = true;
//       print('error:${e.toString()}');

//       errorMessage.value = 'Error fetching students: ${e.toString()}';
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Fetch Today's Sessions for Mark Attendance
//   Future<void> fetchTodaySessions() async {
//     isLoading.value = true;
//     errorMessage.value = '';
//     try {
//       final String formattedDate = DateFormat(
//         'yyyy-MM-dd',
//       ).format(markAttendanceDate.value);

//       final response = await _apiService.get(
//         ApiEndpoints.FACULTY_TODAY_SESSIONS,
//         queryParameters: {'session_date': formattedDate},
//       );
//       final List<dynamic> sessionsJson = response.data['data']['sessions'];
//       todaySessions.value = sessionsJson
//           .map((json) => SessionForMarkingModel.fromJson(json))
//           .toList();
//       if (todaySessions.isNotEmpty) {
//         courses.value = todaySessions
//             .map((s) => s.courseTitle)
//             .toSet()
//             .toList();
//         selectedCourse.value = courses.first;

//         sections.value = todaySessions
//             .where((s) => s.courseTitle == selectedCourse.value)
//             .map((s) => s.location)
//             .toSet()
//             .toList();
//         if (sections.isNotEmpty) selectedSection.value = sections.first;

//         subjects.value = todaySessions
//             .where(
//               (s) =>
//                   s.courseTitle == selectedCourse.value &&
//                   s.location == selectedSection.value,
//             )
//             .map((s) => s.topic)
//             .toSet()
//             .toList();
//         if (subjects.isNotEmpty) selectedSubject.value = subjects.first;

//         subSubjects.clear();

//         selectedSession.value = todaySessions.firstWhereOrNull(
//           (s) =>
//               s.courseTitle == selectedCourse.value &&
//               s.location == selectedSection.value &&
//               s.topic == selectedSubject.value,
//         );
//         // If a session is found and has a markingSessionUuid, fetch its status
//         if (selectedSession.value != null &&
//             selectedSession.value!.markingSessionUuid.isNotEmpty) {
//           await fetchAttendanceMarkingStatus(
//             selectedSession.value!.markingSessionUuid,
//           );
//         } else {
//           // If no markingSessionUuid or no session, clear studentsForMarking
//           studentsForMarking.clear();
//           attendanceMarkingStatusResponse.value = null;
//         }
//       } else {
//         selectedSession.value = null; // No sessions available
//         studentsForMarking.clear(); // Clear students if no sessions
//         attendanceMarkingStatusResponse.value = null;
//       }
//     } catch (e) {
//       errorMessage.value =
//           'An unexpected error occurred fetching sessions: ${e.toString()}';
//       _logger.e('Error fetching today sessions: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // NEW: Function to fetch attendance marking status
//   Future<void> fetchAttendanceMarkingStatus(String markingSessionUuid) async {
//     isLoading.value = true;
//     errorMessage.value = '';
//     attendanceMarkingStatusResponse.value = null; // Clear previous data
//     studentsForMarking.clear(); // Clear students list before fetching new ones

//     try {
//       // Construct the API endpoint with the session UUID
//       final String apiUrl = ApiEndpoints.FACULTY_ATTENDANCE_MARKING_STATUS(
//         markingSessionUuid,
//       );
//       final response = await _apiService.get(apiUrl);

//       print(response.data);

//       final parsedResponse = AttendanceMarkingStatusResponse.fromJson(
//         response.data,
//       );
//       attendanceMarkingStatusResponse.value = parsedResponse;

//       // Populate studentsForMarking from the fetched data
//       studentsForMarking.value = parsedResponse.data.students.map((
//         studentDetail,
//       ) {
//         // Map API status to the display status used in StudentAttendanceMark
//         String displayStatus;
//         switch (studentDetail.status) {
//           case 'present':
//             displayStatus = 'Present';
//             break;
//           case 'absent':
//             displayStatus = 'Absent';
//             break;
//           case 'late':
//             displayStatus = 'Late';
//             break;
//           case 'excused':
//             displayStatus = 'Excused';
//             break;
//           case 'not_marked':
//           default:
//             displayStatus = 'Unmarked';
//             break;
//         }
//         return StudentAttendanceMark(
//           id: studentDetail.studentId.toString(),
//           rollNo: studentDetail.studentCode,
//           name: studentDetail.name,
//           initialStatus: displayStatus,
//         );
//       }).toList();
//     } catch (e) {
//       errorMessage.value =
//           'An unexpected error occurred fetching attendance status: ${e.toString()}';
//       _logger.e('Error fetching attendance marking status: $e');
//       attendanceMarkingStatusResponse.value = null; // Clear on error
//       studentsForMarking.clear(); // Clear students on error
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // --- Mark Attendance Methods (existing) ---
//   void selectCourse(String? course) {
//     if (course != null) {
//       selectedCourse.value = course;
//       selectedSubject.value = subjects.first;
//       selectedSubSubject.value = '';
//       filterStudentsForMarking();
//     }
//   }

//   void selectSection(String? section) {
//     if (section != null) {
//       selectedSection.value = section;
//       filterStudentsForMarking();
//     }
//   }

//   void selectSubject(String? subject) {
//     if (subject != null) {
//       selectedSubject.value = subject;
//       selectedSubSubject.value = '';
//       filterStudentsForMarking();
//     }
//   }

//   void selectSubSubject(String? subSubject) {
//     if (subSubject != null) {
//       selectedSubSubject.value = subSubject;
//       filterStudentsForMarking();
//     }
//   }

//   void selectMarkAttendanceDate(DateTime date) {
//     markAttendanceDate.value = date;
//     filterStudentsForMarking();
//     fetchTodaySessions();
//   }

//   void selectSessionForMarking(SessionForMarkingModel? session) async {
//     selectedSession.value = session;
//     if (session != null && session.markingSessionUuid.isNotEmpty) {
//       await fetchAttendanceMarkingStatus(session.markingSessionUuid);
//     } else {
//       studentsForMarking.clear();
//       attendanceMarkingStatusResponse.value = null;
//     }
//   }

//   void toggleShowPreviousAttendance(bool? value) {
//     if (value != null) {
//       showPreviousAttendance.value = value;
//     }
//   }

//   void updateStudentMarkStatus(String studentId, String status) {
//     final index = studentsForMarking.indexWhere((s) => s.id == studentId);
//     if (index != -1) {
//       studentsForMarking[index].status.value = status;
//     }
//   }

//   void filterStudentsForMarking() {}

//   void submitMarkedAttendance() {
//     print('Submitting attendance:');
//     for (var student in studentsForMarking) {
//       print('${student.name}: ${student.status.value}');
//     }
//     Get.snackbar(
//       'Success',
//       'Attendance submitted for ${studentsForMarking.length} students.',
//       backgroundColor: Get.theme.colorScheme.secondary,
//       colorText: Get.theme.colorScheme.onSecondary,
//     );
//   }

//   void changeRecordView(int index) {
//     selectedRecordView.value = index;
//   }

//   void selectRecordSubject(String? subject) {
//     if (subject != null) {
//       selectedRecordSubject.value = subject;
//       _filterStudentRecords();
//     }
//   }

//   void selectRecordSection(String? section) {
//     if (section != null) {
//       selectedRecordSection.value = section;
//       _filterStudentRecords();
//     }
//   }

//   void selectRecordDate(DateTime date) {
//     recordSelectedDate.value = date;
//     _filterStudentRecords();
//   }

//   void updateRecordSearchQuery(String query) {
//     recordSearchQuery.value = query;
//     _filterStudentRecords();
//   }

//   void _filterStudentRecords() {
//     List<StudentRecord> filteredList = StudentRecord.dummyList();

//     if (selectedRecordSubject.isNotEmpty) {
//       filteredList = filteredList
//           .where((record) => record.subject == selectedRecordSubject.value)
//           .toList();
//     }
//     if (selectedRecordSection.isNotEmpty) {
//       filteredList = filteredList
//           .where((record) => record.section == selectedRecordSection.value)
//           .toList();
//     }
//     filteredList = filteredList
//         .where(
//           (record) =>
//               record.name.toLowerCase().contains(
//                 recordSearchQuery.value.toLowerCase(),
//               ) ||
//               record.rollNo.toLowerCase().contains(
//                 recordSearchQuery.value.toLowerCase(),
//               ),
//         )
//         .toList();

//     studentRecords.value = filteredList;
//   }

//   // Start Attendance Marking API call (after image upload)
//   Future<bool> startAttendanceMarking(String imagePath, String notes) async {
//     isLoading.value = true;
//     errorMessage.value = '';
//     try {
//       if (selectedSession.value == null) {
//         Get.snackbar(
//           'Error',
//           'Please select a session before uploading an image.',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//         isLoading.value = false;
//         return false;
//       }
//       // Create FormData for file upload
//       String fileName = imagePath.split('/').last;
//       dio.FormData formData = dio.FormData.fromMap({
//         "photo": await dio.MultipartFile.fromFile(
//           imagePath,
//           filename: fileName,
//         ),

//         "session_id": selectedSession.value!.sessionId
//             .toString(), // Use sessionId and convert to string
//         "notes": notes,
//       });

//       _logger.i(
//         'Calling start_attendance_marking for session ID: ${selectedSession.value!.sessionId}',
//       );
//       _logger.i('Notes: $notes');
//       _logger.i('Image path: $imagePath');

//       // Actual API call using ApiService's postFormData
//       final response = await _apiService.postFormData(
//         ApiEndpoints.FACULTY_START_ATTENDANCE_MARKING,
//         formData: formData,
//       );

//       if (response.statusCode == 200) {
//         Get.back(); // Navigate back to the previous screen (Mark Attendance tab)

//         Get.snackbar(
//           'Success',
//           'Attendance marking initiated successfully!',
//           backgroundColor: AppColors.primaryGreen,
//           colorText: Colors.white,
//         );
//         return true; // Ensure we are on the Mark tab
//       } else {
//         errorMessage.value =
//             'Failed to initiate attendance marking. Please try again.';
//         Get.snackbar(
//           'Error',
//           errorMessage.value,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//         return true;
//       }
//     } catch (e) {
//       errorMessage.value = 'An unexpected error occurred: ${e.toString()}';
//       _logger.e('Error starting attendance marking: $e');
//       Get.snackbar(
//         'Error',
//         'An unexpected error occurred: ${e.toString()}',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return false;
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }




//   // // MODIFIED: fetchTodaySessions to use the new API endpoint with date and pagination
//   // Future<void> fetchTodaySessions({int page = 1, int perPage = 20}) async {
//   //   isLoading.value = true;
//   //   errorMessage.value = '';
//   //   try {
//   //     final String formattedDate = DateFormat('yyyy-MM-dd').format(markAttendanceDate.value);
//   //     final response = await _apiService.get(
//   //       ApiEndpoints.FACULTY_SESSIONS_FILTERED,
//   //       queryParameters: {
//   //         'page': page,
//   //         'per_page': perPage,
//   //         'session_date': formattedDate,
//   //         // 'course_id': 1, // Uncomment and set if needed
//   //         // 'faculty_id': 1, // Uncomment and set if needed
//   //         // 'session_type': 'lecture', // Uncomment and set if needed
//   //         // 'start_date': '2024-01-01', // Uncomment and set if needed
//   //         // 'end_date': '2024-01-31', // Uncomment and set if needed
//   //       },
//   //     );

//   //     final sessionListResponse = SessionListResponse.fromJson(response.data);

//   //     // Update pagination info
//   //     currentPage.value = sessionListResponse.pagination.currentPage;
//   //     this.perPage.value = sessionListResponse.pagination.perPage;
//   //     totalPages.value = sessionListResponse.pagination.totalPages;
//   //     totalSessions.value = sessionListResponse.pagination.totalRecords;

//   //     // Map SessionItem to SessionForMarkingModel
//   //     todaySessions.value = sessionListResponse.sessions.map((sessionItem) {
//   //       return SessionForMarkingModel(
//   //         sessionId: sessionItem.id,
//   //         courseCode: sessionItem.courseCode,
//   //         courseTitle: sessionItem.courseTitle,
//   //         durationMinutes: sessionItem.durationMinutes,
//   //         enrolledStudents: 0, // This info is not in SessionItem, default to 0
//   //         location: sessionItem.location,
//   //         // markingSessionUuid and markingStatus are not in this API response.
//   //         // They must come from the attendance_marking_status API or be handled differently.
//   //         // For now, setting them to null.
//   //         markingSessionUuid: sessionItem.id.toString(),
//   //         markingStatus: sessionItem.sessionTime,
//   //         sessionTime: sessionItem.sessionTime,
//   //         topic: sessionItem.topic,
//   //         sessionType: sessionItem.sessionType,
//   //       );
//   //     }).toList();

//   //     if (todaySessions.isNotEmpty) {
//   //       // Update dropdowns based on the first session or a default logic
//   //       // This logic might need refinement if you want to preserve user's previous selections
//   //       // across date changes. For simplicity, we'll select the first available.
//   //       selectedCourse.value = todaySessions.first.courseTitle;
//   //       sections.value = todaySessions
//   //           .where((s) => s.courseTitle == selectedCourse.value)
//   //           .map((s) => s.location)
//   //           .toSet()
//   //           .toList();
//   //       if (sections.isNotEmpty) selectedSection.value = sections.first;

//   //       subjects.value = todaySessions
//   //           .where((s) =>
//   //               s.courseTitle == selectedCourse.value &&
//   //               s.location == selectedSection.value)
//   //           .map((s) => s.topic)
//   //           .toSet()
//   //           .toList();
//   //       if (subjects.isNotEmpty) selectedSubject.value = subjects.first;

//   //       subSubjects.clear();

//   //       selectedSession.value = todaySessions.firstWhereOrNull(
//   //         (s) =>
//   //             s.courseTitle == selectedCourse.value &&
//   //             s.location == selectedSection.value &&
//   //             s.topic == selectedSubject.value,
//   //       );

//   //       // Check if markingSessionUuid is available before attempting to fetch marking status
//   //       if (selectedSession.value != null && selectedSession.value!.markingSessionUuid != null && selectedSession.value!.markingSessionUuid!.isNotEmpty) {
//   //         await fetchAttendanceMarkingStatus(selectedSession.value!.markingSessionUuid!);
//   //       } else {
//   //         studentsForMarking.clear();
//   //         attendanceMarkingStatusResponse.value = null;
//   //       }
//   //     } else {
//   //       selectedSession.value = null;
//   //       studentsForMarking.clear();
//   //       attendanceMarkingStatusResponse.value = null;
//   //       // Also clear course/section/subject dropdowns if no sessions
//   //       courses.clear();
//   //       sections.clear();
//   //       subjects.clear();
//   //       subSubjects.clear();
//   //       selectedCourse.value = '';
//   //       selectedSection.value = '';
//   //       selectedSubject.value = '';
//   //       selectedSubSubject.value = '';
//   //     }
//   //   }  catch (e) {
//   //     errorMessage.value =
//   //         'An unexpected error occurred fetching sessions: ${e.toString()}';
//   //     _logger.e('Error fetching today sessions: $e');
//   //     todaySessions.clear(); // Clear sessions on error
//   //     selectedSession.value = null;
//   //     studentsForMarking.clear();
//   //     attendanceMarkingStatusResponse.value = null;
//   //   } finally {
//   //     isLoading.value = false;
//   //   }
//   // }

//   // // New method to load next page of sessions
//   // Future<void> loadNextPageSessions() async {
//   //   if (currentPage.value < totalPages.value && !isLoading.value) {
//   //     currentPage.value++;
//   //     await fetchTodaySessions(page: currentPage.value, perPage: perPage.value);
//   //   }
//   // }

//   // // New method to load previous page of sessions
//   // Future<void> loadPreviousPageSessions() async {
//   //   if (currentPage.value > 1 && !isLoading.value) {
//   //     currentPage.value--;
//   //     await fetchTodaySessions(page: currentPage.value, perPage: perPage.value);
//   //   }
//   // }


// lib/app/modules/faculty_student_attendance/controllers/faculty_student_attendance_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';

import 'package:logger/logger.dart';
import '../../../../constants/api_endpoints.dart';
import '../../../../services/api_service.dart';
import '../../../../theme/app_colors.dart';
import '../models/attendance_marking_status_response_model.dart';
import '../models/session_for_date_model.dart';
import '../models/session_for_marking_model.dart';
import '../models/student_attendance_model.dart'; // Import student attendance models

class FacultyStudentAttendanceController extends GetxController {
  final ApiService _apiService = ApiService();
  final Logger _logger = Logger();

  // Tabs for FacultyStudentAttendanceTab (Dashboard, Record, Mark)
  final RxInt selectedStudentSubTab = 0.obs;

  // Tabs for FacultyStudentAttendanceDashboardView (Overview, Classes, Students)
  final RxInt selectedDashboardTab = 0.obs;

  // Loading/Error states
  final RxBool isLoading = true.obs;
  final RxBool isError = false.obs;
  final RxString errorMessage = ''.obs;

  // --- Dashboard Data ---
  final Rx<OverallStudentAttendanceSummary?> overallSummary =
      Rx<OverallStudentAttendanceSummary?>(null);
  final RxList<ClassAttendanceSnapshot> classSnapshots =
      <ClassAttendanceSnapshot>[].obs;
  final RxList<RecentClass> recentClasses = <RecentClass>[].obs;

  // Mark Attendance Tab Data
  final RxList<SessionForMarkingModel> todaySessions =
      <SessionForMarkingModel>[].obs;
  final Rx<SessionForMarkingModel?> selectedSession =
      Rx<SessionForMarkingModel?>(null);

  // NEW: Rx variable to store attendance marking status response
  final Rx<AttendanceMarkingStatusResponse?> attendanceMarkingStatusResponse =
      Rx<AttendanceMarkingStatusResponse?>(null);

  final RxList<StudentBasicInfo> studentList = <StudentBasicInfo>[].obs;

  // Filter properties for student-wise attendance
  final RxList<String> departmentFilters =
      <String>[].obs; // To store available department names
  final RxnString selectedDepartmentFilter = RxnString(); // Selected department
  final RxList<String> courseFilters =
      <String>[].obs; // To store available course names
  final RxnString selectedCourseFilter = RxnString(); // Selected course
  final RxList<String> semesterFilters =
      <String>[].obs; // To store available semester names
  final RxnString selectedSemesterFilter = RxnString(); // Selected semester
  final RxList<String> attendanceStatusFilters = [
    'All',
    'Present',
    'Absent',
    'Late',
    'Excused',
    'Low Attendance',
  ].obs;
  final RxString selectedAttendanceStatusFilter =
      'All'.obs; // Selected attendance status

  // For Mark UI (existing) - Corrected declarations
  final RxList<String> courses = <String>[].obs; // Declared as empty
  final RxString selectedCourse = ''.obs; // Initialized as empty
  final RxList<String> sections = <String>[].obs; // Declared as empty
  final RxString selectedSection = ''.obs; // Initialized as empty
  final RxList<String> subjects = <String>[].obs; // Declared as empty
  final RxString selectedSubject = ''.obs; // Initialized as empty
  final RxList<String> subSubjects = <String>[].obs; // Declared as empty
  final RxString selectedSubSubject = ''.obs; // Initially empty

  final Rx<DateTime> markAttendanceDate = DateTime.now().obs;
  final RxBool showPreviousAttendance = false.obs;
  final RxList<StudentAttendanceMark> studentsForMarking =
      <StudentAttendanceMark>[].obs;

  // --- Attendance Records Tab Data ---
  final RxInt selectedRecordView = 0.obs; // 0: List View, 1: Calendar Show
  final RxList<String> recordSubjects = [
    'Mechanics',
    'Chemistry',
    'Biology',
  ].obs; // Filter options
  final RxString selectedRecordSubject = 'Mechanics'.obs;
  final RxList<String> recordSections = [
    'Section A',
    'Section B',
    'Section C',
  ].obs;
  final RxString selectedRecordSection = 'Section A'.obs;
  final Rx<DateTime> recordSelectedDate = DateTime.now().obs;
  final RxList<StudentRecord> studentRecords = StudentRecord.dummyList().obs;
  final RxString recordSearchQuery = ''.obs;

  // Pagination for sessions
  final RxInt currentPage = 1.obs;
  final RxInt perPage = 20.obs;
  final RxInt totalPages = 1.obs;
  final RxInt totalSessions = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStudentAttendanceDashboard();
    fetchStudentWiseAttendance();
    // Initial fetch for today's sessions, no specific session to re-select yet
    fetchTodaySessions();
  }

  void changeStudentSubTab(int index) {
    selectedStudentSubTab.value = index;
    if (index == 2) {
      // If navigating to Mark tab, ensure sessions are loaded/refreshed
      fetchTodaySessions();
    }
  }

  void changeDashboardTab(int index) {
    selectedDashboardTab.value = index;
  }

  // --- Filter methods for student-wise attendance ---
  void selectDepartmentFilter(String? department) {
    if (department != null) {
      selectedDepartmentFilter.value = department;
      fetchStudentWiseAttendance();
    }
  }

  void selectCourseFilter(String? course) {
    if (course != null) {
      selectedCourseFilter.value = course;
      fetchStudentWiseAttendance();
    }
  }

  void selectSemesterFilter(String? semester) {
    if (semester != null) {
      selectedSemesterFilter.value = semester;
      fetchStudentWiseAttendance();
    }
  }

  void selectAttendanceStatusFilter(String? status) {
    if (status != null) {
      selectedAttendanceStatusFilter.value = status;
      fetchStudentWiseAttendance();
    }
  }

  // --- API Calls ---
  Future<void> fetchStudentAttendanceDashboard() async {
    try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';

      final response = await ApiService().get(
        ApiEndpoints.FACULTY_STUDENT_ATTENDANCE_DASHBOARD_MAPP,
      );

      final data = response.data['data']['faculty_data'];

      overallSummary.value = OverallStudentAttendanceSummary.fromJson(
        data['overall_attendance'],
      );

      classSnapshots.value = (data['class_wise_attendance'] as List)
          .map((e) => ClassAttendanceSnapshot.fromJson(e))
          .toList();

      recentClasses.value = (data['recent_classes'] as List)
          .map((e) => RecentClass.fromJson(e))
          .toList();
    } catch (e) {
      isError.value = true;
      errorMessage.value = 'Error: ${e.toString()}';
      _logger.e('Error fetching dashboard data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchStudentWiseAttendance({int? departmentId}) async {
    try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';

      final Map<String, dynamic> queryParams = {};
      if (departmentId != null) {
        queryParams['department_id'] = departmentId;
      }
      if (selectedCourseFilter.value != null &&
          selectedCourseFilter.value != 'All') {
        queryParams['course_id'] = selectedCourseFilter.value;
      }
      if (selectedSemesterFilter.value != null &&
          selectedSemesterFilter.value != 'All') {
        queryParams['semester_id'] = selectedSemesterFilter.value;
      }
      if (selectedAttendanceStatusFilter.value != 'All') {
        queryParams['attendance_filter'] =
            selectedAttendanceStatusFilter.value.toLowerCase();
      }

      final response = await ApiService().get(
        ApiEndpoints.FACULTY_STUDENTWISE_ATTENDANCE_MAPP,
        queryParameters: queryParams,
      );

      final studentData = response.data['data']['student_data'];
      final List<dynamic> studentsJson = studentData['student_wise_attendance'];
      final Map<String, dynamic> contextInfo = studentData['context_info'];

      studentList.value =
          studentsJson.map((e) => StudentBasicInfo.fromJson(e)).toList();

      if (contextInfo['department'] != null &&
          contextInfo['department']['department_name'] != null) {
        departmentFilters.value = [
          contextInfo['department']['department_name'],
        ];
        selectedDepartmentFilter.value =
            contextInfo['department']['department_name'];
      } else {
        departmentFilters.value = [
          'Computer Science',
          'Physics',
          'Mathematics',
          'Chemistry',
        ];
        selectedDepartmentFilter.value = departmentFilters.first;
      }
      courseFilters.value = [
        'All',
        'Physics I',
        'Mathematics I',
        'Database Systems',
        'Programming Fundamentals',
      ];
      semesterFilters.value = [
        'All',
        'Semester 1',
        'Semester 2',
      ];
    } catch (e) {
      isError.value = true;
      _logger.e('Error fetching student-wise attendance: $e');
      errorMessage.value = 'Error fetching students: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetches today's sessions for attendance marking.
  /// If `previousSessionId` is provided, it attempts to re-select that session
  /// from the newly fetched list.
  Future<void> fetchTodaySessions({int? previousSessionId}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final String formattedDate =
          DateFormat('yyyy-MM-dd').format(markAttendanceDate.value);

      final response = await _apiService.get(
        ApiEndpoints.FACULTY_TODAY_SESSIONS,
        queryParameters: {'session_date': formattedDate},
      );
      final List<dynamic> sessionsJson = response.data['data']['sessions'];
      todaySessions.value = sessionsJson
          .map((json) => SessionForMarkingModel.fromJson(json))
          .toList();

      if (todaySessions.isNotEmpty) {
        SessionForMarkingModel? targetSession;

        // 1. Try to re-select based on previousSessionId if provided
        if (previousSessionId != null) {
          targetSession = todaySessions
              .firstWhereOrNull((s) => s.sessionId == previousSessionId);
        }

        // 2. If no previous ID or session not found, try to find a session
        //    matching current Course/Section/Subject dropdowns.
        //    Ensure selectedCourse/Section/Subject are not empty before attempting
        if (targetSession == null &&
            selectedCourse.value.isNotEmpty &&
            selectedSection.value.isNotEmpty &&
            selectedSubject.value.isNotEmpty) {
          targetSession = todaySessions.firstWhereOrNull(
            (s) =>
                s.courseTitle == selectedCourse.value &&
                s.location == selectedSection.value &&
                s.topic == selectedSubject.value,
          );
        }

        // 3. If still no session selected, default to the first one
        if (targetSession == null) {
          targetSession = todaySessions.first;
        }

        // Now set the selected session and update dependent dropdowns
        selectedSession.value = targetSession;

        if (selectedSession.value != null) {
          // Update the Course/Section/Subject dropdowns to match the selected session
          // This ensures consistency when a session is programmatically selected.
          selectedCourse.value = selectedSession.value!.courseTitle;
          selectedSection.value = selectedSession.value!.location;
          selectedSubject.value = selectedSession.value!.topic;

          // Also populate the actual dropdown options for Course, Section, Subject
          // based on the fetched todaySessions.
          courses.value = todaySessions.map((s) => s.courseTitle).toSet().toList();
          sections.value = todaySessions
              .where((s) => s.courseTitle == selectedCourse.value)
              .map((s) => s.location)
              .toSet()
              .toList();
          subjects.value = todaySessions
              .where((s) =>
                  s.courseTitle == selectedCourse.value &&
                  s.location == selectedSection.value)
              .map((s) => s.topic)
              .toSet()
              .toList();


          // Now fetch attendance status if the markingSessionUuid is available
          if (selectedSession.value!.markingSessionUuid.isNotEmpty) {
            await fetchAttendanceMarkingStatus(
              selectedSession.value!.markingSessionUuid,
            );
          } else {
            // If the selected session does not yet have a markingSessionUuid,
            // clear the students list (as attendance hasn't started for it)
            studentsForMarking.clear();
            attendanceMarkingStatusResponse.value = null;
          }
        }
      } else {
        // No sessions available for the selected date
        selectedSession.value = null;
        studentsForMarking.clear();
        attendanceMarkingStatusResponse.value = null;
        // Also clear the filter dropdowns as no sessions mean no data to filter by
        courses.clear(); // Clear the lists
        sections.clear();
        subjects.clear();
        selectedCourse.value = ''; // Reset selected values
        selectedSection.value = '';
        selectedSubject.value = '';
      }
    } catch (e) {
      errorMessage.value =
          'An unexpected error occurred fetching sessions: ${e.toString()}';
      _logger.e('Error fetching today sessions: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetches the attendance marking status for a given `markingSessionUuid`.
  Future<void> fetchAttendanceMarkingStatus(String markingSessionUuid) async {
    isLoading.value = true;
    errorMessage.value = '';
    attendanceMarkingStatusResponse.value = null; // Clear previous data
    studentsForMarking.clear(); // Clear students list before fetching new ones

    try {
      final String apiUrl =
          ApiEndpoints.FACULTY_ATTENDANCE_MARKING_STATUS(markingSessionUuid);
      final response = await _apiService.get(apiUrl);

      _logger.i('Attendance Marking Status Response: ${response.data}');

      final parsedResponse = AttendanceMarkingStatusResponse.fromJson(
        response.data,
      );
      attendanceMarkingStatusResponse.value = parsedResponse;

      studentsForMarking.value =
          parsedResponse.data.students.map((studentDetail) {
        String displayStatus;
        switch (studentDetail.status) {
          case 'present':
            displayStatus = 'Present';
            break;
          case 'absent':
            displayStatus = 'Absent';
            break;
          case 'late':
            displayStatus = 'Late';
            break;
          case 'excused':
            displayStatus = 'Excused';
            break;
          case 'not_marked':
          default:
            displayStatus = 'Unmarked';
            break;
        }
        return StudentAttendanceMark(
          id: studentDetail.studentId.toString(),
          rollNo: studentDetail.studentCode,
          name: studentDetail.name,
          initialStatus: displayStatus,
        );
      }).toList();
    } catch (e) {
      errorMessage.value =
          'An unexpected error occurred fetching attendance status: ${e.toString()}';
      _logger.e('Error fetching attendance marking status: $e');
      attendanceMarkingStatusResponse.value = null; // Clear on error
      studentsForMarking.clear(); // Clear students on error
    } finally {
      isLoading.value = false;
    }
  }

  // --- Mark Attendance Methods ---

  // When user selects a course from the individual dropdowns (if still used)
  void selectCourse(String? course) {
    if (course != null && selectedCourse.value != course) {
      selectedCourse.value = course;
      // Re-filter other dropdown options and then attempt to select the corresponding session
      _updateMarkingDropdownsAndSession();
    }
  }

  // When user selects a section from the individual dropdowns (if still used)
  void selectSection(String? section) {
    if (section != null && selectedSection.value != section) {
      selectedSection.value = section;
      _updateMarkingDropdownsAndSession();
    }
  }

  // When user selects a subject from the individual dropdowns (if still used)
  void selectSubject(String? subject) {
    if (subject != null && selectedSubject.value != subject) {
      selectedSubject.value = subject;
      _updateMarkingDropdownsAndSession();
    }
  }

  void selectSubSubject(String? subSubject) {
    if (subSubject != null) {
      selectedSubSubject.value = subSubject;
      // This might need to be linked to a specific session if subSubjects are unique per session
      // For now, keep it simple, if it influences session selection, call _updateMarkingDropdownsAndSession
    }
  }

  /// Helper to update the course, section, subject dropdown options and then
  /// select the corresponding session based on the currently selected filter values.
  void _updateMarkingDropdownsAndSession() {
    // Populate sections based on selected course
    sections.value = todaySessions
        .where((s) => s.courseTitle == selectedCourse.value)
        .map((s) => s.location)
        .toSet()
        .toList();
    // Ensure selected section is still valid, or pick the first if not
    if (!sections.contains(selectedSection.value) && sections.isNotEmpty) {
      selectedSection.value = sections.first;
    } else if (sections.isEmpty) {
      selectedSection.value = '';
    }

    // Populate subjects based on selected course and section
    subjects.value = todaySessions
        .where((s) =>
            s.courseTitle == selectedCourse.value &&
            s.location == selectedSection.value)
        .map((s) => s.topic)
        .toSet()
        .toList();
    // Ensure selected subject is still valid, or pick the first if not
    if (!subjects.contains(selectedSubject.value) && subjects.isNotEmpty) {
      selectedSubject.value = subjects.first;
    } else if (subjects.isEmpty) {
      selectedSubject.value = '';
    }

    // Now, find and set the selected session based on these filters
    _selectCorrespondingSessionFromFilters();
  }

  /// Finds and selects the session from `todaySessions` that matches the
  /// currently selected course, section, and subject dropdown values.
  /// Then fetches its attendance status.
  void _selectCorrespondingSessionFromFilters() async {
    final SessionForMarkingModel? session = todaySessions.firstWhereOrNull(
      (s) =>
          s.courseTitle == selectedCourse.value &&
          s.location == selectedSection.value &&
          s.topic == selectedSubject.value,
    );

    // Only update selectedSession and fetch status if it's different
    // to prevent unnecessary rebuilds/API calls.
    if (selectedSession.value?.sessionId != session?.sessionId) {
      selectedSession.value = session;
      if (session != null && session.markingSessionUuid.isNotEmpty) {
        await fetchAttendanceMarkingStatus(session.markingSessionUuid);
      } else {
        studentsForMarking.clear();
        attendanceMarkingStatusResponse.value = null;
      }
    }
  }

  void selectMarkAttendanceDate(DateTime date) {
    if (markAttendanceDate.value.day != date.day ||
        markAttendanceDate.value.month != date.month ||
        markAttendanceDate.value.year != date.year) {
      markAttendanceDate.value = date;
      // When date changes, always re-fetch sessions for that date.
      // No need to pass previousSessionId here as it's a new date context.
      fetchTodaySessions();
    }
  }

  /// Called when the user explicitly selects a session from the single dropdown.
  void selectSessionForMarking(SessionForMarkingModel? session) async {
    // Only update if the selected session is actually different
    if (selectedSession.value?.sessionId != session?.sessionId) {
      selectedSession.value = session;

      if (session != null) {
        // Update the individual Course/Section/Subject dropdowns to match the selected session
        selectedCourse.value = session.courseTitle;
        selectedSection.value = session.location;
        selectedSubject.value = session.topic;

        // Populate the individual dropdown options relevant to the selected session
        // These lines were already correct in the previous fix
        courses.value = todaySessions.map((s) => s.courseTitle).toSet().toList();
        sections.value = todaySessions.where((s) => s.courseTitle == session.courseTitle).map((s) => s.location).toSet().toList();
        subjects.value = todaySessions.where((s) => s.courseTitle == session.courseTitle && s.location == session.location).map((s) => s.topic).toSet().toList();


        // Fetch attendance status only if markingSessionUuid is present
        if (session.markingSessionUuid.isNotEmpty) {
          await fetchAttendanceMarkingStatus(session.markingSessionUuid);
        } else {
          studentsForMarking.clear();
          attendanceMarkingStatusResponse.value = null;
        }
      } else {
        // If no session is selected, clear all related data
        studentsForMarking.clear();
        attendanceMarkingStatusResponse.value = null;
        // Also clear dropdowns
        courses.clear();
        sections.clear();
        subjects.clear();
        selectedCourse.value = '';
        selectedSection.value = '';
        selectedSubject.value = '';
      }
    }
  }

  void toggleShowPreviousAttendance(bool? value) {
    if (value != null) {
      showPreviousAttendance.value = value;
    }
  }

  void updateStudentMarkStatus(String studentId, String status) {
    final index = studentsForMarking.indexWhere((s) => s.id == studentId);
    if (index != -1) {
      studentsForMarking[index].status.value = status;
    }
  }

  void filterStudentsForMarking() {
    // This method is primarily used as a placeholder for UI calls.
    // The actual filtering/loading of students is now driven by `selectSessionForMarking`
    // and `_selectCorrespondingSessionFromFilters` after API calls.
  }

  void submitMarkedAttendance() {
    if (selectedSession.value == null || studentsForMarking.isEmpty) {
      Get.snackbar(
        'Error',
        'No session selected or no students to mark.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    _logger.i('Submitting attendance for session ID: ${selectedSession.value!.sessionId}');
    final List<Map<String, dynamic>> attendanceData = studentsForMarking.map((student) {
      String apiStatus;
      switch (student.status.value) {
        case 'Present':
          apiStatus = 'present';
          break;
        case 'Absent':
          apiStatus = 'absent';
          break;
        case 'Late':
          apiStatus = 'late';
          break;
        case 'Excused':
          apiStatus = 'excused';
          break;
        default:
          apiStatus = 'not_marked'; // Or 'absent' if unmarked should default to absent
          break;
      }
      return {
        "student_id": int.parse(student.id),
        "status": apiStatus,
      };
    }).toList();

    _logger.i('Attendance data: $attendanceData');

    // Here you would make the API call to submit the attendance
    // This is a placeholder for the actual API call
    // await _apiService.post(
    //   ApiEndpoints.FACULTY_SUBMIT_ATTENDANCE, // Replace with your actual endpoint
    //   data: {
    //     "marking_session_uuid": selectedSession.value!.markingSessionUuid,
    //     "attendance_data": attendanceData,
    //   },
    // );

    Get.snackbar(
      'Success',
      'Attendance submitted for ${studentsForMarking.length} students.',
      backgroundColor: Get.theme.colorScheme.secondary,
      colorText: Get.theme.colorScheme.onSecondary,
    );
    // Optionally re-fetch status after submission if needed, or simply update local state
    // if (selectedSession.value!.markingSessionUuid.isNotEmpty) {
    //   fetchAttendanceMarkingStatus(selectedSession.value!.markingSessionUuid);
    // }
  }

  void changeRecordView(int index) {
    selectedRecordView.value = index;
  }

  void selectRecordSubject(String? subject) {
    if (subject != null) {
      selectedRecordSubject.value = subject;
      _filterStudentRecords();
    }
  }

  void selectRecordSection(String? section) {
    if (section != null) {
      selectedRecordSection.value = section;
      _filterStudentRecords();
    }
  }

  void selectRecordDate(DateTime date) {
    recordSelectedDate.value = date;
    _filterStudentRecords();
  }

  void updateRecordSearchQuery(String query) {
    recordSearchQuery.value = query;
    _filterStudentRecords();
  }

  void _filterStudentRecords() {
    List<StudentRecord> filteredList = StudentRecord.dummyList();

    if (selectedRecordSubject.isNotEmpty) {
      filteredList = filteredList
          .where((record) => record.subject == selectedRecordSubject.value)
          .toList();
    }
    if (selectedRecordSection.isNotEmpty) {
      filteredList = filteredList
          .where((record) => record.section == selectedRecordSection.value)
          .toList();
    }
    filteredList = filteredList
        .where(
          (record) =>
              record.name.toLowerCase().contains(
                recordSearchQuery.value.toLowerCase(),
              ) ||
              record.rollNo.toLowerCase().contains(
                recordSearchQuery.value.toLowerCase(),
              ),
        )
        .toList();

    studentRecords.value = filteredList;
  }

  // Start Attendance Marking API call (after image upload)
  Future<bool> startAttendanceMarking(String imagePath, String notes) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      if (selectedSession.value == null) {
        Get.snackbar(
          'Error',
          'Please select a session before uploading an image.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading.value = false;
        return false;
      }

      // Store the sessionId of the currently selected session before the API call.
      // We use sessionId because markingSessionUuid might be empty initially
      // and will be generated by this API call.
      final int? currentSessionId = selectedSession.value?.sessionId;

      // Create FormData for file upload
      String fileName = imagePath.split('/').last;
      dio.FormData formData = dio.FormData.fromMap({
        "photo": await dio.MultipartFile.fromFile(
          imagePath,
          filename: fileName,
        ),
        "session_id": selectedSession.value!.sessionId.toString(),
        "notes": notes,
      });

      _logger.i(
          'Calling start_attendance_marking for session ID: ${selectedSession.value!.sessionId}');
      _logger.i('Notes: $notes');
      _logger.i('Image path: $imagePath');

      final response = await _apiService.postFormData(
        ApiEndpoints.FACULTY_START_ATTENDANCE_MARKING,
        formData: formData,
      );

      if (response.statusCode == 200) {
        Get.back(); // Navigate back to the previous screen (Mark Attendance tab)

        Get.snackbar(
          'Success',
          'Attendance marking initiated successfully! Refreshing session data...',
          backgroundColor: AppColors.primaryGreen,
          colorText: Colors.white,
        );

        // Crucially, re-fetch today's sessions and pass the previously selected
        // session's ID so that it can be re-selected with its updated UUID.
        await fetchTodaySessions(previousSessionId: currentSessionId);
        return true;
      } else {
        errorMessage.value =
            'Failed to initiate attendance marking. Please try again.';
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false; // Return false on API failure to indicate error to UI
      }
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred: ${e.toString()}';
      _logger.e('Error starting attendance marking: $e');
      Get.snackbar(
        'Error',
        'An unexpected error occurred: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}