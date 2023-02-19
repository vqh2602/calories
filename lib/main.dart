import 'dart:io';

import 'package:calories/c_theme/c_theme.dart';
import 'package:calories/modules/routers.dart';
import 'package:calories/modules/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: routes,
      theme: SThemeTask.lightTheme,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          // textDirection: AppTheme.textDirection,
          child: child!,
        );
      },
      localizationsDelegates: const [
        // Add this line
      ],
      locale: const Locale('vi'),
      transitionDuration: const Duration(milliseconds: 300),
      defaultTransition: Transition.fadeIn,
      initialRoute: SplashScreen.routeName,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
