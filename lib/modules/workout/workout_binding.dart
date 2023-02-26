import 'package:calories/modules/workout/workout_controller.dart';
import 'package:get/get.dart';

class WorkoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkoutController>(() => WorkoutController());
  }
}
