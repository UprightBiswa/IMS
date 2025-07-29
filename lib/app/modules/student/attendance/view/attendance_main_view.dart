// import 'package:attendance_demo/app/theme/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../widgets/custom_app_bar.dart';
// import '../../../../widgets/custom_drawer.dart';
// import '../../home/views/home_view.dart';
// import '../controllers/attendance_tab_controller.dart';
// import 'attendance_calendar_screen.dart';
// import 'attendance_leave_request_screen.dart';
// import 'attendance_overview_screen.dart';

// class AttendanceMainView extends StatelessWidget {
//   AttendanceMainView({super.key});
//   final AttendanceTabController controller = Get.put(AttendanceTabController());

//   final List<Widget> pages = const [
//     HomeView(),
//     AttendanceOverviewTab(),
//     AttendanceCalendarTab(),
//     AttendanceLeaveTab(),
//   ];

//   final List<IconData> icons = const [
//     Icons.home_rounded,
//     Icons.bar_chart_rounded,
//     Icons.calendar_today_rounded,
//     Icons.beach_access_rounded,
//   ];

//   final List<String> labels = const ['Home', 'Overview', 'Calendar', 'Leave'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // drawer: const CustomDrawer(),
//       // appBar: const CustomAppBar(title: 'Attendance Management'),
//       drawer: const CustomDrawer(),
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: Obx(() {
//           final isHome = controller.selectedTabIndex.value == 0;
//           return CustomAppBar(
//             isHome: isHome,
//             title: isHome ? '' : 'Attendance Management',
//           );
//         }),
//       ),
//       body: Obx(() => pages[controller.selectedTabIndex.value]),
//       bottomNavigationBar: AnimatedBottomNavBar(controller: controller),

//       //   bottomNavigationBar: Obx(() {
//       //     return Container(
//       //       height: 80,
//       //       decoration: BoxDecoration(
//       //         color: Color(0xFF00204A),
//       //         borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//       //         boxShadow: [
//       //           BoxShadow(
//       //             color: Colors.black.withOpacity(0.15),
//       //             blurRadius: 8,
//       //             offset: const Offset(0, -2),
//       //           ),
//       //         ],
//       //       ),
//       //       child: Row(
//       //         mainAxisAlignment: MainAxisAlignment.spaceAround,
//       //         children: List.generate(4, (index) {
//       //           final isSelected = controller.selectedTabIndex.value == index;
//       //           return GestureDetector(
//       //             onTap: () => controller.changeTab(index),
//       //             child: AnimatedContainer(
//       //               duration: const Duration(milliseconds: 300),
//       //               curve: Curves.easeInOut,
//       //               padding: const EdgeInsets.symmetric(
//       //                 horizontal: 12,
//       //                 vertical: 8,
//       //               ),
//       //               decoration: BoxDecoration(
//       //                 color: isSelected ? Colors.white : Colors.transparent,
//       //                 borderRadius: BorderRadius.circular(20),
//       //               ),
//       //               child: Column(
//       //                 mainAxisAlignment: MainAxisAlignment.center,
//       //                 children: [
//       //                   Icon(
//       //                     icons[index],
//       //                     color: isSelected ? Color(0xFF00204A) : Colors.white,
//       //                     size: 24,
//       //                   ),
//       //                   const SizedBox(height: 4),
//       //                   Text(
//       //                     labels[index],
//       //                     style: TextStyle(
//       //                       fontSize: 12,
//       //                       color: isSelected
//       //                           ? Color(0xFF00204A)
//       //                           : Colors.white70,
//       //                       fontWeight: isSelected
//       //                           ? FontWeight.bold
//       //                           : FontWeight.normal,
//       //                     ),
//       //                   ),
//       //                 ],
//       //               ),
//       //             ),
//       //           );
//       //         }),
//       //       ),
//     );
//     // }),
//   }
// }

// class AnimatedBottomNavBar extends StatelessWidget {
//   final AttendanceTabController controller;
//   final List<IconData> icons = const [
//     Icons.home,
//     Icons.bar_chart_rounded,
//     Icons.calendar_today,
//     Icons.time_to_leave,
//   ];

//   final List<String> labels = const ['Home', 'Overview', 'Calendar', 'Leave'];

//   AnimatedBottomNavBar({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Container(
//         height: 80,
//         decoration: BoxDecoration(
//           color: const Color(0xFF00204A),
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.15),
//               blurRadius: 10,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: List.generate(4, (index) {
//             final isSelected = controller.selectedTabIndex.value == index;
//             return GestureDetector(
//               onTap: () => controller.changeTab(index),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 400),
//                 curve: Curves.easeInOutCubic,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 8,
//                 ),
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.white : Colors.transparent,
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 child: AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 300),
//                   transitionBuilder: (child, animation) =>
//                       ScaleTransition(scale: animation, child: child),
//                   child: Row(
//                     key: ValueKey(isSelected),
//                     children: [
//                       Icon(
//                         icons[index],
//                         size: 24,
//                         color: isSelected
//                             ? const Color(0xFF00204A)
//                             : Colors.white,
//                       ),
//                       const SizedBox(width: 6),
//                       if (isSelected)
//                         Text(
//                           labels[index],
//                           style: const TextStyle(
//                             color: Color(0xFF00204A),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//       );
//     });
//   }
// }
// import 'package:attendance_demo/app/theme/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../widgets/custom_app_bar.dart';
// import '../../../../widgets/custom_drawer.dart';
// import '../../home/views/home_view.dart';
// import '../controllers/attendance_tab_controller.dart';
// import 'attendance_calendar_screen.dart';
// import 'attendance_leave_request_screen.dart';
// import 'attendance_overview_screen.dart';

// // Import the new custom widgets
// import '../widgets/nav_button.dart';
// import '../widgets/nav_custom_painter.dart';

// class AttendanceMainView extends StatelessWidget {
//   AttendanceMainView({super.key});
//   final AttendanceTabController controller = Get.put(AttendanceTabController());

//   final List<Widget> pages = const [
//     HomeView(),
//     AttendanceOverviewTab(),
//     AttendanceCalendarTab(),
//     AttendanceLeaveTab(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: const CustomDrawer(),
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: Obx(() {
//           final isHome = controller.selectedTabIndex.value == 0;
//           return CustomAppBar(
//             isHome: isHome,
//             title: isHome ? '' : 'Attendance Management',
//           );
//         }),
//       ),
//       body: Obx(() => pages[controller.selectedTabIndex.value]),
//       // Use the refactored AnimatedBottomNavBar
//       bottomNavigationBar: AnimatedBottomNavBar(controller: controller),
//     );
//   }
// }

// class AnimatedBottomNavBar extends StatefulWidget {
//   final AttendanceTabController controller;

//   const AnimatedBottomNavBar({super.key, required this.controller});

//   @override
//   State<AnimatedBottomNavBar> createState() => _AnimatedBottomNavBarState();
// }

// class _AnimatedBottomNavBarState extends State<AnimatedBottomNavBar>
//     with SingleTickerProviderStateMixin {
//   late double _startingPos;
//   late int _endingIndex;
//   late double _currentPos;
//   double _buttonHide = 0;

//   late AnimationController _animationController;
//   late int _totalItems;

//   final List<IconData> icons = const [
//     Icons.home_rounded,
//     Icons.bar_chart_rounded,
//     Icons.calendar_today_rounded,
//     Icons.beach_access_rounded,
//   ];

//   final List<String> labels = const ['Home', 'Overview', 'Calendar', 'Leave'];

//   static const double _barHeight = 75.0; // Height of the main bar area
//   static const double _circleRadius = 30.0; // Radius of the floating circle

//   @override
//   void initState() {
//     super.initState();
//     _totalItems = icons.length;
//     _currentPos = widget.controller.selectedTabIndex.value / _totalItems;
//     _startingPos = _currentPos;
//     _endingIndex = widget.controller.selectedTabIndex.value;

//     _animationController = AnimationController(
//       vsync: this,
//       value: _currentPos,
//       duration: const Duration(milliseconds: 600),
//       animationBehavior: AnimationBehavior.normal,
//     );

//     _animationController.addListener(() {
//       setState(() {
//         _currentPos = _animationController.value;
//         final endingPosNormalized = _endingIndex / _totalItems;
//         final startingPosNormalized = _startingPos;

//         final middle = (endingPosNormalized + startingPosNormalized) / 2;

//         _buttonHide =
//             (1 -
//                     ((middle - _currentPos) / (startingPosNormalized - middle))
//                         .abs())
//                 .abs();
//         _buttonHide = _buttonHide.clamp(0.0, 1.0);
//       });
//     });

//     widget.controller.selectedTabIndex.listen((newIndex) {
//       if (newIndex != _endingIndex) {
//         _buttonTap(newIndex);
//       }
//     });
//   }

//   @override
//   void didUpdateWidget(covariant AnimatedBottomNavBar oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.controller.selectedTabIndex.value !=
//         widget.controller.selectedTabIndex.value) {
//       _buttonTap(widget.controller.selectedTabIndex.value);
//     }
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _buttonTap(int index) {
//     if (_animationController.isAnimating) {
//       return;
//     }

//     widget.controller.changeTab(index);

//     final newPositionNormalized = index / _totalItems;
//     setState(() {
//       _startingPos = _currentPos;
//       _endingIndex = index;
//       _animationController.animateTo(
//         newPositionNormalized,
//         duration: const Duration(milliseconds: 600),
//         curve: Curves.easeOutCubic, // Keep consistent
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final textDirection = Directionality.of(context);

//     return SizedBox(
//       height: _barHeight + _circleRadius,
//       child: Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.bottomCenter,
//         children: <Widget>[
//           // The CustomPaint for the curved background
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: CustomPaint(
//               painter: NavCustomPainter(
//                 _currentPos,
//                 _totalItems,
//                 const Color(0xFF00204A), // Your deep blue color
//                 textDirection,
//               ),
//               child: Container(
//                 height: _barHeight,
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//                 ),
//               ),
//             ),
//           ),
//           // The floating selected item (icon only in a circle)
//           Positioned(
//             // Adjust bottom to make the circle pop up centered on the curve
//             bottom:
//                 _barHeight / 2 -
//                 _circleRadius / 2 -
//                 ((1 - _buttonHide) *
//                     _circleRadius *
//                     1.5),
//             left: textDirection == TextDirection.rtl
//                 ? null
//                 : (_currentPos * MediaQuery.of(context).size.width) +
//                       (MediaQuery.of(context).size.width / _totalItems / 2) -
//                       _circleRadius, // Center the circle
//             right: textDirection == TextDirection.rtl
//                 ? (_currentPos * MediaQuery.of(context).size.width) +
//                       (MediaQuery.of(context).size.width / _totalItems / 2) -
//                       _circleRadius
//                 : null,
//             child: Center(
//               child: Transform.scale(
//                 scale:
//                     1.0 +
//                     (1 - _buttonHide) *
//                         0.2, // Scale up slightly when fully visible
//                 child: Material(
//                   color: Colors.white, // White background for the circle
//                   type: MaterialType.circle,
//                   elevation: 6, // Add some shadow for floating effect
//                   child: Padding(
//                     padding: const EdgeInsets.all(
//                       12.0,
//                     ), // Padding inside the circle
//                     child: Icon(
//                       icons[_endingIndex], // Display the icon of the current ending index
//                       color: const Color(0xFF00204A), // Icon color
//                       size: 24,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // The row of all navigation buttons (icons and labels, fading out when selected)
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: SizedBox(
//               height: _barHeight,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: List.generate(_totalItems, (index) {
//                   final isSelected =
//                       widget.controller.selectedTabIndex.value == index;
//                   return NavButton(
//                     onTap: _buttonTap,
//                     animatedPosition: _currentPos,
//                     totalItems: _totalItems,
//                     itemIndex: index,
//                     barHeight: _barHeight,
//                     iconData: icons[index], // Pass IconData
//                     label: labels[index], // Pass label
//                     isSelected: isSelected, // Pass selection state
//                   );
//                 }),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_drawer.dart';
import '../../home/views/home_view.dart';
import '../controllers/attendance_tab_controller.dart';
import 'attendance_calendar_screen.dart';
import 'attendance_leave_request_screen.dart';
import 'attendance_overview_screen.dart';

// Import the CurvedNavigationBar package
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class AttendanceMainView extends StatelessWidget {
  AttendanceMainView({super.key});
  final AttendanceTabController controller = Get.put(AttendanceTabController());

  final List<Widget> pages = const [
    HomeView(),
    AttendanceOverviewTab(),
    AttendanceCalendarTab(),
    AttendanceLeaveTab(),
  ];

  // Define both outlined and filled versions of icons
  final List<IconData> outlinedIcons = const [
    Icons.home_outlined,
    Icons.bar_chart_outlined, // For Attendance/Overview
    Icons.calendar_month_outlined, // For Calendar
    Icons.beach_access_outlined, // A better icon for Leave/Vacation
  ];

  final List<IconData> filledIcons = const [
    Icons.home_filled,
    Icons.bar_chart, // Filled version for Attendance/Overview
    Icons.calendar_month, // Filled version for Calendar
    Icons.beach_access, // Filled version for Leave/Vacation
  ];

  final List<String> labels = const ['Home', 'Attendance', 'Calendar', 'Leave'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() {
          final isHome = controller.selectedTabIndex.value == 0;
          return CustomAppBar(
            isHome: isHome,
            title: isHome ? '' : 'Attendance Management',
          );
        }),
      ),
      body: Obx(() => pages[controller.selectedTabIndex.value]),
      bottomNavigationBar: Obx(() {
        return CurvedNavigationBar(
          index: controller.selectedTabIndex.value, // Current selected index
          height: 75.0, // Height of the navigation bar
          // FIX: Use one of the icon lists' lengths, e.g., outlinedIcons.length
          items: List.generate(outlinedIcons.length, (index) {
            final isSelected = controller.selectedTabIndex.value == index;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  // Choose outlined or filled icon based on selection state
                  isSelected ? filledIcons[index] : outlinedIcons[index],
                  size: 24, // Consistent size for all icons
                  // Icon color for items in the main bar (unselected).
                  // The icon for the *selected* tab, which goes into the floating circle,
                  // will have its color defined here to be white.
                  color: isSelected
                      ? Colors.white
                      : Colors
                            .white54, // White for selected icon (in floating circle), dim white for unselected
                ),
                if (!isSelected) // Only show label if NOT selected
                  Text(
                    labels[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
              ],
            );
          }),
          color: const Color(
            0xFF00204A,
          ), // Background color of the main bar (deep blue)
          buttonBackgroundColor: const Color(
            0xFF00204A,
          ), // Floating circle color is also deep blue
          backgroundColor: Colors
              .transparent, // Important for seamless curve cutout against Scaffold background
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            controller.changeTab(index); // Update GetX controller
          },
          letIndexChange: (index) => true, // Allows changing index
        );
      }),
    );
  }
}
