import 'dart:async';

import 'package:get/get.dart';

class SplashController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  @override
  Future<void> onInit() async {
    super.onInit();
    changeUI();
    Future.delayed(const Duration(seconds: 2), () {});
  }

  changeUI() {
    change(null, status: RxStatus.success());
  }

  updateUI() {
    update();
  }

  loadingUI() {
    change(null, status: RxStatus.loading());
  }
}
