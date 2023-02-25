import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:calories/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AccountDetailScreen extends StatefulWidget {
  const AccountDetailScreen({Key? key}) : super(key: key);
  static const String routeName = '/account_detail';
  @override
  State<AccountDetailScreen> createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
      appBar: appBarCustom(
          title: 'Chỉnh sửa tài khoản',
          isPadding: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(LucideIcons.x)),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(onPressed: (){}, child: textBodyMedium(text: 'Lưu',))
          ],
          bigTitle: false,
          isBorder: true),
    );
  }

  Widget _buildBody() {
    return SafeArea(
        child: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: Column(
          children: [
            Container(
                height: 370,
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey.shade300, width: 0.5))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    avatarImage(
                        url:
                            'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                        radius: 60),
                    const SizedBox(
                      height: 4 * 5,
                    ),
                    textTitleMedium(text: 'VƯƠNG quang Huy'.toUpperCase()),
                    const SizedBox(
                      height: 4 * 10,
                    ),
                    GFButton(
                      onPressed: () {},
                      padding: const EdgeInsets.only(
                        left: 4 * 15,
                        right: 4 * 15,
                      ),
                      size: 4 * 10,
                      color: Colors.grey,
                      type: GFButtonType.outline,
                      child: textBodyMedium(
                          text: 'Xem chi tiết', color: Colors.black),
                    ),
                    const SizedBox(
                      height: 4 * 5,
                    ),
                  ],
                )),
            Container(
                //height: 370,
                width: Get.width,
                color: Colors.white,
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
                        iconStart: LucideIcons.userCog,
                        iconEnd: LucideIcons.chevronRight,
                        title: 'Chỉnh sửa hồ sơ'),
                    buttonSetting(
                        iconStart: LucideIcons.listVideo,
                        iconEnd: LucideIcons.chevronRight,
                        title: 'Tự động phát video',
                        isToggle: true,
                        onChangeToggle: (val) {}),
                    buttonSetting(
                        iconStart: LucideIcons.shield,
                        iconEnd: LucideIcons.chevronRight,
                        title: 'Dữ liệu người dùng'),
                    const SizedBox(
                      height: 4 * 5,
                    ),
                  ],
                )),
            Container(
                //height: 370,
                width: Get.width,
                color: Colors.white,
                padding: alignment_20_0(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 4 * 5,
                    ),
                    textTitleMedium(text: 'Khám phá thêm'.toUpperCase()),
                    const SizedBox(
                      height: 4 * 5,
                    ),
                    buttonSetting(
                        iconStart: LucideIcons.messageCircle,
                        iconEnd: LucideIcons.chevronRight,
                        title: 'Hỗ trợ & Phản hồi'),
                    buttonSetting(
                      iconStart: LucideIcons.siren,
                      iconEnd: LucideIcons.chevronRight,
                      title: 'Chính sách bảo mật',
                    ),
                    buttonSetting(
                        iconStart: LucideIcons.penTool,
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
                onPressed: () {},
                padding: const EdgeInsets.only(
                  left: 4 * 5,
                  right: 4 * 5,
                ),
                size: 4 * 13,
                color: Colors.black,
                type: GFButtonType.outline,
                fullWidthButton: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textTitleSmall(
                        text: 'Đăng xuất'.toUpperCase(), color: Colors.black),
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
    ));
  }
}