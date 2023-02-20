import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/image_custom.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:calories/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const String routeName = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
                    bottom: BorderSide(width: 1, color: Colors.grey.shade400))),
            child: Container(
                padding: alignment_20_8(),
                child: textTitleLarge(text: 'TRANG CHỦ')),
          ),
        ));
  }

  Widget _buildBody() {
    return SafeArea(
        child: Container(
      margin: alignment_20_0(),
      child: Container(
        padding: EdgeInsets.zero,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 4 * 3,
              ),
              textHeadlineSmall(text: 'Thống kê'),
              const SizedBox(
                height: 4 * 6,
              ),
              blockStatisticalToday(),
              const SizedBox(
                height: 4 * 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  textHeadlineSmall(text: 'Blog tập luyện'),
                  textBodySmall(
                    text: 'xem thêm',
                    decoration: TextDecoration.underline,
                  ),
                ],
              ),
              const SizedBox(
                height: 4 * 6,
              ),
              GFCarousel(
                  hasPagination: true,
                  autoPlay: true,
                  activeIndicator: Colors.white,
                  autoPlayInterval: const Duration(seconds: 1),
                  viewportFraction: 1.0,
                  items: imageList.map((url) {
                    return SizedBox(
                      // margin: EdgeInsets.all(8.0),
                      width: Get.width,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        child: Image.network(url,
                            fit: BoxFit.cover, width: 1000.0),
                      ),
                    );
                  }).toList()),
              Container(
                height: 400,
                color: Colors.red,
                child: Stack(
                  children: [
                    imageNetwork(
                        url:
                            'https://i0.wp.com/post.healthline.com/wp-content/uploads/2021/04/barbell-lift-squat-1296x728-header.jpg?w=1155&h=1528',
                        fit: BoxFit.cover,
                        height: double.infinity)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

final List<String> imageList = [
  "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
];
