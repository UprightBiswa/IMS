import 'package:get/get.dart';
import '../model/today_class_model.dart';

class TodayClassController extends GetxController {
  var classes = <TodayClassModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchClasses();
  }

  Future<void> fetchClasses() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate API delay

    final dummyJson = [
      {
        'subject': 'Data Structures',
        'professor': 'Dr. Priya Sharma',
        'time': '10:00 AM - 11:00 AM',
        'color': '0xFF2962FF',
      },
      {
        'subject': 'Database Management',
        'professor': 'Prof. Rajesh Kumar',
        'time': '11:30 AM - 12:30 PM',
        'color': '0xFF00C853',
        'status': 'Offline',
      },
      {
        'subject': 'Computer Networks',
        'professor': 'Dr. Amit Palod',
        'time': '2:00 PM - 3:00 PM',
        'color': '0xFFFFAB00',
      },
    ];

    classes.value = dummyJson.map((e) => TodayClassModel.fromJson(e)).toList();
    isLoading.value = false;
  }
}
