import 'dart:convert';
import 'package:calories/data/models/training_plan.dart';
import 'package:calories/data/models/workouts.dart';
import 'package:calories/data/repositories/repo.dart';
import 'package:calories/data/storage.dart';
import 'package:calories/widgets/share_function/share_funciton.dart';
import 'package:get_storage/get_storage.dart';

class WorkoutRepo extends Repo {
  GetStorage box = GetStorage();
  // lấy thông tin danh sách bài tập
  Future<List<Workout?>> getWorkout({bool isCached = false}) async {
    List<Workout?> lstWorkout = [];
    if (isCached) {
      jsonDecode(box.read(Storages.dataWorkout)).forEach((element) {
        lstWorkout.add(Workout.fromJson(element));
      });
    } else {
      var res = await dioRepo.get('/api/v1/workouts');
      var result = jsonDecode(res.toString());
      if (result["success"]) {
        result['data'].forEach((element) {
          lstWorkout.add(Workout.fromJson(element));
        });
        await box.write(Storages.dataWorkout, jsonEncode(result['data']));
      } else {
        buildToast(type: TypeToast.failure, title: result["message"]);
      }
    }
    return lstWorkout;
  }

  // lấy kế hoạch tập luyện
  Future<List<TrainingPlan?>> getTrainingPlan({
    bool isCached = false,
    required String userId,
    required num tag,
  }) async {
    List<TrainingPlan?> lstTrainingPlan = [];
    if (isCached) {
      jsonDecode(box.read(Storages.dataWorkout)).forEach((element) {
        lstTrainingPlan.add(TrainingPlan.fromJson(element));
      });
    } else {
      var res = await dioRepo.post('/api/v1/trainings/user/$userId/tag/$tag');
      var result = jsonDecode(res.toString());
      if (result["success"]) {
        result['data'].forEach((element) {
          lstTrainingPlan.add(TrainingPlan.fromJson(element));
        });
        await box.write(Storages.dataTrainingPlan, jsonEncode(result['data']));
      } else {
        buildToast(type: TypeToast.failure, title: result["message"]);
      }
    }
    return lstTrainingPlan;
  }
}
