import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:calories/modules/splash/splash_controller.dart';
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
  SplashController splashController = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    splashController.checkLogin();
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
