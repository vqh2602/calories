
import 'package:calories/modules/setting/acc_detail/account_detail_controller.dart';
import 'package:get/get.dart';

class AccountDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountDetailController>(() => AccountDetailController());
  }
}