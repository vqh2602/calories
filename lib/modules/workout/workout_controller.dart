import 'dart:convert';

import 'package:calories/data/models/workouts.dart';
import 'package:calories/data/repositories/workout_repo.dart';
import 'package:calories/data/storage.dart';
import 'package:calories/widgets/share_function/share_funciton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/models/user.dart';

class WorkoutController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  WorkoutRepo workoutRepo = WorkoutRepo();
  GetStorage box = GetStorage();
  User user = User();
  TextEditingController searchTE = TextEditingController();

  List<Workout?> listWorkouts = [];
  List<Workout?> listWorkoutsResult = [];
  List<Workout?> listWorkoutsForYou = [];
  List<Workout?> listWorkoutsHome = [];
  List<Workout?> listWorkoutsRandom = [];

  @override
  Future<void> onInit() async {
    loadingUI();
    initUser();
    getDataWorkOut();
    changeUI();
    super.onInit();
  }

  initUser() async {
    user = User.fromJson(jsonDecode(await box.read(Storages.dataUser)));
  }

  Future<void> getDataWorkOut() async {
    clearData();
    listWorkouts = await workoutRepo.getWorkout();
    // dành cho bạn
    for (var item in listWorkouts) {
      for (var itemTag in item?.tags ?? []) {
        //print('lọc: ${itemTag.id}');
        if (itemTag.id ==
            getBMI(
                bmi: calculateBMI(
                    h: double.parse(user.height.toString()),
                    w: double.parse(user.weight.toString())))) {
          listWorkoutsForYou.add(item);
        }
      }
    }
    // ở nhà
    for (var item in listWorkouts) {
      for (var itemTag in item?.tags ?? []) {
        //print('lọc: ${itemTag.id}');
        if (itemTag.id == 16 || itemTag.id == 18) {
          listWorkoutsHome.add(item);
        }
      }
    }

    // ngẫu nhiên
    listWorkoutsRandom.addAll(listWorkouts);
    listWorkoutsRandom.shuffle();

    listWorkoutsResult.addAll(listWorkouts);

    updateUI();
  }

  void searchListWorkouts({required String search}) {
    listWorkoutsResult = listWorkouts
        .where((element) =>
            element?.title?.toLowerCase().contains(search.toLowerCase()) ??
            false)
        .toList();
    updateUI();
  }

  void clearData() {
    listWorkouts.clear();
    listWorkoutsResult.clear();
    listWorkoutsHome.clear();
    listWorkoutsRandom.clear();
    listWorkoutsResult.clear();
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
