import 'package:get/get.dart';

import '../../../../data/models/user_model.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../models/grades_models.dart';
import '../../syllabus/models/syllabus_models.dart'; // For SubjectStatus enum if used directly

class GradesController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  final RxInt selectedGradesTabIndex = 0.obs;

  Rx<UserModels?> currentUser = Rx<UserModels?>(null);
  String get userName => currentUser.value?.name ?? 'User Name';
  String get userRollNumber => currentUser.value?.id ?? 'N/A';
  String get userPhotoUrl => currentUser.value?.photoUrl ?? '';


  // --- Grades Overview Tab Data ---
  final Rx<OverallGradesSummary> overallGradesSummary = OverallGradesSummary.dummy().obs;
  final Rx<SemesterCreditSummary> semesterCreditSummary = SemesterCreditSummary.dummy().obs;
  final RxList<PerformanceTrend> performanceTrends = <PerformanceTrend>[].obs;
  final RxList<AcademicRecommendation> academicRecommendations = <AcademicRecommendation>[].obs;
  final RxList<SubjectPerformance> subjectPerformances = <SubjectPerformance>[].obs;


  // --- Grades Calendar Tab Data ---
  final Rx<DateTime> currentCalendarMonth = DateTime.now().obs;
  final RxList<DailyProgress> dailyStudyProgress = <DailyProgress>[].obs; // Reusing from Syllabus for consistency
  final RxList<Exam> examsForCalendar = <Exam>[].obs; // Reusing from Syllabus for consistency
  // In a real app, you might have specific grade-related calendar events


  // --- Grades Exams Tab Data ---
  final RxString selectedSemesterFilter = 'Spring 2024'.obs; // For the semester dropdown
  final RxList<GradeExam> upcomingExams = <GradeExam>[].obs;
  final RxList<GradeExam> recentResultsExams = <GradeExam>[].obs; // Confusing name, but matches image


  // --- Grades Results Tab Data ---
  final RxString selectedResultsSemester = 'Spring Semester 2024'.obs; // From RESULTS.png
  final RxString selectedResultsCourse = 'Computer Science Engineering'.obs; // From RESULTS.png
  final RxString selectedResultsView = 'Spring 2024'.obs; // Dropdown in RESULTS.png
  final RxList<RecentExamPerformance> recentExamPerformances = <RecentExamPerformance>[].obs;


  @override
  void onInit() {
    super.onInit();
    _loadUserProfile();
    _loadGradesOverviewData();
    _loadGradesCalendarData();
    _loadGradesExamsData();
    _loadGradesResultsData();
  }

  // --- Main Bottom Navigation Tab Change ---
  void changeGradesTabIndex(int index) {
    selectedGradesTabIndex.value = index;
    // Potentially load data specific to the tab if not already loaded
    if (index == 0) {
      _loadGradesOverviewData();
    } else if (index == 1) {
      _loadGradesCalendarData();
    } else if (index == 2) {
      _loadGradesExamsData();
    } else if (index == 3) {
      _loadGradesResultsData();
    }
  }

  // --- User Profile Loading ---
  void _loadUserProfile() {
    currentUser.value = _authController.currentUser.value;
    if (currentUser.value == null) {
      currentUser.value = UserModels(
        id: 'Btech-123',
        name: 'Isha Sharma',
        email: 'isha.sharma@example.com',
        role: 'student',
        photoUrl: 'https://placehold.co/100x100/A000FE/FFFFFF?text=IS',
      );
    }
  }

  // --- Grades Overview Data Loading ---
  void _loadGradesOverviewData() {
    overallGradesSummary.value = OverallGradesSummary.dummy();
    semesterCreditSummary.value = SemesterCreditSummary.dummy();
    performanceTrends.value = PerformanceTrend.dummyList();
    academicRecommendations.value = AcademicRecommendation.dummyList();
    subjectPerformances.value = SubjectPerformance.dummyList();
  }

  // --- Grades Calendar Data Loading ---
  void _loadGradesCalendarData() {
    // Reusing DailyProgress and Exam from Syllabus models for calendar events
    // In a real app, you'd fetch calendar-specific data for grades (e.g., assignment due dates)
    dailyStudyProgress.value = DailyProgress.dummyList(); // Example study days
    examsForCalendar.value = Exam.dummyList(); // Example exam days
  }

  void changeCalendarMonth(int delta) {
    currentCalendarMonth.value = DateTime(
      currentCalendarMonth.value.year,
      currentCalendarMonth.value.month + delta,
      1,
    );
    // You might refetch calendar events specific to grades here
  }

  // --- Grades Exams Data Loading ---
  void _loadGradesExamsData() {
    upcomingExams.value = GradeExam.dummyUpcomingExams();
    recentResultsExams.value = GradeExam.dummyRecentResults();
  }

  void changeSemesterFilter(String? semester) {
    if (semester != null) {
      selectedSemesterFilter.value = semester;
      // In a real app, refetch exams based on semester
    }
  }

  // --- Grades Results Data Loading ---
  void _loadGradesResultsData() {
    recentExamPerformances.value = RecentExamPerformance.dummyList();
  }

  void changeResultsSemester(String? semester) {
    if (semester != null) {
      selectedResultsSemester.value = semester;
      // Fetch results for new semester
    }
  }

  void changeResultsCourse(String? course) {
    if (course != null) {
      selectedResultsCourse.value = course;
      // Fetch results for new course
    }
  }

  void changeResultsView(String? view) {
    if (view != null) {
      selectedResultsView.value = view;
      // Change how results are displayed (e.g., by subject, by exam type)
    }
  }
}