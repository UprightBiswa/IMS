import 'package:get/get.dart';

class AttendanceTabController extends GetxController {
  var selectedTabIndex = 0.obs;

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
