import 'package:calories/c_theme/c_theme.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadingCustom extends StatelessWidget {
  const LoadingCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      color: Get.theme.colorScheme.background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Calories',
              style: josefinSans(
                  fontSize: 54, color: Get.theme.colorScheme.onBackground),
            ),
            Container(
                // color: Colors.cyan,
                margin: EdgeInsets.zero,
                height: 20,
                child: Lottie.asset(
                    !ThemeService().loadThemeFromBox()
                        ? 'assets/animate/line_loading.json'
                        : 'assets/animate/line_loading_w.json',
                    width: Get.width,
                    fit: BoxFit.fill)),
          ],
        ),
      ),
    );
  }
}
