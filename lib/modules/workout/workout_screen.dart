import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/text_custom.dart';
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
  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
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
      ),
    );
  }
}

Widget _buildBody() {
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
          itemCount: forYouList.length,
          pageSnapping: true,
          controller: PageController(
            initialPage: 0,
            viewportFraction: 0.9,
          ),
          itemBuilder: (context, pagePosition) {
            return forYouItem(
              image: forYouList[pagePosition]["image"],
              name: forYouList[pagePosition]["name"],
              level: forYouList[pagePosition]["level"],
              time: forYouList[pagePosition]["time"],
              des: forYouList[pagePosition]["des"],
              pagePosition: pagePosition,
            );
          },
        ),
      ),
    ],
  );
}

Widget forYouItem({
  required image,
  required String name,
  required String level,
  required String time,
  required String des,
  required int pagePosition,
}) {
  return Container(
    margin: const EdgeInsets.only(right: 4),
    child: Stack(
      children: [
        Image.network(
          image,
          fit: BoxFit.cover,
          height: 440,
          width: double.infinity,
        ),
        Positioned(
          bottom: 0,
          child: Container(
            margin: const EdgeInsets.all(4 * 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LimitedBox(
                  maxWidth: Get.width - 4 * 20,
                  child: Container(
                    padding: const EdgeInsets.all(4 * 2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: textTitleLarge(
                      text: name.toUpperCase(),
                      fontStyle: FontStyle.italic,
                      maxLines: 2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4 * 2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: textTitleSmall(
                        text: level.toUpperCase(),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Container(
                      padding: const EdgeInsets.all(4 * 2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: textTitleSmall(
                        text: '$time Phút'.toUpperCase(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  padding: const EdgeInsets.all(4 * 2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  width: 240,
                  child: textBodySmall(
                    text: des,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  padding: const EdgeInsets.all(4 * 2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Icon(LucideIcons.arrowRight),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget topPickForYou() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 4 * 4),
      Container(
        margin: alignment_20_0(),
        child: textHeadlineSmall(text: 'Top pick for you'),
      ),
      const SizedBox(height: 4 * 4),
      Container(
        //item
        margin: const EdgeInsets.only(right: 4),
        child: SizedBox(
          height: 200,
          child: PageView.builder(
            itemCount: 3,
            pageSnapping: true,
            controller: PageController(
              initialPage: 0,
              viewportFraction: 0.9,
            ),
            itemBuilder: (context, pagePosition) {
              return Container(
                margin: const EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      "https://images.unsplash.com/photo-1599058917212-d750089bc07e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80",
                      fit: BoxFit.cover,
                      height: 140,
                      width: double.infinity,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4 * 3,
                        vertical: 4 * 2,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textTitleSmall(
                            text: 'Plank'.toUpperCase(),
                            fontSize: 12,
                          ),
                          textBodySmall(
                            text:
                                'Xây dựng sự ổn định cốt lõi cho chuyển động hàng ngày',
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ],
  );
}

List forYouList = [
  {
    "image":
        "https://images.unsplash.com/photo-1562771379-eafdca7a02f8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    "name": "Bài tập gập chân và tay và chân",
    "level": 'Trung bình',
    "time": "62",
    "des": "Tập bụng một cách hiệu quả giúp cơ bụng săn chắc",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1575052814086-f385e2e2ad1b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    "name": "Bài tập gập mông",
    "level": 'Khó',
    "time": "55",
    "des": "Tập bụng một cách hiệu quả giúp cơ bụng săn chắc",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=920&q=80",
    "name": "Bài tập gập đầu",
    "level": 'Dễ',
    "time": "45",
    "des": "Tập bụng một cách hiệu quả giúp cơ bụng săn chắc",
  },
];
