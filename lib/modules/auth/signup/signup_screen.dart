import 'dart:io';

import 'package:calories/modules/auth/signup/signup_controller.dart';
import 'package:calories/modules/home/home_screen.dart';
import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/share_function/share_funciton.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:calories/widgets/theme_textinput.dart';
import 'package:calories/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const String routeName = '/signup';
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupController signupController = Get.put(SignupController());
  GlobalKey<FormState> keyForm1 = GlobalKey<FormState>(debugLabel: '_FormS1');
  bool sex = true;
  bool passwordVisible = true;
  File? imagePath;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
      appBar: null,
    );
  }

  Widget _buildBody() {
    return SafeArea(
        child: SingleChildScrollView(
      child: signupController.obx((state) => Form(
            key: keyForm1,
            child: Container(
              margin: EdgeInsets.zero,
              padding: alignment_20_0(),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 4 * 10,
                  ),
                  textTitleLarge(text: 'Đăng kí'.toUpperCase()),
                  textBodyMedium(
                      text: 'Đăng kí tài khoản để có thể truy cập ứng dụng'),
                  const SizedBox(
                    height: 4 * 10,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            try {
                              imagePath = File(image!.path);
                            } catch (_) {}
                          });
                        },
                        child: Ink(
                          child: avatarImage(
                              url: '',
                              imageF: imagePath,
                              isFileImage: true,
                              radius: 60),
                        ),
                      ),
                      const SizedBox(
                        height: 4 * 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onTap: () {},
                              style: josefinSans(fontSize: 16),
                              decoration:
                                  textFieldInputStyle(label: 'Họ & đệm (*)'),
                              validator: signupController.validateString,
                            ),
                          ),
                          const SizedBox(
                            width: 4 * 5,
                          ),
                          Expanded(
                            child: TextFormField(
                              onTap: () {},
                              style: josefinSans(fontSize: 16),
                              decoration: textFieldInputStyle(label: 'Tên (*)'),
                              validator: signupController.validateString,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  TextFormField(
                    onTap: () {},
                    style: josefinSans(fontSize: 16),
                    keyboardType: TextInputType.emailAddress,
                    decoration: textFieldInputStyle(label: 'Email (*)'),
                    maxLines: 1,
                    validator: signupController.validateEmail,
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  TextFormField(
                    onTap: () {},
                    style: josefinSans(fontSize: 16),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: passwordVisible,
                    decoration: textFieldInputStyle(
                        label: 'Mật khẩu (*)',
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          child: Ink(
                            child: Icon(passwordVisible
                                ? LucideIcons.eye
                                : LucideIcons.eyeOff),
                          ),
                        )),
                    maxLines: 1,
                    validator: signupController.validatePass,
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  TextFormField(
                    onTap: () {},
                    style: josefinSans(fontSize: 16),
                    keyboardType: TextInputType.visiblePassword,
                    decoration: textFieldInputStyle(
                        label: 'Nhập lại mật khẩu (*)',
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          child: Ink(
                            child: Icon(passwordVisible
                                ? LucideIcons.eye
                                : LucideIcons.eyeOff),
                          ),
                        )),
                    maxLines: 1,
                    validator: signupController.validateConfirmPass,
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  TextFormField(
                    onTap: () {
                      dateTimePicker(
                          onchange: (dt) {
                            signupController.birthTE?.text = formatDate(
                                type: TypeDate.ddMMyyyy, dateTime: dt);
                          },
                          onComplete: () {});
                    },
                    controller: signupController.birthTE,
                    showCursor: false,
                    readOnly: true,
                    style: josefinSans(fontSize: 16),
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
                  TextFormField(
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
                          validator: signupController.numberValidator,
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
                          keyboardType: TextInputType.number,
                          validator: signupController.numberValidator,
                          decoration:
                              textFieldInputStyle(label: 'Cân nặng (kg)'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4 * 10,
                  ),
                  GFButton(
                    onPressed: () {
                      if (keyForm1.currentState?.validate() ?? false) {
                        Get.offAndToNamed(HomeScreen.routeName);
                      }
                    },
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
                            text: 'Đăng kí'.toUpperCase(), color: Colors.black),
                        const Icon(
                          LucideIcons.arrowRight,
                          size: 4 * 6,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Ink(
                      child: textBodyMedium(
                          text: 'Đã có tài khoản? Đăng nhập',
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  const SizedBox(
                    height: 4 * 10,
                  ),
                ],
              ),
            ),
          )),
    ));
  }
}
