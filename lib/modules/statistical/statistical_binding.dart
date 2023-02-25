import 'package:calories/modules/statistical/statistical_controller.dart';
import 'package:get/get.dart';

class StatisticalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatisticalController>(() => StatisticalController());
  }
}