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
                  textAlign: textAlign,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black),
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
                      backgroundColor: Colors.black,
                      padding: paddingButton ?? const EdgeInsets.all(4 * 2)),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      textTitleMedium(
                          text: titleButton ?? 'Truy cập',
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                          fontSize: fontSize ?? 18.5,
                          color: Colors.white),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        LucideIcons.arrowRight,
                        color: Colors.white,
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

// app bar custom
AppBar appBarCustom({
  required String title,
}) {
  return AppBar(
    titleSpacing: 0,
    backgroundColor: Get.theme.colorScheme.background,
    surfaceTintColor: Get.theme.colorScheme.background,
    title: Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: Colors.grey.shade400))),
      child: Container(
          margin: const EdgeInsets.only(top: 3),
          padding: alignment_20_8(),
          child: textTitleLarge(text: title)),
    ),
  );
}

//avater tròn
Widget avatarImage({required String url, double? radius}) {
  bool loadImageError = false;
  return StatefulBuilder(builder: (context, setState) {
    return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(url),
        onBackgroundImageError: (dynamic exception, StackTrace? stackTrace) {
          setState(() {
            loadImageError = true;
          });
        },
        child: loadImageError
            ? ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset('assets/images/image_notfound.jpg'))
            : null);
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
        color: Colors.white,
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

Widget chartCustom({dynamic series, double height = 450}) {
  return Container(
    width: Get.width,
    margin: const EdgeInsets.only(top: 4 * 5, bottom: 4 * 2),
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
