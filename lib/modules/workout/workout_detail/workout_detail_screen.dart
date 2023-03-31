import 'package:calories/data/models/workouts.dart';
import 'package:calories/data/repositories/repo.dart';
import 'package:calories/modules/workout/play_video_workout/play_video_screen.dart';
import 'package:calories/modules/workout/workout_detail/workout_detail_controller.dart';
import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/image_custom.dart';
import 'package:calories/widgets/loading_custom.dart';
import 'package:calories/widgets/share_function/share_funciton.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:calories/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lucide_icons/lucide_icons.dart';

class WorkoutDetailScreen extends StatefulWidget {
  const WorkoutDetailScreen({super.key});
  static const String routeName = '/workout_deatail';

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  WorkoutDetailController workoutDetailController =
      Get.put(WorkoutDetailController());
  Workout? workout = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
      // appBar: appBarCustom(
      //   title: workout?.title?.toUpperCase() ?? '',
      //   bigTitle: false,
      //   isPadding: false,
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   marginTop: 0,
      //   leading: IconButton(
      //     onPressed: () {
      //       Get.back();
      //     },
      //     icon: const Icon(LucideIcons.arrowLeft),
      //   ),
      //   actions: [
      //     TextButton(
      //       onPressed: () {},
      //       child: const Icon(
      //         LucideIcons.moreHorizontal,
      //       ),
      //     )
      //   ],
      // ),
    );
  }

  Widget _buildBody() {
    return workoutDetailController.obx(
        (state) => Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 4 * 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        imageNetwork(
                          url: '$baserUrlMedia${workout?.image ?? ''}',
                          height: Get.height * 0.35,
                          width: Get.width,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 4 * 6),
                        Container(
                          margin: alignment_20_0(),
                          child: textHeadlineSmall(
                            text: workout?.title?.toUpperCase() ?? '',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4 * 4),
                        Container(
                          margin: alignment_20_0(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 4 * 4),
                                child: textBodySmall(
                                    text: workout?.description ?? ''),
                              ),
                              const SizedBox(height: 4 * 2),
                            ],
                          ),
                        ),
                        workoutDetailProperties(
                          time: int.parse(workout?.time.toString() ?? '0'),
                          level: convertLevelToString(
                            int.parse(workout?.level.toString() ?? '1'),
                          ),
                          part: getNameTags(
                              listTag: workoutDetailController.listTagsWorkouts,
                              listTagResult: workout?.tags ?? []),
                          location: 'Trong nhà, Ngoài trời',
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: startButton(workout!),
                ),
                SafeArea(
                    child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(LucideIcons.chevronLeft))
                  ],
                ))
              ],
            ),
        onLoading: const LoadingCustom());
  }

  Widget workoutDetailProperties(
      {required int time,
      required String level,
      required String part,
      required String location}) {
    return Column(
      children: [
        workoutDetailItem(
          icon: LucideIcons.timer,
          title: '$time phút',
        ),
        workoutDetailItem(
          icon: LucideIcons.diff,
          title: level,
        ),
        workoutDetailItem(
          icon: LucideIcons.personStanding,
          title: part,
        ),
        workoutDetailItem(
          icon: LucideIcons.sofa,
          title: location,
        ),
        const SizedBox(
          height: 40,
        )
      ],
    );
  }

  Container startButton(Workout workout) {
    return Container(
      padding: const EdgeInsets.all(4 * 6),
      color: Get.theme.colorScheme.background,
      width: Get.width,
      child: GFButton(
        onPressed: () {
          Get.toNamed(PlayVideoScreen.routeName, arguments: workout);
        },
        padding: const EdgeInsets.only(
          left: 4 * 5,
          right: 4 * 5,
        ),
        size: 4 * 13,
        color: Get.theme.colorScheme.onBackground,
        type: GFButtonType.solid,
        fullWidthButton: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textTitleSmall(
              text: 'Bắt đầu'.toUpperCase(),
              color: Get.theme.colorScheme.background,
            ),
            Icon(
              LucideIcons.arrowRight,
              size: 4 * 6,
              color: Get.theme.colorScheme.background,
            )
          ],
        ),
      ),
    );
  }
}
