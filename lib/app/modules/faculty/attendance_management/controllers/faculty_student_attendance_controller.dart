import 'package:get/get.dart';
import '../../../../constants/api_endpoints.dart';
import '../../../../services/api_service.dart';
import '../models/student_attendance_model.dart'; // Import student attendance models

class FacultyStudentAttendanceController extends GetxController {
  final RxInt selectedStudentSubTab = 0.obs; // 0: Dashboard, 1: Record, 2: Mark
  // overview, classes, students
  final RxInt selectedDashboardTab = 0.obs;

  //overview

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
    fetchStudentAttendanceDashboardforStudent();
    filterStudentsForMarking();
  }

  void changeStudentSubTab(int index) {
    selectedStudentSubTab.value = index;
  }

  void changeDashboardTab(int index) {
    selectedDashboardTab.value = index;
  }

  // --- Mark Attendance Methods ---
  void selectCourse(String? course) {
    if (course != null) {
      selectedCourse.value = course;
      // In a real app, you'd fetch sections/subjects based on course
      // For dummy, just reset other selections
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
    filterStudentsForMarking(); // Re-fetch students based on new date
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchStudentAttendanceDashboardforStudent() async {
    try {
      isLoading.value = true;
      final response = await ApiService().get(
        ApiEndpoints.FACULTY_STUDENTWISE_ATTENDANCE_MAPP,
      );
      final students = response.data['data']['faculty_data'] as List;
      studentList.value = students
          .map((e) => StudentBasicInfo.fromJson(e))
          .toList();
    } catch (e) {
      errorMessage.value = 'Error fetching students: $e';
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
