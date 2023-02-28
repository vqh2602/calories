import 'package:get/get.dart';

class DashboardController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  @override
  Future<void> onInit() async {
    super.onInit();
    loadingUI();
    Future.delayed(const Duration(seconds: 4), () {
      changeUI();
    });
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
