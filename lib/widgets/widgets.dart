import 'dart:io';

import 'package:calories/modules/workout/workout_detail/workout_detail_screen.dart';
import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/image_custom.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// khối thông tin tập luyện trong ngày
Widget blockStatisticalToday({Function? onTap}) {
  return InkWell(
    onTap: () {
      onTap != null ? onTap() : null;
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            textLableLarge(text: '10'),
            textBodySmall(text: 'BÀI TẬP')
          ],
        ),
        Column(
          children: [textLableLarge(text: '2000'), textBodySmall(text: 'KCAL')],
        ),
        Column(
          children: [
            textLableLarge(text: '200'),
            textBodySmall(text: 'PHÚT TẬP')
          ],
        ),
      ],
    ),
  );
}

// khoois carousel màn trang chủ
Widget buildCarousel({
  required List listData,
  double height = 450,
}) {
  return GFCarousel(
      hasPagination: true,
      autoPlay: true,
      height: height,
      activeIndicator: Colors.white,
      autoPlayInterval: const Duration(seconds: 4),
      viewportFraction: 1.0,
      items: listData.map((url) {
        return SizedBox(
          // color: Colors.red,
          height: 450,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: imageNetwork(
                    url: url, fit: BoxFit.cover, height: double.infinity),
              ),
              Container(
                color: Colors.black.withOpacity(0.4),
                width: double.infinity,
                height: double.infinity,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                    margin: alignment_20_0(),
                    padding: const EdgeInsets.only(bottom: 4 * 7),
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
                          style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero, // <-- Radius
                              ),
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.all(4 * 3)),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              textTitleLarge(
                                  text: 'Đọc chi tiết',
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              const SizedBox(
                                width: 8,
                              ),
                              const Icon(
                                LucideIcons.arrowRight,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        );
      }).toList());
}

//khối chức năng trang chủ
Widget buildTitleImageButton(
    {required String title,
    required String des,
    required String image,
    EdgeInsets margin = EdgeInsets.zero,
    TextAlign textAlign = TextAlign.center,
    double? fontSize,
    Alignment alignmentDes = Alignment.center,
    Alignment alignmentButton = Alignment.bottomLeft,
    String? titleButton,
    double height = 300,
    Color? desColor,
    EdgeInsets? paddingButton,
    required Function onTap}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      textHeadlineSmall(text: title),
      SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          children: [
            SizedBox(
              height: height,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: alignmentDes,
              child: textHeadlineMedium(
                text: des.toUpperCase(),
                fontWeight: FontWeight.w700,
                maxLines: 3,
                color: desColor,
                textAlign: textAlign,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Align(
              alignment: alignmentButton,
              child: Container(
                margin: margin,
                child: ElevatedButton(
                  //icon: Icon(Icons.edit, size: 32),
                  onPressed: () {
                    onTap();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // <-- Radius
                      ),
                      backgroundColor: Get.theme.colorScheme.onBackground,
                      padding: paddingButton ?? const EdgeInsets.all(4 * 2)),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      textTitleMedium(
                          text: titleButton ?? 'Truy cập',
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                          fontSize: fontSize ?? 18.5,
                          color: Get.theme.colorScheme.background),
                      const SizedBox(
                        width: 8,
                      ),
                      Icon(
                        LucideIcons.arrowRight,
                        color: Get.theme.colorScheme.background,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
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
  return InkWell(
    onTap: () {
      Get.toNamed(WorkoutDetailScreen.routeName);
    },
    child: Container(
      margin: const EdgeInsets.only(right: 4),
      child: Stack(
        children: [
          imageNetwork(
            url: image,
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
                  forYouItemTitle(title: name),
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
                          color: Colors.black,
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
                          color: Colors.black,
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
                      color: Colors.black,
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
                    child: const Icon(
                      LucideIcons.arrowRight,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget forYouItemTitle({required title}) {
  return LimitedBox(
    maxWidth: Get.width - 4 * 20,
    child: Container(
      padding: const EdgeInsets.all(4 * 2),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: textTitleLarge(
        text: title.toUpperCase(),
        fontStyle: FontStyle.italic,
        maxLines: 2,
        color: Colors.black,
      ),
    ),
  );
}

// app bar custom
AppBar appBarCustom(
    {required String title,
    bool bigTitle = true,
    bool isBorder = true,
    double marginTop = 3.0,
    Widget? leadingAppBar,
    List<Widget>? actionsAppBar,
    bool isPadding = true,
    MainAxisAlignment? mainAxisAlignment,
    Widget? leading,
    List<Widget>? actions}) {
  return AppBar(
    titleSpacing: 0,
    automaticallyImplyLeading: false,
    backgroundColor: Get.theme.colorScheme.background,
    surfaceTintColor: Get.theme.colorScheme.background,
    leading: leadingAppBar,
    actions: actionsAppBar,
    title: Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 4, bottom: 3),
      decoration: BoxDecoration(
          color: Get.theme.colorScheme.background,
          border: Border(
              bottom: isBorder
                  ? BorderSide(width: 1, color: Colors.grey.shade400)
                  : BorderSide.none)),
      child: Container(
          margin: EdgeInsets.only(top: marginTop),
          padding: isPadding ? alignment_20_8() : EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leading != null) leading,
              bigTitle
                  ? textTitleLarge(text: title)
                  : textTitleMedium(text: title),
              if (actions != null) ...actions
            ],
          )),
    ),
  );
}

Widget workoutDetailItem({
  required IconData icon,
  Function? onTap,
  required String title,
}) {
  return Container(
    decoration: BoxDecoration(
      // color: Colors.white,
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade300, width: 0.5),
      ),
    ),
    padding: const EdgeInsets.only(top: 4 * 5, bottom: 4 * 5),
    child: InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4 * 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: 4 * 5,
            ),
            const SizedBox(width: 4 * 8),
            Expanded(
              child: textTitleSmall(
                text: title,
                fontWeight: FontWeight.w200,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

//avater tròn
Widget avatarImage(
    {required String url,
    double? radius,
    bool isFileImage = false,
    File? imageF}) {
  bool loadImageError = false;
  return StatefulBuilder(builder: (context, setState) {
    return !isFileImage
        ? CircleAvatar(
            radius: radius,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(url),
            onBackgroundImageError:
                (dynamic exception, StackTrace? stackTrace) {
              setState(() {
                loadImageError = true;
              });
            },
            child: loadImageError
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('assets/images/image_notfound.jpg'))
                : null)
        : CircleAvatar(
            radius: radius,
            backgroundColor: Colors.transparent,
            backgroundImage:
                const AssetImage('assets/images/image_notfound.jpg'),
            child: ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(radius ?? 20), // Image radius
                child: (imageF == null)
                    ? Image.asset(
                        'assets/images/image_notfound.jpg',
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        imageF,
                        fit: BoxFit.cover,
                      ),
              ),
            ));
  });
}

Widget buttonSetting({
  required IconData iconStart,
  required IconData iconEnd,
  Function? onTap,
  required String title,
  bool isToggle = false,
  Color? disabledTrackColor,
  Color? enabledTrackColor,
  bool valToggle = false,
  Function(bool?)? onChangeToggle,
}) {
  return Container(
    decoration: BoxDecoration(
        color: Get.theme.colorScheme.background,
        border: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 0.5))),
    padding: const EdgeInsets.only(top: 4 * 5, bottom: 4 * 5),
    child: InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 4 * 5,
            children: [
              Icon(
                iconStart,
                size: 4 * 6,
              ),
              textTitleSmall(text: title),
            ],
          ),
          isToggle
              ? GFToggle(
                  onChanged: onChangeToggle!,
                  value: valToggle,
                  disabledTrackColor:
                      disabledTrackColor ?? Colors.grey.shade300,
                  enabledTrackColor: enabledTrackColor ?? Colors.black,
                  type: GFToggleType.ios,
                )
              : Icon(
                  iconEnd,
                  size: 4 * 5,
                ),
        ],
      ),
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
              return InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.isDarkMode
                          ? Colors.grey.withOpacity(0.2)
                          : Colors.black.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imageNetwork(
                        url:
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
                              color: context.isDarkMode
                                  ? Colors.grey
                                  : Colors.black.withOpacity(0.5),
                              fontSize: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ],
  );
}

Widget chartCustom({dynamic series, double height = 450}) {
  return Container(
    width: Get.width,
    margin: const EdgeInsets.only(top: 4 * 5, bottom: 4),
    height: height,
    child: SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: ''),
      legend: Legend(
          isVisible: !false,
          overflowMode: LegendItemOverflowMode.wrap,
          toggleSeriesVisibility: true,
          position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          labelPlacement: LabelPlacement.onTicks),
      primaryYAxis: NumericAxis(
          // minimum: 0,
          // maximum: 50,
          // visibleMaximum: 1000,
          axisLine: const AxisLine(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.hide,
          labelFormat: '{value}',
          majorTickLines: const MajorTickLines(size: 0)),
      series: series,
      tooltipBehavior: TooltipBehavior(enable: true),
    ),
  );
}
