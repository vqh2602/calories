import 'package:calories/modules/workout/play_video_workout/play_video_controller.dart';
import 'package:get/get.dart';

class PlayVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayVideoController>(() => PlayVideoController());
  }
}