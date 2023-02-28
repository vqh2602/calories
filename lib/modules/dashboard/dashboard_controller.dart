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
