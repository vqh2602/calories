import 'package:calories/modules/blog/blog_controller.dart';
import 'package:calories/modules/blog/blog_screen.dart';
import 'package:calories/modules/calorie_calculator/calorie_calculator_screen.dart';
import 'package:calories/modules/dashboard/dashboard_controller.dart';
import 'package:calories/modules/home/home_controller.dart';
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
  HomeController homeController = Get.find();
  GlobalKey<FormState> keyForm1 = GlobalKey<FormState>(debugLabel: '_FormBMI');

  DashboardController dashboardController = Get.put(DashboardController());
  BlogController blogController = Get.put(BlogController());

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
                              InkWell(
                                onTap: () {
                                  Get.toNamed(BlogScreen.routeName);
                                },
                                child: Ink(
                                  child: textBodySmall(
                                    text: 'xem thêm',
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4 * 6,
                    ),
                    buildCarousel(listData: blogController.listBlogs),
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
                            onTap: () {
                              Get.toNamed(CalorieCalculatorScreen.routeName);
                            },
                          ),
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
                          desColor: Get.theme.primaryColor,
                          alignmentDes: Alignment.centerLeft,
                          paddingButton: const EdgeInsets.all(4 * 5),
                          onTap: () {
                            homeController.selectItemScreen = 1;
                            homeController.changeUI();
                          }),
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
      color: Get.theme.colorScheme.background,
      height: 300,
      child: Form(
        key: keyForm1,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: textBodyMedium(text: 'Hủy')),
                TextButton(
                    onPressed: () {},
                    child: textTitleMedium(text: 'Cập nhật BMI')),
                TextButton(
                    onPressed: () {
                      if (keyForm1.currentState?.validate() ?? false) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.info,
                          text: 'Cập nhật và thay thê dữ liệu hôm nay?'
                              '\n Chiều cao: ${dashboardController.heightTE.text} cm'
                              '\n Cân nặng: ${dashboardController.weightTE.text} kg',
                          title: 'Thông báo',
                          confirmBtnText: 'Xác nhận',
                          confirmBtnColor: Colors.black,
                          cancelBtnText: 'Hủy',
                          showCancelBtn: true,
                          onCancelBtnTap: () {
                            Get.close(1);
                          },
                          onConfirmBtnTap: () {
                            Get.close(2);
                            dashboardController.updateBMI();
                          },
                        );
                      }
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
                TextFormField(
                  onTap: () {},
                  style: josefinSans(fontSize: 16),
                  controller: dashboardController.heightTE,
                  decoration: textFieldInputStyle(label: 'Chiều cao (cm)'),
                  keyboardType: TextInputType.number,
                  validator: dashboardController.numberValidator,
                ),
                const SizedBox(
                  height: 4 * 5,
                ),
                TextFormField(
                  onTap: () {},
                  style: josefinSans(fontSize: 16),
                  keyboardType: TextInputType.number,
                  controller: dashboardController.weightTE,
                  decoration: textFieldInputStyle(label: 'Cân nặng (kg)'),
                  validator: dashboardController.numberValidator,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
