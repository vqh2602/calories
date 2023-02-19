import 'package:animated_text_kit/animated_text_kit.dart';
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
  Widget build(BuildContext context) {
    return buildBody(context: context, body: _buildBody(), appBar: null);
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 250.0,
              child: DefaultTextStyle(
                style: josefinSans(
                    fontSize: 54, color: Get.theme.colorScheme.onBackground),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText('Calories'),
                  ],
                  onTap: () {},
                ),
              ),
            ),
            textDisplayLarge(text: 'textDisplayLarge'),
            textDisplayMedium(text: 'textDisplayMedium'),
            textDisplaySmall(text: 'textDisplaySmall'),
            textBodyLarge(text: 'textBodyLarge'),
            textBodyMedium(text: 'textBodyMedium'),
            textBodySmall(text: 'textBodySmall'),
            textTitleLarge(text: ' textTitleLarge'),
            textTitleMedium(text: 'textTitleMedium'),
            textTitleSmall(text: 'textTitleSmall'),
            textHeadlineLarge(text: 'textHeadlineLarge'),
            textHeadlineMedium(text: 'textHeadlineMedium'),
            textHeadlineSmall(text: 'textHeadlineSmall'),
            textLableLarge(text: 'textLableLarge'),
            textLableMedium(text: 'textLableMedium'),
            textLableSmall(text: 'textLableSmall'),
            Container(
              color: Colors.red,
              width: Get.width,
              height: 200,
              child: Container(
                  margin: alignment_20_8(),
                  color: Colors.white,
                  child: textLableLarge(text: 'căn lề 20.8')),
            ),
            Container(
              color: Colors.green,
              width: Get.width,
              height: 200,
              child: Container(
                  margin: alignment_20_0(),
                  color: Colors.white,
                  child: textLableLarge(text: 'căn lề 20')),
            ),
          ],
        ),
      ),
    );
  }
}
