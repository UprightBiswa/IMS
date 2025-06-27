// lib/app/modules/syllabus/controllers/syllabus_controller.dart
import 'package:get/get.dart';

import '../../../../data/models/user_model.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../models/syllabus_models.dart';

class SyllabusController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  final RxInt selectedTabIndex = 0.obs; // 0: Syllabus, 1: Exam, 2: Resources

  // --- User Profile Data (for app bar and profile section) ---
  Rx<UserModels?> currentUser = Rx<UserModels?>(null);
  String get userName => currentUser.value?.name ?? 'User Name';
  String get userRollNumber => currentUser.value?.id ?? 'N/A';
  String get userPhotoUrl => currentUser.value?.photoUrl ?? ''; // Empty string if null


  // --- Syllabus Overview Tab Data ---
  final RxInt syllabusOverviewCompletedChapters = 3.obs;
  final RxInt syllabusOverviewThisWeek = 12.obs;
  final RxInt syllabusOverviewThisMonth = 28.obs;
  final RxDouble syllabusOverviewOverallPercentage = 82.0.obs;
  final RxList<SubjectProgress> subjectProgressList = <SubjectProgress>[].obs;
  final Rx<OverallProgressSummary> overallProgressSummary = OverallProgressSummary.dummy().obs;
  final RxList<DailyProgress> dailyProgressList = <DailyProgress>[].obs;


  // --- Exam Schedule Tab Data ---
  final RxInt totalExams = 8.obs;
  final RxInt completedExams = 3.obs;
  final RxInt remainingExams = 5.obs;
  final RxString nextExamInDays = '3 days'.obs; // Example: "Next exam in 3 days"
  final Rx<DateTime> currentCalendarMonth = DateTime.now().obs; // For the calendar view
  final RxList<Exam> examsList = <Exam>[].obs;
  final RxInt selectedExamFilter = 0.obs; // 0: All, 1: Upcoming, 2: Today, 3: Completed

  // --- Study Resources Tab Data ---
  final Rx<ResourceSummary> resourceSummary = ResourceSummary.dummy().obs;
  final RxList<RecentlyAccessedResource> recentlyAccessedResources = <RecentlyAccessedResource>[].obs;
  final RxList<RecommendedResource> recommendedResources = <RecommendedResource>[].obs;
  final RxList<StudyNote> studyNotes = <StudyNote>[].obs;
  final RxList<VideoLecture> videoLectures = <VideoLecture>[].obs;
  final RxList<PracticeQuiz> practiceQuizzes = <PracticeQuiz>[].obs;
  final RxList<ExternalLink> externalLinks = <ExternalLink>[].obs;

  final RxInt selectedResourceFilter = 0.obs; // 0: All, 1: Books, 2: Notes, 3: Videos, 4: Practice, 5: Links
  final RxList<String> resourceSubjects = ['All', 'Data Structures', 'Networks', 'Database', 'English'].obs;
  final RxString selectedResourceSubject = 'All'.obs;


  @override
  void onInit() {
    super.onInit();
    _loadUserProfile();
    _loadSyllabusOverviewData();
    _loadExamScheduleData();
    _loadStudyResourcesData();
  }

  // --- Bottom Navigation Tab Change ---
  void changeTabIndex(int index) {
    selectedTabIndex.value = index;
    // Potentially load data specific to the tab if not already loaded
    if (index == 0) {
      _loadSyllabusOverviewData();
    } else if (index == 1) {
      _loadExamScheduleData();
    } else if (index == 2) {
      _loadStudyResourcesData();
    }
  }

  // --- User Profile Loading ---
  void _loadUserProfile() {
    currentUser.value = _authController.currentUser.value;
    if (currentUser.value == null) {
      // Fallback for testing without a logged-in user
      currentUser.value = UserModels(
        id: 'Btech-123',
        name: 'Isha Sharma',
        email: 'isha.sharma@example.com',
        role: 'student',
        photoUrl: 'https://placehold.co/100x100/A000FE/FFFFFF?text=IS', // Dummy
      );
    }
  }

  // --- Syllabus Overview Data Loading ---
  void _loadSyllabusOverviewData() {
    subjectProgressList.value = SubjectProgress.dummyList();
    overallProgressSummary.value = OverallProgressSummary.dummy();
    dailyProgressList.value = DailyProgress.dummyList();
    // Simulate updating percentage and chapters based on dummy data
    syllabusOverviewCompletedChapters.value = overallProgressSummary.value.chaptersCompleted;
    syllabusOverviewOverallPercentage.value = overallProgressSummary.value.overallPercentage;
    // These 'this week' and 'this month' values would come from backend
    // For now, they are static dummy values initialized above.
  }

  // --- Exam Schedule Data Loading ---
  void _loadExamScheduleData() {
    examsList.value = Exam.dummyList();
    // Sort exams by date
    examsList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    // Filter exams based on selected filter
    _filterExams();
  }

  void changeExamFilter(int index) {
    selectedExamFilter.value = index;
    _filterExams();
  }

  void _filterExams() {
    List<Exam> filteredList = Exam.dummyList(); // Always start from full dummy list

    if (selectedExamFilter.value == 0) { // All
      examsList.value = filteredList;
    } else if (selectedExamFilter.value == 1) { // Upcoming
      examsList.value = filteredList.where((exam) => exam.status == ExamStatus.upcoming).toList();
    } else if (selectedExamFilter.value == 2) { // Today
      examsList.value = filteredList.where((exam) => exam.status == ExamStatus.today).toList();
    } else if (selectedExamFilter.value == 3) { // Completed
      examsList.value = filteredList.where((exam) => exam.status == ExamStatus.completed).toList();
    }
    // Re-sort after filtering
    examsList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  void changeCalendarMonth(int delta) {
    currentCalendarMonth.value = DateTime(
      currentCalendarMonth.value.year,
      currentCalendarMonth.value.month + delta,
      1,
    );
    // In a real app, you might fetch exams for the new month here
  }

  // --- Study Resources Data Loading ---
  void _loadStudyResourcesData() {
    resourceSummary.value = ResourceSummary.dummy();
    recentlyAccessedResources.value = RecentlyAccessedResource.dummyList();
    recommendedResources.value = RecommendedResource.dummyList();
    studyNotes.value = StudyNote.dummyList();
    videoLectures.value = VideoLecture.dummyList();
    practiceQuizzes.value = PracticeQuiz.dummyList();
    externalLinks.value = ExternalLink.dummyList();
    _filterResources();
  }

  void changeResourceFilter(int index) {
    selectedResourceFilter.value = index;
    _filterResources();
  }

  void selectResourceSubject(String? subject) {
    if (subject != null) {
      selectedResourceSubject.value = subject;
      _filterResources();
    }
  }

  void _filterResources() {
    // This is a simplified filter. In a real app, you'd filter the main lists
    // based on both selectedResourceFilter and selectedResourceSubject.
    // For now, let's just make sure the displayed lists are updated.
    // As per requirement, for now, just reflect the same dummy data.
  }
}