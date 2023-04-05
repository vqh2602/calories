import 'package:calories/data/repositories/repo.dart';
import 'package:calories/modules/workout/play_video_workout/play_video_screen.dart';
import 'package:calories/modules/workout/workout_controller.dart';
import 'package:calories/modules/workout/workout_detail/workout_detail_screen.dart';
import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/image_custom.dart';
import 'package:calories/widgets/loading_custom.dart';
import 'package:calories/widgets/share_function/share_funciton.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:calories/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);
  static const String routeName = '/workout';
  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  WorkoutController workoutController = Get.put(WorkoutController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: buildBody(
        context: context,
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Get.theme.colorScheme.background,
          surfaceTintColor: Get.theme.colorScheme.background,
          title: Container(
            width: Get.width,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.grey.shade400),
              ),
            ),
            child: Container(
              padding: alignment_20_8(),
              child: textTitleLarge(text: 'BÀI TẬP'),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4 * 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.grey.shade400,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: context.isDarkMode ? Colors.white : Colors.black,
                      width: 2.0,
                    ),
                  ),
                ),
                overlayColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                isScrollable: true,
                tabs: [
                  Container(
                    margin: const EdgeInsets.all(4 * 2),
                    child: textBodySmall(text: 'Dành cho bạn'),
                  ),
                  Container(
                    margin: const EdgeInsets.all(4 * 2),
                    child: textBodySmall(text: 'Danh sách'),
                  ),
                  Container(
                    margin: const EdgeInsets.all(4 * 2),
                    child: textBodySmall(text: 'Kế hoạch tập luyện'),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return workoutController.obx(
        (state) => SafeArea(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  forYouTab(),
                  browseTab(),
                  trainingPlan(),
                ],
              ),
            ),
        onLoading: const LoadingCustom());
  }

//tab browse cho bạn ở màn Workout
  Widget browseTab() {
    return workoutController.obx((state) => SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4 * 4),
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Container(
                  margin: alignment_20_0(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4, bottom: 4),
                        child: searchBar(
                            width: 0.75,
                            controller: workoutController.searchTE,
                            onChange: (value) {
                              workoutController.searchListWorkouts(
                                  search: value);
                            }),
                      ),
                      IconButton(
                        onPressed: () {
                          filterAlertTags(
                              result: workoutController.listTagsWorkouts,
                              choices:
                                  workoutController.listTagsWorkoutsChoices,
                              onChange: (tag) {
                                bool add = true;
                                if (workoutController
                                    .listTagsWorkoutsChoices.isNotEmpty) {
                                  for (var item in workoutController
                                      .listTagsWorkoutsChoices) {
                                    if (item?.id == tag?.id) {
                                      workoutController.listTagsWorkoutsChoices
                                          .remove(item);
                                      add = false;
                                      break;
                                    }
                                  }
                                } else {
                                  // workoutController.listTagsWorkoutsChoices
                                  //     .add(tag);
                                }
                                add
                                    ? workoutController.listTagsWorkoutsChoices
                                        .add(tag)
                                    : null;
                                workoutController.changeUI();
                                workoutController.updateUI();
                              },
                              onSubmit: () {
                                workoutController.searchListWorkoutsInTag();
                              });
                        },
                        icon: const Icon(LucideIcons.filter),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4 * 4),
              Expanded(
                  child: workoutController.listWorkoutsResult.isNotEmpty
                      ? RefreshIndicator(
                          onRefresh: () async {
                            workoutController.loadingUI();
                            await Future.delayed(const Duration(seconds: 2),
                                () => workoutController.onRefresh());
                          },
                          child: ListView.builder(
                            itemCount:
                                workoutController.listWorkoutsResult.length,
                            itemBuilder: (context, index) => browseItem(
                                image:
                                    '$baserUrlMedia${workoutController.listWorkoutsResult[index]?.image ?? ''}',
                                title: workoutController
                                        .listWorkoutsResult[index]?.title ??
                                    '',
                                des: workoutController.listWorkoutsResult[index]
                                        ?.description ??
                                    '',
                                onTap: () {
                                  Get.toNamed(WorkoutDetailScreen.routeName,
                                      arguments: workoutController
                                          .listWorkoutsResult[index]);
                                }),
                          ),
                        )
                      : noData(inReload: () {
                          workoutController.listWorkoutsResult
                              .addAll(workoutController.listWorkouts);
                          workoutController.searchTE.clear();
                          workoutController.updateUI();
                        }))
            ],
          ),
        ));
  }

//tab kế hoạch tập luyện ở màn Workout
  Widget trainingPlan() {
    return workoutController.obx(
      (state) => Container(
        padding: alignment_20_0(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4 * 4),
              ListView.builder(
                physics: const ScrollPhysics(),
                itemCount: workoutController.listTrainingPlan.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => trainingPlanItem(
                  image:
                      '$baserUrlMedia${workoutController.listTrainingPlan[index]?.workout?.image}',
                  title: workoutController
                          .listTrainingPlan[index]?.workout?.title ??
                      '',
                  day: workoutController.listTrainingPlan[index]?.date
                          .toString() ??
                      '',
                  des: workoutController
                          .listTrainingPlan[index]?.workout?.description
                          .toString() ??
                      '',
                  status:
                      workoutController.listTrainingPlan[index]?.status ?? 0,
                  onTap: () {
                    Get.toNamed(
                      PlayVideoScreen.routeName,
                      arguments: {
                        'workout':
                            workoutController.listTrainingPlan[index]?.workout,
                        'trainingId':
                            workoutController.listTrainingPlan[index]?.id,
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 4 * 4),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      workoutController.planTag = 20;
                      workoutController.getTrainingPlan();
                      workoutController.updateUI();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: workoutController.planTag == 20
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                      child: Center(
                        child: textBodyMedium(
                          text: 'bmi thiếu cân',
                          color: workoutController.planTag == 20
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4 * 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      workoutController.planTag = 21;
                      workoutController.getTrainingPlan();
                      workoutController.updateUI();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: workoutController.planTag == 21
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                      child: Center(
                        child: textBodyMedium(
                          text: 'bmi bình thường',
                          color: workoutController.planTag == 21
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget trainingPlanItem({
    required String image,
    required String title,
    required String day,
    required String des,
    required Function? onTap,
    num status = 0,
  }) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 4 * 10),
        height: Get.height * 0.12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: imageNetwork(
                url: image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 4 * 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textLableSmall(text: 'Ngày $day'),
                          const SizedBox(height: 4 * 2),
                          textLableSmall(
                            text: title,
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w100,
                          ),
                        ],
                      ),
                      workoutController.obx(
                        (state) => Icon(
                          LucideIcons.checkCircle2,
                          color:
                              status == 1 ? Colors.black : Colors.grey.shade200,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4 * 2),
                  Expanded(
                    child: textBodySmall(
                      text: des,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget browseItem(
      {required String image,
      required String title,
      required String des,
      required Function onTap}) {
    // print('url: $image | title: $title | des $des ');
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 4 * 4),
        child: InkWell(
          onTap: () {
            onTap();
          },
          child: Stack(
            children: [
              imageNetwork(
                  url: image, width: Get.width, height: 250, fit: BoxFit.cover),
              Positioned(
                bottom: 0,
                child: Container(
                  margin: const EdgeInsets.all(4 * 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      forYouItemTitle(title: title),
                      const SizedBox(
                        height: 4,
                      ),
                      LimitedBox(
                        maxWidth: Get.width - 4 * 20,
                        child: Container(
                          padding: const EdgeInsets.all(4 * 2),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: textBodySmall(
                            text: des,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//tab dành cho bạn ở màn Workout
  Widget forYouTab() {
    return workoutController.obx((state) => RefreshIndicator(
          onRefresh: () async {
            workoutController.loadingUI();
            await Future.delayed(const Duration(seconds: 2),
                () => workoutController.onRefresh());
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                forYou(),
                const SizedBox(height: 4 * 4),
                topPickForYou(
                    itemCount: (workoutController.listWorkoutsHome.length > 5)
                        ? 5
                        : workoutController.listWorkoutsHome.length,
                    listWorkout: workoutController.listWorkoutsHome,
                    title: 'Bài tập ở nhà',
                    onTap: (e) {
                      Get.toNamed(WorkoutDetailScreen.routeName, arguments: e);
                    }),
                const SizedBox(height: 4 * 4),
                topPickForYou(
                    itemCount: (workoutController.listWorkoutsRandom.length > 5)
                        ? 5
                        : workoutController.listWorkoutsRandom.length,
                    listWorkout: workoutController.listWorkoutsRandom,
                    title: 'Có thể bạn sẽ thích',
                    onTap: (e) {
                      Get.toNamed(WorkoutDetailScreen.routeName, arguments: e);
                    }),
                const SizedBox(height: 4 * 4),
              ],
            ),
          ),
        ));
  }

//dành cho bạn
  Widget forYou() {
    return workoutController.obx((state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4 * 4),
            Container(
              margin: alignment_20_0(),
              child: textHeadlineSmall(text: 'Dành cho bạn'),
            ),
            const SizedBox(height: 4 * 4),
            SizedBox(
              height: 440,
              child: PageView.builder(
                itemCount: (workoutController.listWorkoutsForYou.length > 5)
                    ? 5
                    : workoutController.listWorkoutsForYou.length,
                pageSnapping: true,
                controller: PageController(
                  initialPage: 0,
                  viewportFraction: 0.9,
                ),
                itemBuilder: (context, index) {
                  return forYouItem(
                    image:
                        '$baserUrlMedia${workoutController.listWorkoutsForYou[index]?.image ?? ''}',
                    name: workoutController.listWorkoutsForYou[index]?.title ??
                        '',
                    level: convertLevelToString(
                      int.parse(workoutController
                              .listWorkoutsForYou[index]?.level
                              .toString() ??
                          '1'),
                    ),
                    time: workoutController.listWorkoutsForYou[index]?.time
                            .toString() ??
                        '',
                    des: workoutController
                            .listWorkoutsForYou[index]?.description ??
                        '',
                    pagePosition: index,
                    onTap: () {
                      Get.toNamed(WorkoutDetailScreen.routeName,
                          arguments:
                              workoutController.listWorkoutsForYou[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}
