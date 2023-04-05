import 'dart:convert';

import 'package:calories/data/models/tag.dart';
import 'package:calories/data/models/training_plan.dart';
import 'package:calories/data/models/workouts.dart';
import 'package:calories/data/repositories/tag_repo.dart';
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
  TagRepo tagRepo = TagRepo();
  TextEditingController searchTE = TextEditingController();

  List<Workout?> listWorkouts = [];
  List<Workout?> listWorkoutsResult = [];
  List<Workout?> listWorkoutsForYou = [];
  List<Workout?> listWorkoutsHome = [];
  List<Workout?> listWorkoutsRandom = [];
  List<Tag?> listTagsWorkouts = [];
  List<Tag?> listTagsWorkoutsChoices = [];

  List<TrainingPlan?> listTrainingPlan = [];
  List<TrainingPlan?> listTrainingPlanResult = [];
  late num planTag = 0;

  @override
  Future<void> onInit() async {
    loadingUI();
    await initUser();
    await initTag();
    await getDataWorkOut();
    await getTrainingPlan();
    changeUI();
    super.onInit();
  }

  onRefresh() async {
    initUser();
    getDataWorkOut();
    getTrainingPlan();
    searchTE.clear();
    changeUI();
  }

  initUser() async {
    user = User.fromJson(jsonDecode(await box.read(Storages.dataUser)));
  }

  initTag() async {
    listTagsWorkouts.clear();
    listTagsWorkoutsChoices.clear();
    List<Tag?> lst = await tagRepo.getTags(isCached: true);
    listTagsWorkouts = lst
        .where((element) =>
            element?.type == 3 &&
            element?.id != 20 &&
            element?.id != 21 &&
            element?.id != 22 &&
            element?.id != 23)
        .toList();
  }

  Future<void> getTrainingPlan({num? tag}) async {
    listTrainingPlanResult.clear();
    listTrainingPlan.clear();
    // planTag = 0;

    var tagId = await box.read(Storages.dataTrainingTagPlan);

    planTag = (tag != null) ? tag : tagId ?? 0;

    user = User.fromJson(jsonDecode(await box.read(Storages.dataUser)));
    listTrainingPlan = await workoutRepo.getTrainingPlan(
      userId: user.id.toString(),
      tag: planTag,
    );

    if (tag != null && listTrainingPlan.isNotEmpty) {
      await box.write(Storages.dataTrainingTagPlan, tag);
    }

    listTrainingPlanResult.addAll(listTrainingPlan.length >= 4
        ? listTrainingPlan.sublist(0, 3)
        : listTrainingPlan);

    updateUI();
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

  void searchListWorkoutsInTag() {
    listWorkoutsResult.clear();

    if (listTagsWorkoutsChoices.isEmpty) {
      listWorkoutsResult.addAll(listWorkouts);
      return;
    }

    for (var item1 in listWorkouts) {
      for (var item2 in item1?.tags ?? []) {
        for (var item3 in listTagsWorkoutsChoices) {
          if (item2?.id == item3?.id &&
              item2?.id != null &&
              item3?.id != null) {
            listWorkoutsResult.add(item1);
          }
        }
      }
    }

    listWorkoutsResult = listWorkoutsResult.toSet().toList();
    changeUI();
    updateUI();
  }

  void clearData() {
    listWorkouts.clear();
    listWorkoutsResult.clear();
    listWorkoutsHome.clear();
    listWorkoutsRandom.clear();
    listWorkoutsResult.clear();
    listTagsWorkoutsChoices.clear();
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
