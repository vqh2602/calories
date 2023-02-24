import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/share_function/share_funciton.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:calories/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StatisticalScreen extends StatefulWidget {
  const StatisticalScreen({Key? key}) : super(key: key);
  static const String routeName = '/statistical';
  @override
  State<StatisticalScreen> createState() => _StatisticalScreenState();
}

class _StatisticalScreenState extends State<StatisticalScreen> {
  String time = 'T${DateTime.now().month}/${DateTime.now().year}';
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
          title: 'THỐNG KÊ'.toUpperCase(),
        ));
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
                    height: 4 * 3,
                  ),
                  textHeadlineSmall(text: 'Ngày'),
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
                      textHeadlineSmall(text: 'Biểu đồ tập luyện'),
                      InkWell(
                        onTap: () {
                          dateTimePicker(
                              onchange: (dt) {
                                setState(() {
                                  time = 'T${dt.month}/${dt.year}';
                                });
                              },
                              onComplete: () {});
                        },
                        child: Container(
                          // width: MediaQuery.of(context).size.width * 0.2,
                          //margin: EdgeInsets.all(20),
                          child: textBodySmall(
                              text: time,
                              overflow: TextOverflow.ellipsis,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
