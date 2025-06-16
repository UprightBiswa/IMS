import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../controllers/today_class_controller.dart';
import '../model/today_class_model.dart';

class TodaysClassesSection extends StatelessWidget {
  const TodaysClassesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TodayClassController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Classes",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Text(
                "View All",
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.classes.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final classItem = controller.classes[index];
              return TodayClassesItem(classItem: classItem);
            },
          ),
        ],
      );
    });
  }
}

class TodayClassesItem extends StatelessWidget {
  final TodayClassModel classItem;
  const TodayClassesItem({super.key, required this.classItem});

  @override
  Widget build(BuildContext context) {
    final bool status = classItem.status.toLowerCase() == 'online';
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFFEFEFE),
        border: Border.all(color: AppColors.cardBorder, width: 0.8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: classItem.color,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        classItem.subject,
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          classItem.time,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        classItem.professor,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    const SizedBox(width: 8),

                    //status
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: status ? Color(0xFFEDFAF5) : Color(0xFFDFE0FC),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 0.8,
                          color: status ? Color(0xFFEBF9F4) : Color(0xFFF2F2Fd),
                        ),
                      ),
                      child: Text(
                        classItem.status,
                        style: TextStyle(
                          color: status ? Color(0xFF87D3B4) : Color(0xFFA1A1F5),
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
