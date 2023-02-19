import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:calories/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const String routeName = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return buildBody(
        context: context,
        body: _buildBody(),
        appBar: AppBar(
          titleSpacing: 0,
          title: Container(
            width: Get.width,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.grey.shade400))),
            child: Container(
                padding: alignment_20_8(),
                child: textTitleLarge(text: 'TRANG CHỦ')),
          ),
        ));
  }

  Widget _buildBody() {
    return SafeArea(
        child: Container(
      margin: alignment_20_0(),
      child: Container(
        padding: EdgeInsets.zero,
        child: SingleChildScrollView(
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
                  textBodySmall(
                    text: 'xem thêm',
                    decoration: TextDecoration.underline,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
