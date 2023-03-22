import 'dart:async';
import 'dart:typed_data';

import 'package:calories/data/repositories/user_repo.dart';
import 'package:calories/modules/auth/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignupController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  UserRepo userRepo = UserRepo();
  GetStorage box = GetStorage();
  bool sex = true;
  Uint8List? base64Image;
  String base64ImageConvert = '';
  late TextEditingController firstNameTE,
      lastNameTE,
      emailTE,
      passWTE,
      confirmPassTE,
      birthTE,
      heightTE,
      weightTE,
      addressTE;

  @override
  Future<void> onInit() async {
    super.onInit();
    initTE();
    changeUI();
  }

  initTE() {
    firstNameTE = TextEditingController();
    lastNameTE = TextEditingController();
    emailTE = TextEditingController();
    passWTE = TextEditingController();
    confirmPassTE = TextEditingController();
    birthTE = TextEditingController();
    heightTE = TextEditingController();
    weightTE = TextEditingController();
    addressTE = TextEditingController();
  }

  Future<void> signup() async {
    await userRepo.signupWithEmail(
      name: '${firstNameTE.text}@${lastNameTE.text}',
      email: emailTE.text,
      passW: passWTE.text,
      birth: birthTE.text,
      sex: sex,
      height: double.parse(heightTE.text),
      weight: double.parse(weightTE.text),
      address: addressTE.text,
      avatar: ' ',
    );

    Get.offAllNamed(LoginScreen.routeName);
    changeUI();
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

  String? validatePass(String? value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return (regExp.hasMatch(value ?? '') && ((value ?? '').length > 7))
        ? null
        : 'Mật khẩu không đủ mạnh';
  }

  String? validateConfirmPass(String? value) {
    return (value == passWTE.text ? null : 'Mật khẩu không khớp');
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
