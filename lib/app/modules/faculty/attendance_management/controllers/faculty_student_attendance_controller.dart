import 'package:get/get.dart';
import '../models/student_attendance_model.dart'; // Import student attendance models

class FacultyStudentAttendanceController extends GetxController {
  final RxInt selectedStudentSubTab = 0.obs; // 0: Dashboard, 1: Record, 2: Mark

  final Rx<OverallStudentAttendanceSummary> overallSummary =
      OverallStudentAttendanceSummary.dummy().obs;
  final RxList<ClassAttendanceSnapshot> classSnapshots =
      ClassAttendanceSnapshot.dummyList().obs;
  final RxList<RecentClass> recentClasses = RecentClass.dummyList().obs;

  final RxList<String> courses = ['B.Sc Physics', 'B.Com', 'B.Tech', 'BBA'].obs;
  final RxString selectedCourse = 'B.Sc Physics'.obs;
  final RxList<String> sections = ['Section A', 'D', 'C'].obs; // Dummy sections
  final RxString selectedSection = 'Section A'.obs;
  final RxList<String> subjects = ['Mechanics', 'Thermodynamics', 'Optics'].obs;
  final RxString selectedSubject = 'Mechanics'.obs;
  final RxList<String> subSubjects = ['BMGT 321', 'DESGN 401', 'HIST 201'].obs; // For Mark UI
  final RxString selectedSubSubject = ''.obs; // Initially empty
  final Rx<DateTime> markAttendanceDate = DateTime.now().obs;
  final RxBool showPreviousAttendance = false.obs;
  final RxList<StudentAttendanceMark> studentsForMarking = <StudentAttendanceMark>[].obs;

  // --- Attendance Records Tab Data ---
  final RxInt selectedRecordView = 0.obs; // 0: List View, 1: Calendar Show
  final RxList<String> recordSubjects = ['Mechanics', 'Chemistry', 'Biology'].obs; // Filter options
  final RxString selectedRecordSubject = 'Mechanics'.obs;
  final RxList<String> recordSections = ['Section A', 'Section B', 'Section C'].obs;
  final RxString selectedRecordSection = 'Section A'.obs;
  final Rx<DateTime> recordSelectedDate = DateTime.now().obs;
  final RxList<StudentRecord> studentRecords = StudentRecord.dummyList().obs;
  final RxString recordSearchQuery = ''.obs;


  @override
  void onInit() {
    super.onInit();
    // Initialize data for mark attendance tab
    filterStudentsForMarking();
  }

  void changeStudentSubTab(int index) {
    selectedStudentSubTab.value = index;
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
    // Dummy logic: just re-assign the dummy list for demonstration
    studentsForMarking.value = StudentAttendanceMark.dummyList();
    // In a real app, you'd filter based on selectedCourse, selectedSection, selectedSubject, markAttendanceDate
  }

  void submitMarkedAttendance() {
    // Implement logic to send marked attendance to backend
    print('Submitting attendance:');
    for (var student in studentsForMarking) {
      print('${student.name}: ${student.status.value}');
    }
    Get.snackbar('Success', 'Attendance submitted for ${studentsForMarking.length} students.',
        backgroundColor: Get.theme.colorScheme.secondary, colorText: Get.theme.colorScheme.onSecondary);
    // You might clear the list or navigate away after submission
  }

  // --- Attendance Records Methods ---
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
    // Dummy filtering logic
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
    // Filter by date if needed (for "Calendar Show" this would be more prominent)
    filteredList = filteredList
        .where((record) => record.name.toLowerCase().contains(recordSearchQuery.value.toLowerCase()) ||
                           record.rollNo.toLowerCase().contains(recordSearchQuery.value.toLowerCase()))
        .toList();

    studentRecords.value = filteredList;
  }
}