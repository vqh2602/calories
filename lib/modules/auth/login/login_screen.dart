import 'package:calories/modules/auth/login/login_controller.dart';
import 'package:calories/modules/auth/signup/signup_screen.dart';
import 'package:calories/modules/home/home_screen.dart';
import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:calories/widgets/theme_textinput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());

  // GlobalKey<FormState> keyForm1 = GlobalKey<FormState>(debugLabel: '_FormS1');
  int selectedIndex = 0;
  bool passwordVisible = true;

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
      child: Container(
        padding: EdgeInsets.zero,
        child: Container(
          height: Get.height,
          margin: alignment_20_0(),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 4 * 20,
                  ),
                  textHeadlineLarge(
                      text: 'Calories', fontWeight: FontWeight.w700),
                  const SizedBox(
                    height: 4 * 1,
                  ),
                  textBodySmall(
                    text: 'Đăng nhập để bắt đầu quản lý quá trình tập luyện',
                  ),
                  const SizedBox(
                    height: 4 * 16,
                  ),
                  TextFormField(
                    onTap: () {},
                    style: josefinSans(fontSize: 16),
                    keyboardType: TextInputType.emailAddress,
                    decoration: textFieldInputStyle(label: 'Email'),
                    maxLines: 1,
                    validator: loginController.validateEmail,
                  ),
                  const SizedBox(
                    height: 4 * 6,
                  ),
                  TextField(
                    onTap: () {},
                    obscureText: passwordVisible,
                    decoration: textFieldInputStyle(
                        label: 'Mật khẩu',
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
                  ),
                  const SizedBox(
                    height: 4 * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.offAndToNamed(SignupScreen.routeName);
                        },
                        child: textBodySmall(
                          text: 'Chưa có tài khoản? Đăng kí',
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4 * 20,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GFButton(
                  onPressed: () {
                    // if (keyForm1.currentState?.validate() ?? false) {
                    Get.offAndToNamed(HomeScreen.routeName);
                    // }
                  },
                  padding: const EdgeInsets.only(
                    left: 4 * 5,
                    right: 4 * 5,
                  ),
                  size: 4 * 13,
                  color: Colors.black,
                  fullWidthButton: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textTitleSmall(
                          text: 'Đăng nhập'.toUpperCase(), color: Colors.white),
                      const Icon(
                        LucideIcons.arrowRight,
                        size: 4 * 6,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}