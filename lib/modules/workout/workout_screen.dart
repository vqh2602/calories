import 'package:calories/data/repositories/repo.dart';
import 'package:calories/modules/workout/workout_controller.dart';
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
      length: 2,
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
                              des: workoutController
                                      .listWorkoutsResult[index]?.description ??
                                  '',
                            ),
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

  Widget browseItem(
      {required String image, required String title, required String des}) {
    // print('url: $image | title: $title | des $des ');
    return Container(
      margin: const EdgeInsets.only(bottom: 4 * 4),
      child: InkWell(
        onTap: () {},
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
                    onTap: (e) {}),
                const SizedBox(height: 4 * 4),
                topPickForYou(
                    itemCount: (workoutController.listWorkoutsRandom.length > 5)
                        ? 5
                        : workoutController.listWorkoutsRandom.length,
                    listWorkout: workoutController.listWorkoutsRandom,
                    title: 'Có thể bạn sẽ thích',
                    onTap: (e) {}),
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
                    level: convertLevelToString(int.parse(workoutController
                            .listWorkoutsForYou[index]?.level
                            .toString() ??
                        '1')),
                    time: workoutController.listWorkoutsForYou[index]?.time
                            .toString() ??
                        '',
                    des: workoutController
                            .listWorkoutsForYou[index]?.description ??
                        '',
                    pagePosition: index,
                  );
                },
              ),
            ),
          ],
        ));
  }
}
