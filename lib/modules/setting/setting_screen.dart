import 'package:calories/c_theme/c_theme.dart';
import 'package:calories/modules/setting/acc_detail/account_detail_screen.dart';
import 'package:calories/modules/setting/setting_controller.dart';
import 'package:calories/modules/splash/splash_screen.dart';
import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/loading_custom.dart';
import 'package:calories/widgets/share_function/share_funciton.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:calories/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  static const String routeName = '/Setting';
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingController settingController = Get.put(SettingController());

  @override
  void initState() {
    settingController.isGetBiometric();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      isCheckBeforePop: true,
      body: _buildBody(),
      appBar: appBarCustom(title: 'THIẾT ĐẶT'.toUpperCase()),
    );
  }

  Widget _buildBody() {
    return settingController.obx(
        (state) => SafeArea(
                child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.zero,
                color: Get.theme.colorScheme.background,
                child: Column(
                  children: [
                    Container(
                        height: 370,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Get.theme.colorScheme.background,
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey.shade300, width: 0.5))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            avatarImage(
                                url: '',
                                imageF: settingController.base64Image,
                                isFileImage: true,
                                radius: 60),
                            const SizedBox(
                              height: 4 * 5,
                            ),
                            textTitleMedium(
                                text: settingController.user?.name?.replaceAll('@', ' ').toUpperCase() ?? ''),
                            const SizedBox(
                              height: 4 * 10,
                            ),
                            GFButton(
                              onPressed: () {
                                Get.toNamed(AccountDetailScreen.routeName);
                              },
                              padding: const EdgeInsets.only(
                                left: 4 * 15,
                                right: 4 * 15,
                              ),
                              size: 4 * 10,
                              color: Colors.grey,
                              type: GFButtonType.outline,
                              child: textBodyMedium(
                                  text: 'Xem chi tiết',
                                  color: Get.theme.colorScheme.onBackground),
                            ),
                            const SizedBox(
                              height: 4 * 5,
                            ),
                          ],
                        )),
                    Container(
                        //height: 370,
                        width: Get.width,
                        color: Get.theme.colorScheme.background,
                        padding: alignment_20_0(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 4 * 5,
                            ),
                            const SizedBox(
                              height: 4 * 5,
                            ),
                            textTitleMedium(text: 'Cài đặt'.toUpperCase()),
                            const SizedBox(
                              height: 4 * 5,
                            ),
                            buttonSetting(
                                onTap: () {
                                  Get.toNamed(AccountDetailScreen.routeName);
                                },
                                iconStart: LucideIcons.userCog,
                                iconEnd: LucideIcons.chevronRight,
                                title: 'Chỉnh sửa hồ sơ'),
                            buttonSetting(
                                iconStart: LucideIcons.listVideo,
                                iconEnd: LucideIcons.chevronRight,
                                title: 'Tự động phát video',
                                valToggle: settingController.autoPlayVideo,
                                isToggle: true,
                                onChangeToggle: (val) {
                                  settingController.setAutoPlayVideo();
                                  buildToast(
                                      title: 'Thao tác thành công',
                                      message: (val != null && !val)
                                          ? 'Tắt tự phát video thành công'
                                          : 'Bật tự phát video thành công',
                                      type: TypeToast.success);
                                }),
                            buttonSetting(
                                iconStart: LucideIcons.fingerprint,
                                iconEnd: LucideIcons.chevronRight,
                                title: 'Đăng nhập nhanh',
                                isToggle: true,
                                valToggle: settingController.isBiometric,
                                onChangeToggle: (val) {
                                  settingController.initBiometric(val);
                                }),
                            buttonSetting(
                                iconStart: LucideIcons.listVideo,
                                iconEnd: LucideIcons.chevronRight,
                                title: 'Chế độ tối',
                                isToggle: true,
                                valToggle: ThemeService().loadThemeFromBox(),
                                onChangeToggle: (val) async {
                                  settingController.loadingUI();
                                  ThemeService().switchTheme();
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    Get.offAndToNamed(SplashScreen.routeName);
                                    setState(() {});
                                    //Get.offAndToNamed(SignupScreen.routeName);
                                  });
                                }),
                            buttonSetting(
                                iconStart: LucideIcons.shield,
                                iconEnd: LucideIcons.chevronRight,
                                onTap: () async {
                                  final url = Uri.parse('https://dieukhoanvqhapps.blogspot.com/');
                                  if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                  }
                                },
                                title: 'Dữ liệu người dùng'),
                            const SizedBox(
                              height: 4 * 5,
                            ),
                          ],
                        )),
                    Container(
                        //height: 370,
                        width: Get.width,
                        color: Get.theme.colorScheme.background,
                        padding: alignment_20_0(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 4 * 5,
                            ),
                            textTitleMedium(
                                text: 'Khám phá thêm'.toUpperCase()),
                            const SizedBox(
                              height: 4 * 5,
                            ),
                            buttonSetting(
                                iconStart: LucideIcons.messageCircle,
                                iconEnd: LucideIcons.chevronRight,
                                onTap: () async {
                                  final url = Uri.parse('mailto:vqh2602@gmail.com?subject=Hỗ trợ va phản hồi&body=nội dung');
                                  if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                  }
                                },
                                title: 'Hỗ trợ & Phản hồi'),
                            buttonSetting(
                              iconStart: LucideIcons.siren,
                              onTap: () async {
                                final url = Uri.parse('https://dieukhoanvqhapps.blogspot.com/');
                                if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                                }
                              },
                              iconEnd: LucideIcons.chevronRight,
                              title: 'Chính sách bảo mật',
                            ),
                            buttonSetting(
                                iconStart: LucideIcons.penTool,
                                onTap: () async {
                                  final url = Uri.parse('https://dieukhoanvqhapps.blogspot.com/');
                                  if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                  }
                                },
                                iconEnd: LucideIcons.chevronRight,
                                title: 'Điều khoản & Điều kiện'),
                            const SizedBox(
                              height: 4 * 10,
                            ),
                          ],
                        )),
                    Container(
                      padding: alignment_20_8(),
                      child: GFButton(
                        onPressed: () {
                          Get.dialog(CupertinoAlertDialog(
                            title: textBodyLarge(text: "Thông báo", fontWeight: FontWeight.w700),
                            content: Container(
                              margin: const EdgeInsets.only(top: 16),
                              child:
                              textBodyMedium(text: "Bạn có chắc chắn muốn đăng xuất?"),
                            ),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: textBodyMedium(
                                  text: "Hủy",
                                  color: Get.theme.colorScheme.error,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                              CupertinoDialogAction(
                                child: textBodyMedium(
                                  text: 'Xác nhận',
                                ),
                                onPressed: () {
                                  settingController.logout();
                                },
                              ),
                            ],

                          ));
                        },
                        padding: const EdgeInsets.only(
                          left: 4 * 5,
                          right: 4 * 5,
                        ),
                        size: 4 * 13,
                        color: Get.theme.colorScheme.onBackground,
                        type: GFButtonType.outline,
                        fullWidthButton: true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textTitleSmall(
                                text: 'Đăng xuất'.toUpperCase(),
                                color: Get.theme.colorScheme.onBackground),
                            const Icon(
                              LucideIcons.arrowRight,
                              size: 4 * 6,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4 * 5,
                    ),
                  ],
                ),
              ),
            )),
        onLoading: const LoadingCustom());
  }
}
