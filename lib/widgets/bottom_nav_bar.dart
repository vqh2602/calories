import 'package:calories/modules/dashboard/dashboard_screen.dart';
import 'package:calories/modules/setting/setting_screen.dart';
import 'package:calories/widgets/color_custom.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

Widget bottomNavigationBar(
    {int selectedIndex = 0, required Function(int) onSelect}) {
  return StatefulBuilder(builder: (context, setState) {
    return FlashyTabBar(
      selectedIndex: selectedIndex,
      showElevation: true,
      animationCurve: Curves.elasticInOut,
      animationDuration: const Duration(milliseconds: 700),
      iconSize: 24,
      backgroundColor: Get.theme.colorScheme.background,
      onItemSelected: onSelect,
      items: items,
    );
  });
}

List<FlashyTabBarItem> items = [
  FlashyTabBarItem(
    icon: const Icon(LucideIcons.home),
    title: const Text('Trang chủ'),
    activeColor: colorBlack1,
    inactiveColor: Colors.grey,
  ),
  FlashyTabBarItem(
    icon: const Icon(LucideIcons.personStanding),
    title: const Text('Tập luyện'),
    activeColor: colorBlack1,
    inactiveColor: Colors.grey,
  ),
  FlashyTabBarItem(
    icon: const Icon(LucideIcons.barChart2),
    title: const Text('Thống kê'),
    activeColor: colorBlack1,
    inactiveColor: Colors.grey,
  ),
  FlashyTabBarItem(
    icon: const Icon(LucideIcons.settings),
    title: const Text('Thiết đặt'),
    activeColor: colorBlack1,
    inactiveColor: Colors.grey,
  ),
];

List<Widget> widgetOptions = <Widget>[
  const DashboardScreen(),
  Container(
    color: Colors.green,
    width: Get.width,
    height: Get.height,
  ),
  Container(
    color: Colors.amber,
    width: Get.width,
    height: Get.height,
  ),
  const SettingScreen()
];
