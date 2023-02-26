import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/bottom_nav_bar.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:calories/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return buildBody(
        context: context,
        body: _buildBody(),
        appBar: null,
        bottomNavigationBar: bottomNavigationBar(
            onSelect: (index) => setState(() {
                  selectedIndex = index;
                }),
            selectedIndex: selectedIndex));
  }

  Widget _buildBody() {
    return SafeArea(
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
                      height: 4 * 20,
                    ),
                    textHeadlineSmall(
                        text: 'Welcome back'.toUpperCase(),
                        fontWeight: FontWeight.w700),
                    const SizedBox(
                      height: 4 * 4,
                    ),
                    textBodySmall(
                        text:
                            'Login in with one of the following options and get started',
                        fontSize : 12
                    ),
                    const SizedBox(
                      height: 4 * 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        textHeadlineSmall(text: 'test lần 2'),
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
            ],
          ),
        ),
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
