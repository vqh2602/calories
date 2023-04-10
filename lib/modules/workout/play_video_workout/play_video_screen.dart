import 'dart:async';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:calories/data/models/workouts.dart';
import 'package:calories/data/repositories/repo.dart';
import 'package:calories/modules/workout/play_video_workout/play_video_controller.dart';
import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/loading_custom.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class PlayVideoScreen extends StatefulWidget {
  const PlayVideoScreen({Key? key}) : super(key: key);
  static const String routeName = '/play_video';
  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  PlayVideoController playVideoController = Get.put(PlayVideoController());
  final isPortrait = false;
  bool showOpacity = false;
  bool isVolume = true;

  Workout workout = Get.arguments['workout'];
  var trainingId = Get.arguments['trainingId'];
  var trainingType = Get.arguments['type'];

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      playVideoController.initLoadVideo(url: '$baserUrlMedia${workout.video}');
      //Get.offAndToNamed(SignupScreen.routeName);
    });
    super.initState();
  }

  @override
  void dispose() {
    playVideoController.videoPlayerController?.dispose();
    super.dispose();
  }

  void setOrientation(bool isPortrait) {
    if (isPortrait) {
      Wakelock.disable();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    } else {
      Wakelock.enable();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
      appBar: null,
    );
  }

  Widget _buildBody() {
    return playVideoController.obx(
        (state) => Container(
            color: Colors.black,
            child: playVideoController.videoPlayerController != null &&
                    playVideoController.currentPosition.value != null
                ? SafeArea(child: buildVideo())
                : const LoadingCustom()),
        onLoading: const LoadingCustom());
  }

  Widget buildVideo() => OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;
          setOrientation(isPortrait);
          return InkWell(
            onTap: () {
              setState(() {
                showOpacity = !showOpacity;
              });
            },
            child: Stack(
              fit: isPortrait ? StackFit.loose : StackFit.expand,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: buildVideoPlayer(),
                ),
                if (showOpacity)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    width: Get.width,
                    height: Get.height,
                  ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            playVideoController.onClose();
                            Wakelock.disable();
                            SystemChrome.setEnabledSystemUIMode(
                                SystemUiMode.manual,
                                overlays: SystemUiOverlay.values);
                            AutoOrientation.portraitUpMode();
                            Orientation.portrait;

                            playVideoController.setDataUserWorkout();

                            playVideoController.updateUserTraining(
                              trainingId: trainingId.toString(),
                              type: trainingType,
                            );

                            Get.back();
                          },
                          icon: const Icon(
                            LucideIcons.x,
                            color: Colors.white,
                          )),
                      Wrap(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isVolume
                                      ? playVideoController
                                          .videoPlayerController
                                          ?.setVolume(0)
                                      : playVideoController
                                          .videoPlayerController
                                          ?.setVolume(0.5);
                                  isVolume = !isVolume;
                                });
                              },
                              icon: Icon(
                                isVolume
                                    ? LucideIcons.volume2
                                    : LucideIcons.volumeX,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {
                                isPortrait
                                    ? Orientation.landscape
                                    : Orientation.portrait;

                                if (isPortrait) {
                                  AutoOrientation.landscapeRightMode();
                                } else {
                                  AutoOrientation.portraitUpMode();
                                }
                              },
                              icon: Icon(
                                isPortrait
                                    ? LucideIcons.maximize
                                    : LucideIcons.minimize,
                                color: Colors.white,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                AnimatedOpacity(
                  opacity: showOpacity ? 1 : 0,
                  duration: const Duration(seconds: 1),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: IconButton(
                            onPressed: () async {
                              if (showOpacity) {
                                Duration? position = await playVideoController
                                    .videoPlayerController!.position;
                                setState(() {
                                  playVideoController.videoPlayerController!
                                      .seekTo(Duration(
                                          seconds: position!.inSeconds - 10));
                                });
                              } else {
                                setState(() {
                                  showOpacity = !showOpacity;
                                });
                              }
                            },
                            icon: const Icon(
                              LucideIcons.rewind,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: IconButton(
                              icon: Icon(
                                playVideoController
                                        .videoPlayerController!.value.isPlaying
                                    ? LucideIcons.pause
                                    : LucideIcons.play,
                                color: Colors.white,
                                size: 40,
                              ),
                              onPressed: () {
                                if (showOpacity) {
                                  setState(() {
                                    if (playVideoController
                                        .videoPlayerController!
                                        .value
                                        .isPlaying) {
                                      playVideoController.videoPlayerController!
                                          .pause();
                                    } else {
                                      playVideoController.videoPlayerController!
                                          .play();
                                    }
                                  });
                                } else {
                                  setState(() {
                                    showOpacity = !showOpacity;
                                  });
                                }
                              },
                            )),
                        Expanded(
                          flex: 3,
                          child: IconButton(
                            onPressed: () async {
                              if (showOpacity) {
                                Duration? position = await playVideoController
                                    .videoPlayerController!.position;
                                setState(() {
                                  playVideoController.videoPlayerController!
                                      .seekTo(Duration(
                                          seconds: position!.inSeconds + 10));
                                });
                              } else {
                                setState(() {
                                  showOpacity = !showOpacity;
                                });
                              }
                            },
                            icon: const Icon(
                              LucideIcons.fastForward,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ValueListenableBuilder(
                      valueListenable: playVideoController.currentPosition,
                      builder:
                          (context, VideoPlayerValue? videoPlayerValue, w) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text(
                              //   videoPlayerValue!.position
                              //       .toString()
                              //       .substring(
                              //       videoPlayerValue.position
                              //           .toString()
                              //           .indexOf(':') +
                              //           1,
                              //       videoPlayerValue.position
                              //           .toString()
                              //           .indexOf('.')),
                              //   style: const TextStyle(
                              //       color: Colors.white, fontSize: 22),
                              // ),
                              // const Spacer(),
                              Container(
                                color: Colors.white,
                                width: 100,
                                padding: const EdgeInsets.all(4 * 2),
                                child: textBodyLarge(
                                    text: (videoPlayerValue!.duration -
                                            videoPlayerValue.position)
                                        .toString()
                                        .substring(
                                          (videoPlayerValue.duration -
                                                      videoPlayerValue.position)
                                                  .toString()
                                                  .indexOf(':') +
                                              1,
                                          (videoPlayerValue.duration -
                                                  videoPlayerValue.position)
                                              .toString()
                                              .indexOf('.'),
                                        ),
                                    color: Colors.black,
                                    textAlign: TextAlign.center),
                              ),
                              // const Spacer(),
                              // Text(
                              //   videoPlayerValue.duration
                              //       .toString()
                              //       .substring(
                              //       videoPlayerValue.duration
                              //           .toString()
                              //           .indexOf(':') +
                              //           1,
                              //       videoPlayerValue.duration
                              //           .toString()
                              //           .indexOf('.')),
                              //   style: const TextStyle(
                              //       color: Colors.white, fontSize: 22),
                              // ),
                            ],
                          ),
                        );
                      }),
                ),
                // AnimatedOpacity(
                //   opacity: showOpacity ? 1 : 0,
                //   duration: const Duration(seconds: 1),
                //   child: Align(
                //     alignment: Alignment.bottomCenter,
                //     child: ValueListenableBuilder(
                //         valueListenable: playVideoController.currentPosition,
                //         builder:
                //             (context, VideoPlayerValue? videoPlayerValue, w) {
                //           return Padding(
                //             padding: const EdgeInsets.symmetric(
                //                 horizontal: 20, vertical: 10),
                //             child: Row(
                //               children: [
                //                 Text(
                //                   videoPlayerValue!.position
                //                       .toString()
                //                       .substring(
                //                           videoPlayerValue.position
                //                                   .toString()
                //                                   .indexOf(':') +
                //                               1,
                //                           videoPlayerValue.position
                //                               .toString()
                //                               .indexOf('.')),
                //                   style: const TextStyle(
                //                       color: Colors.white, fontSize: 22),
                //                 ),
                //                 const Spacer(),
                //                 Container(
                //                   color: Colors.white,
                //                   child: textBodyMedium(
                //                     text: (videoPlayerValue.duration -
                //                             videoPlayerValue.position)
                //                         .toString()
                //                         .substring(
                //                           (videoPlayerValue.duration -
                //                                       videoPlayerValue.position)
                //                                   .toString()
                //                                   .indexOf(':') +
                //                               1,
                //                           (videoPlayerValue.duration -
                //                                   videoPlayerValue.position)
                //                               .toString()
                //                               .indexOf('.'),
                //                         ),
                //                     color: Colors.black
                //                   ),
                //                 ),
                //                 const Spacer(),
                //                 Text(
                //                   videoPlayerValue.duration
                //                       .toString()
                //                       .substring(
                //                           videoPlayerValue.duration
                //                                   .toString()
                //                                   .indexOf(':') +
                //                               1,
                //                           videoPlayerValue.duration
                //                               .toString()
                //                               .indexOf('.')),
                //                   style: const TextStyle(
                //                       color: Colors.white, fontSize: 22),
                //                 ),
                //               ],
                //             ),
                //           );
                //         }),
                //   ),
                // ),
                // Positioned.fill(
                //   child: AdvancedOverlayWidget(
                //     controller: playVideoController.videoPlayerController!,
                //     onClickedFullScreen: () {
                //       isPortrait
                //           ? Orientation.landscape
                //           : Orientation.portrait;
                //
                //       if (isPortrait) {
                //         AutoOrientation.landscapeRightMode();
                //       } else {
                //         AutoOrientation.portraitUpMode();
                //       }
                //     },
                //   ),
                // ),
              ],
            ),
          );
        },
      );

  // play video chế độ bt và full screen
  Widget buildVideoPlayer() {
    final video = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio:
              playVideoController.videoPlayerController!.value.aspectRatio,
          child: VideoPlayer(playVideoController.videoPlayerController!),
        ),
      ],
    );

    return buildFullScreen(child: video);
  }

  Widget buildFullScreen({
    required Widget child,
  }) {
    final size = playVideoController.videoPlayerController?.value.size;
    final width = size?.width ?? 0;
    final height = size?.height ?? 0;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}
