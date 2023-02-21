import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/image_custom.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:calories/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lucide_icons/lucide_icons.dart';

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
          padding: EdgeInsets.zero,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: alignment_20_0(),
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4 * 6,
                ),
                GFCarousel(
                    hasPagination: true,
                    autoPlay: true,
                    height: 450,
                    activeIndicator: Colors.white,
                    autoPlayInterval: const Duration(seconds: 4),
                    viewportFraction: 1.0,
                    items: imageList.map((url) {
                      return SizedBox(
                        // color: Colors.red,
                        height: 450,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              child: imageNetwork(
                                  url: url,
                                  fit: BoxFit.cover,
                                  height: double.infinity),
                            ),
                            Container(
                              color: Colors.black.withOpacity(0.4),
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.transparent),
                                  margin: alignment_20_0(),
                                  padding: const EdgeInsets.only(bottom: 4*7),
                                  child: Wrap(
                                    runSpacing: 12,
                                    children: [
                                      textHeadlineMedium(
                                          text: 'Làm sao để tập vùng mông hiệu quả'
                                              .toUpperCase(),
                                          fontWeight: FontWeight.w700,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.white),
                                      ElevatedButton(
                                          //icon: Icon(Icons.edit, size: 32),
                                          onPressed: () {},
                                          style:  ElevatedButton.styleFrom(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero, // <-- Radius
                                            ),
                                            backgroundColor: Colors.white,
                                            padding: const EdgeInsets.all(4*3)
                                          ),
                                          child: Wrap(
                                            crossAxisAlignment: WrapCrossAlignment.center,
                                            children: [
                                              textTitleLarge(
                                                  text: 'Đọc chi tiết',
                                                  textAlign: TextAlign.center,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                              const SizedBox(width: 8,),
                                              const Icon(LucideIcons.arrowRight,color: Colors.black,)
                                            ],
                                          ),),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      );
                    }).toList()),
              ],
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
