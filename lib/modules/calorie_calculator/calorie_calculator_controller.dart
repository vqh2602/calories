import 'dart:async';

import 'package:get/get.dart';

class CalorieCalculatorController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  int selectItemScreen = 0;
  @override
  Future<void> onInit() async {
    changeUI();
    super.onInit();
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
