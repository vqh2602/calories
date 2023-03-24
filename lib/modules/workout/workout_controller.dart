import 'package:calories/data/models/workouts.dart';
import 'package:calories/data/repositories/workout_repo.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WorkoutController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  WorkoutRepo workoutRepo = WorkoutRepo();
  GetStorage box = GetStorage();

  List<Workout?> listWorkouts = [];
  List<Workout?> listWorkoutsResult = [];

  @override
  Future<void> onInit() async {
    getDataWorkOut();
    changeUI();
    super.onInit();
  }

  Future<void> getDataWorkOut() async {
    listWorkouts = await workoutRepo.getWorkout();
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
