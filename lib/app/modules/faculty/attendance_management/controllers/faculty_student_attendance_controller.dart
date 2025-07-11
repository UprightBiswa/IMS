// lib/app/modules/faculty_student_attendance/controllers/faculty_student_attendance_controller.dart

import 'package:get/get.dart';
import '../../../../constants/api_endpoints.dart';
import '../../../../services/api_service.dart';
import '../models/student_attendance_model.dart'; // Import student attendance models

class FacultyStudentAttendanceController extends GetxController {
  final RxInt selectedStudentSubTab = 0.obs; // 0: Dashboard, 1: Record, 2: Mark
  // overview, classes, students
  final RxInt selectedDashboardTab = 0.obs;

  // Overview
  final RxBool isLoading = true.obs;
  final RxBool isError = false.obs;
  final RxString errorMessage = ''.obs;

  // --- Dashboard Data ---
  final Rx<OverallStudentAttendanceSummary?> overallSummary =
      Rx<OverallStudentAttendanceSummary?>(null);

  final RxList<ClassAttendanceSnapshot> classSnapshots =
      <ClassAttendanceSnapshot>[].obs;

  final RxList<RecentClass> recentClasses = <RecentClass>[].obs;

  final RxList<StudentBasicInfo> studentList = <StudentBasicInfo>[].obs;

  // Filter properties for student-wise attendance
  final RxList<String> departmentFilters = <String>[].obs; // To store available department names
  final RxnString selectedDepartmentFilter = RxnString(); // Selected department
  final RxList<String> courseFilters = <String>[].obs; // To store available course names
  final RxnString selectedCourseFilter = RxnString(); // Selected course
  final RxList<String> semesterFilters = <String>[].obs; // To store available semester names
  final RxnString selectedSemesterFilter = RxnString(); // Selected semester
  final RxList<String> attendanceStatusFilters = ['All', 'Present', 'Absent', 'Late', 'Excused', 'Low Attendance'].obs;
  final RxString selectedAttendanceStatusFilter = 'All'.obs; // Selected attendance status

  // For Mark UI (existing)
  final RxList<String> courses = ['B.Sc Physics', 'B.Com', 'B.Tech', 'BBA'].obs;
  final RxString selectedCourse = 'B.Sc Physics'.obs;
  final RxList<String> sections = ['Section A', 'D', 'C'].obs; // Dummy sections
  final RxString selectedSection = 'Section A'.obs;
  final RxList<String> subjects = ['Mechanics', 'Thermodynamics', 'Optics'].obs;
  final RxString selectedSubject = 'Mechanics'.obs;
  final RxList<String> subSubjects = [
    'BMGT 321',
    'DESGN 401',
    'HIST 201',
  ].obs; // For Mark UI
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

  @override
  void onInit() {
    super.onInit();
    // Initialize data for mark attendance tab
    fetchStudentAttendanceDashboard();
    fetchStudentWiseAttendance(); // Fetch student-wise attendance on init
  }

  void changeStudentSubTab(int index) {
    selectedStudentSubTab.value = index;
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

      overallSummary.value =
          OverallStudentAttendanceSummary.fromJson(data['overall_attendance']);

      classSnapshots.value = (data['class_wise_attendance'] as List)
          .map((e) => ClassAttendanceSnapshot.fromJson(e))
          .toList();

      recentClasses.value = (data['recent_classes'] as List)
          .map((e) => RecentClass.fromJson(e))
          .toList();
    } catch (e) {
      isError.value = true;
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchStudentWiseAttendance({int? departmentId}) async {
    try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';

      // Construct query parameters based on selected filters
      final Map<String, dynamic> queryParams = {};
      if (departmentId != null) {
        queryParams['department_id'] = departmentId;
      }
      if (selectedCourseFilter.value != null && selectedCourseFilter.value != 'All') {
        // You'll need a way to map course names to IDs if your API expects IDs
        queryParams['course_id'] = selectedCourseFilter.value; // Placeholder
      }
      if (selectedSemesterFilter.value != null && selectedSemesterFilter.value != 'All') {
        // You'll need a way to map semester names to IDs if your API expects IDs
        queryParams['semester_id'] = selectedSemesterFilter.value; // Placeholder
      }
      if (selectedAttendanceStatusFilter.value != 'All') {
        queryParams['attendance_filter'] = selectedAttendanceStatusFilter.value.toLowerCase();
      }

      final response = await ApiService().get(
        ApiEndpoints.FACULTY_STUDENTWISE_ATTENDANCE_MAPP,
        queryParameters: queryParams,
      );

      final studentData = response.data['data']['student_data'];
      final List<dynamic> studentsJson = studentData['student_wise_attendance'];
      final Map<String, dynamic> filterInfo = studentData['filter_info'];
      final Map<String, dynamic> contextInfo = studentData['context_info'];


      studentList.value =
          studentsJson.map((e) => StudentBasicInfo.fromJson(e)).toList();

      // Populate filter options from API response (if available in filter_info or metadata)
      // This is a simplified example. In a real app, you'd likely have separate API endpoints for filter options.
      if (contextInfo['department'] != null && contextInfo['department']['department_name'] != null) {
        departmentFilters.value = [contextInfo['department']['department_name']];
        // Set the selected department to the one returned by the API
        selectedDepartmentFilter.value = contextInfo['department']['department_name'];
      } else {
         departmentFilters.value = ['Computer Science', 'Physics', 'Mathematics', 'Chemistry']; // Dummy options
         selectedDepartmentFilter.value = departmentFilters.first;
      }
      // Assuming 'courses' and 'semesters' arrays might be in filter_info or another endpoint
      courseFilters.value = ['All', 'Physics I', 'Mathematics I', 'Database Systems', 'Programming Fundamentals']; // Dummy options
      semesterFilters.value = ['All', 'Semester 1', 'Semester 2']; // Dummy options


    } catch (e) {
      isError.value = true;
      errorMessage.value = 'Error fetching students: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }


  // --- Mark Attendance Methods (existing) ---
  void selectCourse(String? course) {
    if (course != null) {
      selectedCourse.value = course;
      selectedSubject.value = subjects.first;
      selectedSubSubject.value = '';
      filterStudentsForMarking();
    }
  }

  void selectSection(String? section) {
    if (section != null) {
      selectedSection.value = section;
      filterStudentsForMarking();
    }
  }

  void selectSubject(String? subject) {
    if (subject != null) {
      selectedSubject.value = subject;
      selectedSubSubject.value = '';
      filterStudentsForMarking();
    }
  }

  void selectSubSubject(String? subSubject) {
    if (subSubject != null) {
      selectedSubSubject.value = subSubject;
      filterStudentsForMarking();
    }
  }

  void selectMarkAttendanceDate(DateTime date) {
    markAttendanceDate.value = date;
    filterStudentsForMarking();
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
    studentsForMarking.value = StudentAttendanceMark.dummyList();
  }

  void submitMarkedAttendance() {
    print('Submitting attendance:');
    for (var student in studentsForMarking) {
      print('${student.name}: ${student.status.value}');
    }
    Get.snackbar(
      'Success',
      'Attendance submitted for ${studentsForMarking.length} students.',
      backgroundColor: Get.theme.colorScheme.secondary,
      colorText: Get.theme.colorScheme.onSecondary,
    );
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
}