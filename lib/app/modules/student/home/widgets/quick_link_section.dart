import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/quick_link_controller.dart';

class QuickLinksSection extends StatelessWidget {
  const QuickLinksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuickLinkController());

    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFFEFEFE),
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: Color(0xFFEFEFF0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Quick Links",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.quickLinks.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: .95,
              ),
              itemBuilder: (context, index) {
                final item = controller.quickLinks[index];
                return GestureDetector(
                  onTap: () => Get.toNamed(item.route),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFF7F9FA),
                      border: Border.all(color: Color(0xFFEDF1F4), width: 1.07),
                      // color: Color(0xFFFEFEFE),
                      // border: Border.all(
                      //   color: Color(0xFF343333).withValues(alpha: .30),
                      // ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue,
                          child: Icon(item.icon, size: 20, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF000000).withValues(alpha: .50),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
