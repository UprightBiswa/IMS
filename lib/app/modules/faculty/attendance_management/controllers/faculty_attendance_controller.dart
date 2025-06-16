import 'package:get/get.dart';

class FacultyAttendanceController extends GetxController {
  final RxInt selectedMainTab = 0.obs; 

  void changeMainTab(int index) {
    selectedMainTab.value = index;
  }
}