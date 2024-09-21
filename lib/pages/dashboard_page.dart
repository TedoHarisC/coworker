import 'package:coworker/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardController dashboardController =
      Get.put(DashboardController());

  @override
  void dispose() {
    dashboardController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => dashboardController.currentFragment),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: dashboardController.index,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            dashboardController.index = value;
          },
          selectedFontSize: 14,
          unselectedFontSize: 12,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            height: 2,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            height: 2,
          ),
          items: dashboardController.menu.map((e) {
            return BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(e['icon_off'])),
              label: e['label'],
            );
          }).toList(),
        );
      }),
    );
  }
}
