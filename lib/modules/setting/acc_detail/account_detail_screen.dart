import 'package:calories/modules/setting/acc_detail/account_detail_controller.dart';
import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:calories/widgets/theme_textinput.dart';
import 'package:calories/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AccountDetailScreen extends StatefulWidget {
  const AccountDetailScreen({Key? key}) : super(key: key);
  static const String routeName = '/account_detail';
  @override
  State<AccountDetailScreen> createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  AccountDetailController accountDetailController =
      Get.put(AccountDetailController());
  GlobalKey<FormState> keyForm1 = GlobalKey<FormState>(debugLabel: '_FormA1');
  bool sex = true;
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
        marginTop: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(LucideIcons.x)),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
              onPressed: () {
                if (keyForm1.currentState?.validate() ?? false) {
                  //Get.offAndToNamed(HomeScreen.routeName);
                }
              },
              child: textBodyMedium(
                text: 'Lưu',
                color: Get.theme.colorScheme.onBackground
              ))
        ],
        bigTitle: false,
      ),
    );
  }

  Widget _buildBody() {
    return accountDetailController.obx((state) => SafeArea(
            child: SingleChildScrollView(
          child: Form(
            key: keyForm1,
            child: Container(
              margin: EdgeInsets.zero,
              padding: alignment_20_0(),
              color: Get.theme.colorScheme.background,
              child: Column(
                children: [
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          //final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                        },
                        child: Ink(
                          child: avatarImage(
                              url:
                                  'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                              radius: 60),
                        ),
                      ),
                      const SizedBox(
                        width: 4 * 5,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            TextFormField(
                              onTap: () {},
                              style: josefinSans(fontSize: 16),
                              validator: accountDetailController.validateString,
                              decoration:
                                  textFieldInputStyle(label: 'Họ & đệm (*)'),
                            ),
                            const SizedBox(
                              height: 4 * 5,
                            ),
                            TextFormField(
                              onTap: () {},
                              style: josefinSans(fontSize: 16),
                              validator: accountDetailController.validateString,
                              decoration: textFieldInputStyle(label: 'Tên (*)'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  TextField(
                    onTap: () {},
                    style: josefinSans(fontSize: 16),
                    readOnly: true,
                    decoration: textFieldInputStyle(label: 'Email'),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  TextFormField(
                    onTap: () {},
                    style: josefinSans(fontSize: 16),
                    showCursor: false,
                    readOnly: true,
                    decoration: textFieldInputStyle(label: 'Năm sinh (*)'),
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            sex = !sex;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: !sex ? Colors.grey : Colors.black)),
                          child: Center(
                            child: textBodyMedium(
                                text: 'Nam',
                                color: !sex ? Colors.grey : Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4 * 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            sex = !sex;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: sex ? Colors.grey : Colors.black)),
                          child: Center(
                            child: textBodyMedium(
                                text: 'Nữ',
                                color: sex ? Colors.grey : Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  TextField(
                    onTap: () {},
                    style: josefinSans(fontSize: 16),
                    decoration: textFieldInputStyle(label: 'Địa chỉ'),
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onTap: () {},
                          style: josefinSans(fontSize: 16),
                          validator: accountDetailController.numberValidator,
                          decoration:
                              textFieldInputStyle(label: 'Chiều cao (cm)'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 4 * 5,
                      ),
                      Expanded(
                        child: TextFormField(
                          onTap: () {},
                          style: josefinSans(fontSize: 16),
                          keyboardType: TextInputType.number,
                          validator: accountDetailController.numberValidator,
                          decoration:
                              textFieldInputStyle(label: 'Cân nặng (kg)'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
