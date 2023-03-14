import 'dart:convert';
import 'dart:developer';

import 'package:calories/data/models/user.dart';
import 'package:calories/data/repositories/repo.dart';
import 'package:calories/data/storage.dart';
import 'package:calories/widgets/share_function/share_funciton.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/types/auth_messages_ios.dart';

class UserRepo extends Repo {
  GetStorage box = GetStorage();
  final LocalAuthentication auth = LocalAuthentication();
  // lấy thông tin ng dùng
  Future<User?> getUserByID(
      {required String userID, bool isCached = false}) async {
    User? user;
    if (isCached) {
      user = User.fromJson(jsonDecode(box.read(Storages.dataUser)));
    } else {
      var res = await dioRepo.get('/api/v1/users/$userID');
      var result = jsonDecode(res.toString());
      if (result["success"]) {
        user = User.fromJson(result['data']);
       await box.write(Storages.dataUser, jsonEncode(result['data']));
      } else {
        buildToast(type: TypeToast.failure, title: result["message"]);
      }
    }
    return user;
  }

  // đăng nhập
  Future<User?> loginWithEmail(
      {required String email, required String passW}) async {
    User? user;
    var res = await dioRepo
        .post('/api/login', data: {"email": email, "password": passW});
    var result = jsonDecode(res.toString());
    if (result["success"] ?? false) {
      user = User.fromJson(result['data']);
      await box.write(Storages.dataUser, jsonEncode(result['data']));
      await box.write(Storages.dataEmail, email);
      await box.write(Storages.dataPassWord, passW);
      await box.write(Storages.dataLoginTime, DateTime.now().toString());
      buildToast(
          type: TypeToast.success,
          title: 'Đăng nhập thành công',
          message: 'Chào mừng ${user.name}');
    } else {
      buildToast(
          type: TypeToast.failure, title: result["message"] ?? 'có lỗi sảy ra');
    }
    log('Đăng nhập, user: ${user?.toJson().toString()}');
    return user;
  }

  // đăng nhập sinh trắc học
  Future<User?> loginWithBiometric() async {
    User? user;
    bool didAuthenticate = false;
    if (box.read(Storages.dataBiometric) ?? false) {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
      final List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      if (canAuthenticate && availableBiometrics.isNotEmpty) {
        didAuthenticate = await auth.authenticate(
            localizedReason: 'Vui lòng xác thực',
            options: const AuthenticationOptions(),
            authMessages: <AuthMessages>[
              const AndroidAuthMessages(
                  signInTitle: 'Xác thực',
                  biometricHint: 'xác thực để tiếp tục',
                  cancelButton: 'Hủy',
                  biometricSuccess: 'Thành công!',
                  biometricRequiredTitle:
                      'Chưa thiết lập phương thức bảo mật nào',
                  biometricNotRecognized: 'Xác thực không thành công!',
                  goToSettingsButton: 'Cài đặt',
                  goToSettingsDescription: 'Chuyển đến cài đặt'),
              const IOSAuthMessages(
                cancelButton: 'Hủy',
              ),
            ]);
      }
    }
    if (didAuthenticate) {
      user = await loginWithEmail(
          email: box.read(Storages.dataEmail),
          passW: box.read(Storages.dataPassWord));
    } else {
      Get.dialog(CupertinoAlertDialog(
        title: textBodyMedium(text: 'chưa bật đăng nhập bằng sinh trắc học'),
      ));
    }
    log('Đăng nhập sinh trac học, user: ${user?.toJson().toString()}');
    return user;
  }

  // đăng k
  Future<User?> signupWithEmail(
      {required String email, required String passW}) async {
    User user = User();
    var res = await dioRepo.get('/api/register');
    var result = jsonDecode(res.toString());
    if (result["success"]) {
      user = User.fromJson(result['data']);
      box.write(Storages.dataUser, jsonEncode(result['data']));
    } else {
      buildToast(type: TypeToast.failure, title: result["message"]);
    }
    return user;
  }
}
