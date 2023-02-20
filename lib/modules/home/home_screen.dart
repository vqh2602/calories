import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return widgetOptions.elementAt(selectedIndex);
  }
}