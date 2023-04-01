import 'dart:typed_data';

import 'package:calories/data/models/tag.dart';
import 'package:calories/data/models/workouts.dart';
import 'package:calories/data/repositories/repo.dart';
import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/image_custom.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// khối thông tin tập luyện trong ngày
Widget blockStatisticalToday(
    {Function? onTap, String? workout, String? time, String? kcal}) {
  return InkWell(
    onTap: () {
      onTap != null ? onTap() : null;
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            textLableLarge(text: workout ?? '0'),
            textBodySmall(text: 'BÀI TẬP')
          ],
        ),
        Column(
          children: [
            textLableLarge(text: kcal ?? '0'),
            textBodySmall(text: 'KCAL')
          ],
        ),
        Column(
          children: [
            textLableLarge(text: time ?? '0'),
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
  required Function onTap,
}) {
  return InkWell(
    onTap: () {
      onTap();
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
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget searchBar(
    {double width = 1,
    Function(String)? onChange,
    required TextEditingController controller}) {
  return Container(
    // margin: const EdgeInsets.symmetric(horizontal: 4 * 5),
    width: Get.width * width,
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.05),
      borderRadius: BorderRadius.circular(30),
    ),
    child: TextField(
      onChanged: onChange,
      controller: controller,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(4 * 3),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: "Tìm kiếm",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
        prefixIcon: Icon(
          LucideIcons.search,
          size: 12,
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
    Uint8List? imageF}) {
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
                    : Image.memory(
                        imageF,
                        errorBuilder: (buildContext, object, stackTrace) =>
                            Image.asset(
                          'assets/images/image_notfound.jpg',
                          fit: BoxFit.cover,
                        ),
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

Widget topPickForYou(
    {required int itemCount,
    required List<Workout?> listWorkout,
    required Function(Workout) onTap,
    required String title}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 4 * 4),
      Container(
        margin: alignment_20_0(),
        child: textHeadlineSmall(text: title),
      ),
      const SizedBox(height: 4 * 4),
      Container(
        //item
        margin: const EdgeInsets.only(right: 4),
        child: SizedBox(
          height: 230,
          child: PageView.builder(
            itemCount: itemCount,
            pageSnapping: true,
            controller: PageController(
              initialPage: 0,
              viewportFraction: 0.9,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  onTap(listWorkout[index]!);
                },
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
                        url: '$baserUrlMedia${listWorkout[index]?.image ?? ''}',
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
                              text:
                                  listWorkout[index]?.title ?? ''.toUpperCase(),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            textBodySmall(
                              text: listWorkout[index]?.description ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              color: context.isDarkMode
                                  ? Colors.grey
                                  : Colors.black.withOpacity(0.5),
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

Widget noData({required Function inReload}) {
  return Container(
    margin: EdgeInsets.zero,
    color: Get.theme.colorScheme.background,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              // color: Colors.cyan,
              margin: EdgeInsets.zero,
              //height: 20,
              child: Lottie.asset('assets/animate/nodata.json',
                  width: Get.width, fit: BoxFit.fill)),
          textBodyMedium(
            text: 'Không có dữ liệu',
            color: Get.theme.colorScheme.onBackground,
          ),
          GFButton(
            onPressed: () {
              inReload();
            },
            color: Get.theme.colorScheme.onBackground,
            colorScheme: Get.theme.colorScheme,
            text: 'Làm mới',
          )
        ],
      ),
    ),
  );
}

Widget filterChip(
    {required Tag? tag,
    required bool isSelect,
    required Function(Tag?) onChange}) {
  return ChoiceChip(
    label: textBodySmall(
        text: tag?.name ?? '',
        color: isSelect
            ? Get.theme.colorScheme.background
            : Get.theme.colorScheme.onBackground),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    selectedColor: Get.theme.colorScheme.onBackground,
    disabledColor: Get.theme.colorScheme.background,
    selected: isSelect,
    avatar: isSelect
        ? Icon(LucideIcons.check,
            color: isSelect
                ? Get.theme.colorScheme.background
                : Get.theme.colorScheme.onBackground)
        : null,
    onSelected: (bool value) {
      onChange(tag);
    },
  );
}

filterAlertTags(
    {required List<Tag?> result,
    required List<Tag?> choices,
    required Function(Tag?) onChange,
    required Function onSubmit}) {
  Get.dialog(
    AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: textBodyMedium(text: 'Hủy'),
          ),
          textTitleMedium(text: 'Lọc'),
          TextButton(
            onPressed: () {
              Get.back();
              onSubmit();
            },
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: textBodyMedium(text: 'Xác nhận'),
          ),
        ],
      ),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Wrap(
          spacing: 4,
          children: [
            for (var item1 in result) ...[
              filterChip(
                tag: item1,
                isSelect: choices.contains(item1) ? true : false,
                onChange: (item1) {
                  onChange(item1);
                  setState(() {});
                },
              )
            ]
          ],
        ),
      ),
    ),
  );
}
