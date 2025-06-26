import 'package:get/get.dart';

class GradesTabController extends GetxController {
  var selectedTabIndex = 0.obs;

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
