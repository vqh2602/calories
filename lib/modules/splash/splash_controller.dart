import 'dart:async';

import 'package:calories/data/storage.dart';
import 'package:calories/modules/auth/login/login_screen.dart';
import 'package:calories/modules/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  GetStorage box = GetStorage();
  @override
  Future<void> onInit() async {
    super.onInit();
    changeUI();
  }

  Future<void> checkLogin() async {
    var dataUser = await box.read(Storages.dataUser);
    //kiểm tra dữ liệu user và thời gian đăng nhập
    if (dataUser != null && await checkLoginTimeOut()) {
      Future.delayed(const Duration(seconds: 4), () {
        Get.offAndToNamed(HomeScreen.routeName);
      });
    } else {
      Future.delayed(const Duration(seconds: 4), () {
        Get.offAndToNamed(LoginScreen.routeName);
      });
    }
  }

  Future<bool> checkLoginTimeOut() async {
    var dataTimeOut = await box.read(Storages.dataLoginTime);
    if (dataTimeOut != null) {
      // Kiểm tra một thời điểm có nằm trong một khoảng thời gian hay không
      try {
        DateTime dateTime = DateTime.now();
        DateTime startDate = DateTime.parse(dataTimeOut);
        DateTime endDate =
            startDate.add(const Duration(hours: Config.dataLoginTimeOut));
        if (dateTime.isAfter(startDate) && dateTime.isBefore(endDate)) {
          return true;
        } else {}
      } on Exception catch (_) {
        return false;
      }
    }
    return false;
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
