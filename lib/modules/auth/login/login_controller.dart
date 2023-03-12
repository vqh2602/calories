import 'package:calories/data/repositories/user_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  UserRepo userRepo = UserRepo();
  late TextEditingController emailTE, passWTE;
  @override
  Future<void> onInit() async {
    super.onInit();
    initData();
  }

  initData() {
    emailTE = TextEditingController();
    passWTE = TextEditingController();
  }

  Future<void> login() async {
    await userRepo.loginWithEmail(email: emailTE.text, passW: passWTE.text);
    changeUI();
  }

  String? validateEmail(String? value) {
    bool emailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value ?? '');
    return emailValid ? null : "Không đúng định dạng email";
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

  updateUI() {
    update();
  }

  loadingUI() {
    change(null, status: RxStatus.loading());
  }
}
