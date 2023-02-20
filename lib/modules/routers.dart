import 'package:calories/modules/dashboard/dashboard_binding.dart';
import 'package:calories/modules/dashboard/dashboard_screen.dart';
import 'package:calories/modules/home/home_binding.dart';
import 'package:calories/modules/home/home_screen.dart';
import 'package:calories/modules/splash/splash_binding.dart';
import 'package:calories/modules/splash/splash_screen.dart';
import 'package:get/get.dart';

List<GetPage> routes = [
  GetPage(
      name: SplashScreen.routeName,
      page: () => const SplashScreen(),
      binding: SplashBinding()),
  GetPage(
      name: HomeScreen.routeName,
      page: () => const HomeScreen(),
      binding: HomeBinding()),
  GetPage(
      name: DashboardScreen.routeName,
      page: () => const DashboardScreen(),
      binding: DashboardBinding()),
];
