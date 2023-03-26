import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/image_custom.dart';
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
}

Widget _buildBody() {
  return TabBarView(
    physics: const NeverScrollableScrollPhysics(),
    children: [
      _forYouTab(),
      _browseTab(),
    ],
  );
}

//tab browse cho bạn ở màn Workout
Widget _browseTab() {
  return SafeArea(
    child: SingleChildScrollView(
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
          Column(
            children: List.generate(
              browseList.length,
              (index) => _browseItem(
                image: browseList[index]["image"],
                title: browseList[index]["title"],
                des: browseList[index]["des"],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget _browseItem(
    {required String image, required String title, required String des}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 4 * 4),
    child: InkWell(
      onTap: () {},
      child: Stack(
        children: [
          imageNetwork(url: image, width: Get.width),
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
Widget _forYouTab() {
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

List browseList = [
  {
    "image":
        "https://phantom-marca.unidadeditorial.es/efa9740df47cff7f9466ea78fd720074/crop/0x93/899x599/resize/1320/f/jpg/assets/multimedia/imagenes/2022/01/19/16426036798831.jpg",
    "title": "Chống đẩy",
    "des": "Chống đẩy một tay có tư thế bắt đầu tương tự plank",
  },
  {
    "image":
        "https://plus.unsplash.com/premium_photo-1668613403427-7455f029f2be?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    "title": "Nhảy dây",
    "des": "Chống đẩy một tay có tư thế bắt đầu tương tự plank",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1536922246289-88c42f957773?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=904&q=80",
    "title": "Squats",
    "des": "Chống đẩy một tay có tư thế bắt đầu tương tự plank",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1607962776853-346ec26811db?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80",
    "title": "Gập bụng",
    "des": "Chống đẩy một tay có tư thế bắt đầu tương tự plank",
  },
];
