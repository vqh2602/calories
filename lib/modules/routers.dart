import 'package:calories/modules/splash/splash_binding.dart';
import 'package:calories/modules/splash/splash_screen.dart';
import 'package:get/get.dart';

List<GetPage> routes = [
  GetPage(
      name: SplashScreen.routeName,
      page: () => const SplashScreen(),
      binding: SplashBinding()),
];
