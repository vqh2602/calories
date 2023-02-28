import 'package:calories/modules/home/home_controller.dart';
import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/bottom_nav_bar.dart';
import 'package:calories/widgets/loading_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return homeController.obx(
        (state) => buildBody(
            context: context,
            body: _buildBody(),
            appBar: null,
            bottomNavigationBar: bottomNavigationBar(
                onSelect: (index) => setState(() {
                      homeController.selectItemScreen = index;
                      homeController.changeUI();
                    }),
                selectedIndex: homeController.selectItemScreen)),
        onLoading: const LoadingCustom());
  }

  Widget _buildBody() {
    return widgetOptions.elementAt(homeController.selectItemScreen);
  }
}
