import 'dart:async';
import 'dart:convert';
import 'package:calories/data/models/user.dart';
import 'package:calories/data/models/workouts.dart';
import 'package:calories/data/repositories/user_repo.dart';
import 'package:calories/data/storage.dart';
import 'package:calories/modules/workout/workout_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';

class PlayVideoController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  WorkoutController workoutController = Get.find();
  VideoPlayerController? videoPlayerController;
  ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
  UserRepo userRepo = UserRepo();
  User user = User();
  GetStorage box = GetStorage();
  Workout workout = Get.arguments['workout'];

  @override
  Future<void> onInit() async {
    super.onInit();
    await initUser();
    changeUI();
  }

  Future<void> initLoadVideo({String? url}) async {
    videoPlayerController = VideoPlayerController.network(url!,
        videoPlayerOptions: VideoPlayerOptions(
            allowBackgroundPlayback: true, mixWithOthers: true));
    await videoPlayerController?.initialize();
    videoPlayerController!.addListener(() {
      if (videoPlayerController!.value.isInitialized) {
        currentPosition.value = videoPlayerController!.value;
        // print('v1: ${currentPosition.value?.duration}');
        // print('v2: ${currentPosition.value?.position.inMinutes}');
        // print('v3: ${currentPosition.value!.duration - currentPosition.value!.position}');
      }
    });

    videoPlayerController?.play();
    changeUI();
  }

  initUser() async {
    user = User.fromJson(jsonDecode(await box.read(Storages.dataUser)));
  }

  Future<void> setDataUserWorkout() async {
    if (currentPosition.value?.position.inMinutes != null &&
        currentPosition.value!.position.inMinutes >= 1) {
      await userRepo.addUserWorkOut(
          userId: user.id.toString(),
          workoutId: workout.id.toString(),
          min: currentPosition.value!.position.inMinutes,
          calo: ((workout.calo!.toInt() / workout.time!.toInt()) *
                  currentPosition.value!.position.inMinutes)
              .toInt());
    }
  }

  Future<void> updateUserTraining({
    required String trainingId,
  }) async {
    if (currentPosition.value?.position.inMinutes != null &&
        currentPosition.value!.position.inMinutes >= 1) {
      await userRepo.updateStatusTraining(
        trainingId: trainingId,
        status: 1,
      );
      workoutController.getTrainingPlan();
      workoutController.updateUI();
    }
    changeUI();
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
