import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/share_function/share_funciton.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:calories/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticalScreen extends StatefulWidget {
  const StatisticalScreen({Key? key}) : super(key: key);
  static const String routeName = '/statistical';
  @override
  State<StatisticalScreen> createState() => _StatisticalScreenState();
}

class _StatisticalScreenState extends State<StatisticalScreen> {
  String time = 'T${DateTime.now().month}/${DateTime.now().year}';
  List<ChartSampleData> chartData = [];
  @override
  void initState() {
    chartData = <ChartSampleData>[
      ChartSampleData(
          x: 'T2',
          y: 43,
          secondSeriesYValue: 37,
          thirdSeriesYValue: 41,
          threeSeriesYValue: 44),
      ChartSampleData(
          x: 'T3',
          y: 45,
          secondSeriesYValue: 37,
          thirdSeriesYValue: 45,
          threeSeriesYValue: 7),
      ChartSampleData(
          x: 'T4',
          y: 45,
          secondSeriesYValue: 37,
          thirdSeriesYValue: 45,
          threeSeriesYValue: 12),
      ChartSampleData(
          x: 'T5',
          y: 45,
          secondSeriesYValue: 37,
          thirdSeriesYValue: 45,
          threeSeriesYValue: 55),
      ChartSampleData(
          x: 'T6',
          y: 45,
          secondSeriesYValue: 37,
          thirdSeriesYValue: 45,
          threeSeriesYValue: 18),
      ChartSampleData(
          x: 'T7',
          y: 50,
          secondSeriesYValue: 39,
          thirdSeriesYValue: 48,
          threeSeriesYValue: 79),
      ChartSampleData(
          x: 'CN',
          y: 55,
          secondSeriesYValue: 43,
          thirdSeriesYValue: 52,
          threeSeriesYValue: 44),
    ];
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
                      textHeadlineSmall(
                        text: 'Biểu đồ tập luyện',
                      ),
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
                  const SizedBox(
                    height: 4 * 10,
                  ),
                  chartCustom(series: _getDefaultSplineSeries()),
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
                  chartCustom(series: _getDefaultSplineSeries()),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  /// get the spline series sample with dynamically updated data points.
  List<SplineSeries<ChartSampleData, String>> _getDefaultSplineSeries() {
    return <SplineSeries<ChartSampleData, String>>[
      SplineSeries<ChartSampleData, String>(
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.thirdSeriesYValue,
        color: Colors.grey,
        markerSettings: const MarkerSettings(isVisible: true),
        name: 'Kcal',
      ),
      SplineSeries<ChartSampleData, String>(
        dataSource: chartData,
        name: 'Thời gian',
        color: Colors.blueGrey,
        markerSettings: const MarkerSettings(isVisible: true),
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
      ),
      SplineSeries<ChartSampleData, String>(
        dataSource: chartData,
        name: 'Bài tập',
        color: Colors.black,
        markerSettings: const MarkerSettings(isVisible: true),
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.threeSeriesYValue,
      )
    ];
  }
}

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.threeSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  final num? threeSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}
