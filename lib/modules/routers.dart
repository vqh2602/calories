import 'package:calories/modules/dashboard/dashboard_binding.dart';
import 'package:calories/modules/dashboard/dashboard_screen.dart';
import 'package:calories/modules/home/home_binding.dart';
import 'package:calories/modules/home/home_screen.dart';
import 'package:calories/modules/setting/acc_detail/account_detail_binding.dart';
import 'package:calories/modules/setting/acc_detail/account_detail_screen.dart';
import 'package:calories/modules/setting/setting_binding.dart';
import 'package:calories/modules/setting/setting_screen.dart';
import 'package:calories/modules/splash/splash_binding.dart';
import 'package:calories/modules/splash/splash_screen.dart';
import 'package:calories/modules/statistical/statistical_binding.dart';
import 'package:calories/modules/statistical/statistical_screen.dart';
import 'package:calories/modules/workout/workout_binding.dart';
import 'package:calories/modules/workout/workout_screen.dart';
import 'package:get/get.dart';

List<GetPage> routes = [
  GetPage(
      name: SplashScreen.routeName,
      page: () => const SplashScreen(),
      binding: SplashBinding()),
  GetPage(
      name: SettingScreen.routeName,
      page: () => const SettingScreen(),
      binding: SettingBinding()),
  GetPage(
      name: HomeScreen.routeName,
      page: () => const HomeScreen(),
      binding: HomeBinding()),
  GetPage(
      name: DashboardScreen.routeName,
      page: () => const DashboardScreen(),
      binding: DashboardBinding()),
  GetPage(
      name: StatisticalScreen.routeName,
      page: () => const StatisticalScreen(),
      binding: StatisticalBinding()),
  GetPage(
      name: AccountDetailScreen.routeName,
      page: () => const AccountDetailScreen(),
      binding: AccountDetailBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: WorkoutScreen.routeName,
      page: () => const WorkoutScreen(),
      binding: WorkoutBinding()),
];
