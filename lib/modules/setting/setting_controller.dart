import 'dart:async';

import 'package:calories/data/storage.dart';
import 'package:calories/modules/splash/splash_screen.dart';
import 'package:calories/widgets/share_function/share_funciton.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class SettingController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  final LocalAuthentication auth = LocalAuthentication();
  GetStorage box = GetStorage();
  bool isBiometric = false;
  @override
  Future<void> onInit() async {
    changeUI();
    isGetBiometric();
    super.onInit();
  }

  Future<void> logout() async {
    box.write(Storages.dataLoginTime, null);
    box.write(Storages.dataUser, null);
    Get.offAllNamed(SplashScreen.routeName);
  }

  Future<void> initBiometric(bool? isBiometric) async {
    loadingUI();
    bool didAuthenticate = false;
    if (isBiometric != null && isBiometric) {
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
      await box.write(Storages.dataBiometric, true);
      buildToast(
          title: 'Bật đăng nhập nhanh thành công', type: TypeToast.success);
    } else {
      await box.write(Storages.dataBiometric, false);
      // buildToast(
      //     title: 'Bật đăng nhập nhanh thất bại', type: TypeToast.failure);
    }
    isGetBiometric();
  }

  Future<void> isGetBiometric() async {
    isBiometric = box.read(Storages.dataBiometric) ?? false;
    changeUI();
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
