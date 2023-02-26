import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:calories/modules/auth/login/login_screen.dart';
import 'package:calories/modules/home/home_screen.dart';
import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      // Get.offAndToNamed(HomeScreen.routeName);
      Get.offAndToNamed(LoginScreen.routeName);
      // Get.offAndToNamed(SignupScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
      appBar: null,
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Center(
        child: DefaultTextStyle(
          style: josefinSans(
              fontSize: 54, color: Get.theme.colorScheme.onBackground),
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText('Calories'),
            ],
            totalRepeatCount: 1,
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
