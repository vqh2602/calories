import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/bottom_nav_bar.dart';
import 'package:calories/widgets/image_custom.dart';
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
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
      appBar: appBarCustom(
        title: 'Bài tập mông'.toUpperCase(),
        bigTitle: false,
        isPadding: false,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        marginTop: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(LucideIcons.arrowLeft),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Icon(
              LucideIcons.moreHorizontal,
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildBody() {
  return SafeArea(
    child: Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 4 * 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageNetwork(
                  url:
                      'https://images.unsplash.com/photo-1562771379-eafdca7a02f8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                  height: Get.height * 0.28,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 4 * 6),
                Container(
                  margin: alignment_20_0(),
                  child: textHeadlineSmall(
                    text: 'Bài tập mông'.toUpperCase(),
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
                            fontSize: 13,
                            text:
                                'Các bài tập mông cho nữ dưới đây có thể dễ dàng thực hiện tại nhà, cơ quan hay phòng tập. '),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 4 * 4),
                        child: textBodySmall(
                            fontSize: 13,
                            text:
                                'Các bài tập mông cho nữ dưới đây có thể dễ dàng thực hiện tại nhà, cơ quan hay phòng tập. '),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 4 * 4),
                        child: textBodySmall(
                            fontSize: 13,
                            text:
                                'Các bài tập mông cho nữ dưới đây có thể dễ dàng thực hiện tại nhà, cơ quan hay phòng tập. '),
                      ),
                      const SizedBox(height: 4 * 4),
                    ],
                  ),
                ),
                workoutDetailProperties(
                  time: 15,
                  level: 'Khó',
                  part: 'Mông, Đùi',
                  location: 'Trong nhà, Ngoài trời',
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: startButton(),
        ),
      ],
    ),
  );
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
    ],
  );
}

Container startButton() {
  return Container(
    padding: const EdgeInsets.all(4 * 6),
    color: Colors.white,
    width: Get.width,
    child: GFButton(
      onPressed: () {},
      padding: const EdgeInsets.only(
        left: 4 * 5,
        right: 4 * 5,
      ),
      size: 4 * 13,
      color: Colors.black,
      type: GFButtonType.solid,
      fullWidthButton: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textTitleSmall(text: 'Bắt đầu'.toUpperCase(), color: Colors.white),
          const Icon(
            LucideIcons.arrowRight,
            size: 4 * 6,
            color: Colors.white,
          )
        ],
      ),
    ),
  );
}
