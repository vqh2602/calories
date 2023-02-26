import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  TextEditingController? birthTE;

  @override
  Future<void> onInit() async {
    super.onInit();
    initTE();
    changeUI();
  }
  initTE(){
    birthTE = TextEditingController(text: '');
  }

  String? validateString(String? text) {
    if (text == null || text.isEmpty) {
      return "Trường bắt buộc";
    }
    return null;
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
