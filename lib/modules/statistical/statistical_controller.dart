import 'dart:async';

import 'package:get/get.dart';

class StatisticalController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  changeUI() {
    change(null, status: RxStatus.success());
  }
  updateUI(){
    update();
  }
  loadingUI(){
    change(null,status: RxStatus.loading());
  }
}