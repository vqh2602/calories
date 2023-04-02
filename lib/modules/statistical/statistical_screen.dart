import 'package:calories/modules/statistical/statistical_controller.dart';
import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/loading_custom.dart';
import 'package:calories/widgets/share_function/share_funciton.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:calories/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class StatisticalScreen extends StatefulWidget {
  const StatisticalScreen({Key? key}) : super(key: key);
  static const String routeName = '/statistical';
  @override
  State<StatisticalScreen> createState() => _StatisticalScreenState();
}

class _StatisticalScreenState extends State<StatisticalScreen> {
  String timeW = 'T${DateTime.now().month}/${DateTime.now().year}';
  String timeB = 'T${DateTime.now().month}/${DateTime.now().year}';
  DateTime dtW = DateTime.now(), dtB = DateTime.now();
  StatisticalController statisticalController =
      Get.put(StatisticalController());

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
    return statisticalController.obx(
        (state) => SafeArea(
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
                          blockStatisticalToday(
                              time: statisticalController.time,
                              workout: statisticalController.workout,
                              kcal: statisticalController.kcal),
                          const SizedBox(
                            height: 4 * 14,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              textHeadlineSmall(
                                text: 'Biểu đồ tập luyện',
                              ),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Tooltip(
                                    message: '7 ngày trước đó',
                                    child: IconButton(
                                        onPressed: () {
                                          statisticalController
                                              .setDataChartUserWork(
                                                  isNext: false);
                                        },
                                        icon: const Icon(
                                            LucideIcons.chevronLeft)),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      dateTimePicker(onchange: (dt) async {
                                        setState(() {
                                          timeW = 'T${dt.month}/${dt.year}';
                                          dtW = dt;
                                        });
                                      }, onComplete: () async {
                                        await statisticalController.initData(
                                            dateTime: dtW, isWorkout: true);
                                      });
                                    },
                                    child: Container(
                                      // width: MediaQuery.of(context).size.width * 0.2,
                                      //margin: EdgeInsets.all(20),
                                      child: textBodySmall(
                                          text: timeW,
                                          overflow: TextOverflow.ellipsis,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                  Tooltip(
                                    message: '7 ngày sau đó',
                                    child: IconButton(
                                        onPressed: () {
                                          statisticalController
                                              .setDataChartUserWork(
                                                  isNext: true);
                                        },
                                        icon: const Icon(
                                            LucideIcons.chevronRight)),
                                  )
                                ],
                              ))
                            ],
                          ),
                          const SizedBox(
                            height: 4 * 10,
                          ),
                          chartCustom(
                              series: statisticalController
                                  .getDefaultSplineSeries()),
                          const SizedBox(
                            height: 4 * 14,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              textHeadlineSmall(
                                text: 'Biểu đồ BMI',
                              ),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Tooltip(
                                    message: '7 ngày trước đó',
                                    child: IconButton(
                                        onPressed: () {
                                          statisticalController
                                              .setDataChartUserBmi(
                                                  isNext: false);
                                        },
                                        icon: const Icon(
                                            LucideIcons.chevronLeft)),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      dateTimePicker(onchange: (dt) async {
                                        setState(() {
                                          timeB = 'T${dt.month}/${dt.year}';
                                          dtB = dt;
                                        });
                                      }, onComplete: () async {
                                        await statisticalController.initData(
                                            dateTime: dtB, isWorkout: false);
                                      });
                                    },
                                    child: Container(
                                      // width: MediaQuery.of(context).size.width * 0.2,
                                      //margin: EdgeInsets.all(20),
                                      child: textBodySmall(
                                          text: timeB,
                                          overflow: TextOverflow.ellipsis,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                  Tooltip(
                                    message: '7 ngày sau đó',
                                    child: IconButton(
                                        onPressed: () {
                                          statisticalController
                                              .setDataChartUserBmi(
                                                  isNext: true);
                                        },
                                        icon: const Icon(
                                            LucideIcons.chevronRight)),
                                  )
                                ],
                              ))
                            ],
                          ),
                          chartCustom(
                              series: statisticalController
                                  .getDefaultSplineSeriesBmi()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
        onLoading: const LoadingCustom());
  }
}
