import 'package:get/get.dart';

import '../../../../constants/api_endpoints.dart';
import '../../../../services/api_service.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../models/student_attendance_summary_model.dart';
import '../models/subjectwise_attendance_model.dart';

class StudentAttendanceController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final Rx<StudentAttendanceSummaryModel?> attendanceSummary =
      Rx<StudentAttendanceSummaryModel?>(null);
  final RxList<SubjectWiseAttendanceModel> subjectWiseAttendanceList =
      <SubjectWiseAttendanceModel>[].obs;
  final RxList<DailyAttendanceData> dayWiseAttendanceList =
      <DailyAttendanceData>[].obs;
  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    fetchStudentAttendanceData(
      studentId: authController.currentUser.value != null
          ? authController.currentUser.value!.id
          : '',
    ); // Replace with actual student ID logic
  }

  Future<void> fetchStudentAttendanceData({required String studentId}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await ApiService().get(
        ApiEndpoints.STUDENT_ATTENDANCE_DASHBOARD,
        queryParameters: {'student_id': studentId},
      );

      final records = response.data['data']['records'];

      // Parse attendance_summary
      if (records['attendance_summary'] != null &&
          records['attendance_summary'].isNotEmpty) {
        attendanceSummary.value = StudentAttendanceSummaryModel.fromJson(
          records['attendance_summary'][0],
        );
      }

      // Parse subjectwise_attendance
      if (records['subjectwise_attendance'] != null) {
        subjectWiseAttendanceList.value =
            (records['subjectwise_attendance'] as List)
                .map((e) => SubjectWiseAttendanceModel.fromJson(e))
                .toList();
      }

      // Parse day_wise_attendance
      if (records['day_wise_attendance'] != null &&
          records['day_wise_attendance'].isNotEmpty) {
        final Map<String, dynamic> dayWiseMap =
            records['day_wise_attendance'][0];
        List<DailyAttendanceData> tempDayWiseList = [];
        dayWiseMap.forEach((dateString, percentage) {
          // Date format is DD-MM-YYYY, need to parse it correctly
          final parts = dateString.split('-');
          if (parts.length == 3) {
            final day = int.tryParse(parts[0]);
            final month = int.tryParse(parts[1]);
            final year = int.tryParse(parts[2]);
            if (day != null && month != null && year != null) {
              tempDayWiseList.add(
                DailyAttendanceData(
                  date: DateTime(year, month, day),
                  percentage: (percentage as num?)?.toDouble() ?? 0.0,
                ),
              );
            }
          }
        });
        // Sort by date to ensure correct order for chart
        tempDayWiseList.sort((a, b) => a.date.compareTo(b.date));
        dayWiseAttendanceList.value = tempDayWiseList;
      }
    } catch (e) {
      errorMessage.value = 'Error fetching student attendance: ${e.toString()}';
      print(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}
