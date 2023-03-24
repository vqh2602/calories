import 'package:calories/data/repositories/repo.dart';
import 'package:calories/modules/workout/workout_controller.dart';
import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/image_custom.dart';
import 'package:calories/widgets/loading_custom.dart';
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
        (state) => TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                forYouTab(),
                browseTab(),
              ],
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
                        child: searchBar(width: 0.75),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(LucideIcons.filter),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4 * 4),
              Expanded(
                child: ListView.builder(
                  itemCount: workoutController.listWorkouts.length,
                  itemBuilder: (context, index) => browseItem(
                    image: '$baserUrlMedia${workoutController.listWorkouts[index]?.image ?? ''}',
                    title:workoutController.listWorkouts[index]?.title ?? '',
                    des:workoutController.listWorkouts[index]?.description ?? '',
                  ),
                ),
              )
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            forYou(),
            const SizedBox(height: 4 * 4),
            topPickForYou(),
            const SizedBox(height: 4 * 4),
            topPickForYou(),
            const SizedBox(height: 4 * 4),
          ],
        ),
      ),
    );
  }

//dành cho bạn
  Widget forYou() {
    return Column(
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
            itemCount: 5,
            pageSnapping: true,
            controller: PageController(
              initialPage: 0,
              viewportFraction: 0.9,
            ),
            itemBuilder: (context, index) {
              return forYouItem(
                image: '$baserUrlMedia${workoutController.listWorkouts[index]?.image ?? ''}',
                name: workoutController.listWorkouts[index]?.title ?? '',
                level: workoutController.listWorkouts[index]?.level.toString() ?? '',
                time: workoutController.listWorkouts[index]?.time.toString() ?? '',
                des: workoutController.listWorkouts[index]?.description ?? '',
                pagePosition: index,
              );
            },
          ),
        ),
      ],
    );
  }
}
