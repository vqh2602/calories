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
      appBar: null,
    );
  }

  Widget _buildBody() {
    return SafeArea(
        child: SingleChildScrollView(
      child: Form(
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
                    height: 4 * 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onTap: () {},
                          decoration:
                              textFieldInputStyle(label: 'Họ & đệm (*)'),
                        ),
                      ),
                      const SizedBox(
                        width: 4 * 5,
                      ),
                      Expanded(
                        child: TextFormField(
                          onTap: () {},
                          decoration: textFieldInputStyle(label: 'Tên (*)'),
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
                keyboardType: TextInputType.emailAddress,
                decoration: textFieldInputStyle(label: 'Email (*)'),
                maxLines: 1,
              ),
              const SizedBox(
                height: 4 * 5,
              ),
              TextFormField(
                onTap: () {
                  dateTimePicker(onchange: (dt) {}, onComplete: () {});
                },
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
              TextFormField(
                onTap: () {},
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
                      decoration: textFieldInputStyle(label: 'Chiều cao (cm)'),
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
                      decoration: textFieldInputStyle(label: 'Cân nặng (kg)'),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 4 * 10,
              ),
              GFButton(
                onPressed: () {
                  Get.offAndToNamed(HomeScreen.routeName);
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
      ),
    ));
  }
  
}
