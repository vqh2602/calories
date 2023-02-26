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

  initTE() {
    birthTE = TextEditingController();
  }

  String? validateString(String? text) {
    if (text == null || text.isEmpty) {
      return "Trường bắt buộc";
    }
    return null;
  }

  String? numberValidator(String? value) {
    if (value == null || value == '') {
      return null;
    }
    final n = num.tryParse(value);
    if (n == null) {
      return '$value không phải kiểu số';
    }
    return null;
  }

  String? validateEmail(String? value) {
    bool emailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value ?? '');
    return emailValid ? null : "Không đúng định dạng email";
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
