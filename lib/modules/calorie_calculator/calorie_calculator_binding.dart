import 'package:calories/modules/calorie_calculator/calorie_calculator_controller.dart';
import 'package:get/get.dart';

class CalorieCalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalorieCalculatorController>(
        () => CalorieCalculatorController());
  }
}
