import 'package:calories/modules/workout/workout_detail/workout_detail_controller.dart';
import 'package:get/get.dart';

class WorkoutDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkoutDetailController>(() => WorkoutDetailController());
  }
}
