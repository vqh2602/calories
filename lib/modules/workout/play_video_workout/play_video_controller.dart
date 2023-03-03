import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PlayVideoController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  VideoPlayerController? videoPlayerController;
  ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
  @override
  void onInit() {
    super.onInit();
    changeUI();
  }

  Future<void> initLoadVideo({String? url}) async {
    videoPlayerController = VideoPlayerController.network(url!,
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true,mixWithOthers: true));
    await videoPlayerController?.initialize();
    videoPlayerController!.addListener(() {
      if (videoPlayerController!.value.isInitialized) {
        currentPosition.value = videoPlayerController!.value;
      }
    });

    videoPlayerController?.play();
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
