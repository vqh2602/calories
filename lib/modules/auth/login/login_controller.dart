import 'package:calories/data/models/user.dart';
import 'package:calories/data/repositories/user_repo.dart';
import 'package:calories/modules/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  UserRepo userRepo = UserRepo();
  GetStorage box = GetStorage();
  late TextEditingController emailTE, passWTE;
  @override
  Future<void> onInit() async {
    super.onInit();
    initData();
    changeUI();
  }

  initData() {
    emailTE = TextEditingController();
    passWTE = TextEditingController();
  }

  Future<void> login({bool isLoginBiometric = false}) async {
    User? user;
    !isLoginBiometric
        ? user = await userRepo.loginWithEmail(
            email: emailTE.text, passW: passWTE.text)
        : user = await userRepo.loginWithBiometric();
    user != null ? Get.offAllNamed(SplashScreen.routeName) : null;
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
