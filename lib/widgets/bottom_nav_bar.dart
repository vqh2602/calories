import 'package:calories/modules/dashboard/dashboard_screen.dart';
import 'package:calories/modules/setting/setting_screen.dart';
import 'package:calories/modules/statistical/statistical_screen.dart';
import 'package:calories/modules/workout/workout_screen.dart';
import 'package:calories/widgets/library/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

Widget bottomNavigationBar(
    {int selectedIndex = 0, required Function(int) onSelect}) {
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
}

List<FlashyTabBarItem> items = [
  FlashyTabBarItem(
    icon: const Icon(LucideIcons.home),
    title: const Text('Trang chủ'),
    inactiveColor: Colors.grey,
  ),
  FlashyTabBarItem(
    icon: const Icon(LucideIcons.personStanding),
    title: const Text('Tập luyện'),
    inactiveColor: Colors.grey,
  ),
  FlashyTabBarItem(
    icon: const Icon(LucideIcons.barChart2),
    title: const Text('Thống kê'),
    inactiveColor: Colors.grey,
  ),
  FlashyTabBarItem(
    icon: const Icon(LucideIcons.settings),
    title: const Text('Thiết đặt'),
    inactiveColor: Colors.grey,
  ),
];

List<Widget> widgetOptions = <Widget>[
  const DashboardScreen(),
  const WorkoutScreen(),
  const StatisticalScreen(),
  const SettingScreen()
];
