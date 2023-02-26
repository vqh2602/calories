import 'package:calories/modules/dashboard/dashboard_controller.dart';
import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/loading_custom.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:calories/widgets/theme_textinput.dart';
import 'package:calories/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const String routeName = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardController dashboardController = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return buildBody(
        context: context,
        isCheckBeforePop: true,
        body: _buildBody(),
        appBar: appBarCustom(title: 'TRANG CHỦ'.toUpperCase()));
  }

  Widget _buildBody() {
    return dashboardController.obx(
        (state) => SafeArea(
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
                    buildCarousel(listData: imageList),
                    const SizedBox(
                      height: 4 * 6,
                    ),
                    Container(
                      margin: alignment_20_0(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 4 * 12,
                          ),
                          buildTitleImageButton(
                              title: 'Tính toán calo',
                              des: 'TÌM HIỂU LƯỢNG CALO TIÊU THỤ MỖI NGÀY?',
                              image: 'assets/images/bg_calo.png',
                              onTap: () {}),
                          const SizedBox(
                            height: 4 * 25,
                          ),
                          buildTitleImageButton(
                              title: 'Tính toán BMI',
                              des: 'THEO DÕI SỐ LIỆU BMI QUA TỪNG NGÀY',
                              image: 'assets/images/bg_bmi.png',
                              onTap: () {
                                Get.bottomSheet(_showAddBMI(),
                                    backgroundColor: Colors.white);
                              }),
                          const SizedBox(
                            height: 4 * 25,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 4 * 5),
                      color: const Color(0xfff8f8f8),
                      width: Get.width,
                      child: buildTitleImageButton(
                          title: '',
                          des: 'TÌM KIẾM THÊM?\nHãy vào tập luyện',
                          image: 'assets/images/bg_gray.png',
                          textAlign: TextAlign.start,
                          fontSize: 4 * 5,
                          titleButton: 'VÀO TẬP LUYỆN',
                          alignmentDes: Alignment.centerLeft,
                          paddingButton: const EdgeInsets.all(4 * 5),
                          onTap: () {}),
                    ),
                    Container(
                      color: const Color(0xfff8f8f8),
                      width: Get.width,
                      height: 120,
                    )
                  ],
                ),
              ),
            )),
        onLoading: const LoadingCustom());
  }

  Widget _showAddBMI() {
    return Container(
      padding: alignment_20_8(),
      height: 300,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: () {}, child: textBodyMedium(text: 'Hủy')),
              TextButton(
                  onPressed: () {},
                  child: textTitleMedium(text: 'Cập nhật BMI')),
              TextButton(
                  onPressed: () {
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.info,
                        text: 'Cập nhật và thay thê dữ liệu hôm nay?'
                            '\n Chiều cao: 120 cm'
                            '\n Cân nặng: 60 kg',
                        title: 'Thông báo',
                        confirmBtnText: 'Xác nhận',
                        confirmBtnColor: Colors.black,
                        cancelBtnText: 'Hủy',
                        showCancelBtn: true,
                        onCancelBtnTap: () {
                          Get.back();
                        },
                        onConfirmBtnTap: () {
                          Get.back();
                        });
                  },
                  child: textBodyMedium(text: 'Lưu')),
            ],
          ),
          const SizedBox(
            height: 4 * 5,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                onTap: () {},
                decoration: textFieldInputStyle(label: 'Chiều cao (cm)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 4 * 5,
              ),
              TextField(
                onTap: () {},
                keyboardType: TextInputType.number,
                decoration: textFieldInputStyle(label: 'Cân nặng (kg)'),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

final List<String> imageList = [
  "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
];
