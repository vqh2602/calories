import 'dart:async';
import 'dart:convert';

import 'package:calories/data/models/user.dart';
import 'package:calories/data/models/user_workout.dart';
import 'package:calories/data/repositories/user_repo.dart';
import 'package:calories/data/storage.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticalController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  UserRepo userRepo = UserRepo();
  User user = User();
  GetStorage box = GetStorage();
  List<UserWorkout?> listUserWorkOut = [];
  List<UserWorkout?> listUserWorkOutResult = [];
  List<ChartSampleData> chartData = []; // list biểu đồ
  List<ChartModel> listChartModel = []; // list chứa data sau khi đã gom nhóm
  String workout = '0', kcal = '0', time = '0';
  @override
  Future<void> onInit() async {
    loadingUI();
    await initUser();
    await initData(dateTime: DateFormat('dd/MM/yyyy').parse('02/04/2023'));
    changeUI();
    super.onInit();
  }

  onRefresh() async {
    initUser();
    changeUI();
  }

  initUser() async {
    user = User.fromJson(jsonDecode(await box.read(Storages.dataUser)));
  }

  Future<void> initData({DateTime? dateTime}) async {
    DateTime dateTimeData = dateTime ?? DateTime.now();

    listUserWorkOut = await userRepo.getUserWorkOut(
        userId: user.id.toString(),
        month: dateTimeData.month,
        year: dateTimeData.year);

    listUserWorkOutResult.addAll(listUserWorkOut);
    groupListData();
  }

  void groupListData() {
    Map listResult = listUserWorkOutResult.groupListsBy((e) =>
        DateFormat('dd/MM/yyyy').format(DateTime.parse(e?.createdAt ?? '')));

    // print('list: ${listResult.toString()}');
    for (var entry in listResult.entries) {
      // print(entry.key);
      // print(entry.value);
      listChartModel.add(ChartModel(
          day: DateFormat('dd/MM/yyyy')
              .parse(entry.key.toString())
              .day
              .toString(),
          time: getGroupDataUserWorkOut(entry.value, 2),
          workout: getGroupDataUserWorkOut(entry.value, 1),
          calo: getGroupDataUserWorkOut(entry.value, 0)));

      // lọc thông tin ngày hôm nay
      if (DateFormat('dd/MM/yyyy')
              .format(DateFormat('dd/MM/yyyy').parse(entry.key.toString())) ==
          DateFormat('dd/MM/yyyy')
              .format(DateTime.parse(DateTime.now().toString()))) {
        time = getGroupDataUserWorkOut(entry.value, 2).toString();
        workout = getGroupDataUserWorkOut(entry.value, 1).toString();
        kcal = getGroupDataUserWorkOut(entry.value, 0).toString();
      }
    }
    addDataChart();
  }

  // tính tổng data
  int getGroupDataUserWorkOut(List<UserWorkout?> lst, int key) {
    int data = 0;
    for (var element in lst) {
      if (key == 0) {
        //calo
        data += int.parse(element?.caloReal.toString() ?? '0');
      }
      if (key == 1) {
        //workout
        data = lst.length;
      }
      if (key == 2) {
        //time
        data += int.parse(element?.workoutRealtime.toString() ?? '0');
      }
    }
    return data;
  }

  void addDataChart() {
    // chartData = <ChartSampleData>[
    //   ChartSampleData(x: 'T2', calo: 37, time: 41, workout: 44),
    //   ChartSampleData(x: 'T3', calo: 37, time: 45, workout: 7),
    //   ChartSampleData(x: 'T4', calo: 37, time: 45, workout: 12),
    //   ChartSampleData(x: 'T5', calo: 37, time: 45, workout: 55),
    //   ChartSampleData(x: 'T6', calo: 37, time: 45, workout: 18),
    //   ChartSampleData(x: 'T7', calo: 39, time: 48, workout: 79),
    //   ChartSampleData(x: 'CN', calo: 43, time: 52, workout: 44),
    // ];
    for (ChartModel item in listChartModel) {
      chartData.add(
        ChartSampleData(
            x: item.day,
            calo: item.calo,
            time: item.time,
            workout: item.workout),
      );
    }
    update();
    changeUI();
  }

  /// get the spline series sample with dynamically updated data points.
  List<SplineSeries<ChartSampleData, String>> getDefaultSplineSeries() {
    return <SplineSeries<ChartSampleData, String>>[
      SplineSeries<ChartSampleData, String>(
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.calo,
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
        yValueMapper: (ChartSampleData sales, _) => sales.time,
      ),
      SplineSeries<ChartSampleData, String>(
        dataSource: chartData,
        name: 'Bài tập',
        color: Get.theme.colorScheme.onBackground,
        markerSettings: const MarkerSettings(isVisible: true),
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.workout,
      )
    ];
  }

  changeUI() {
    change(null, status: RxStatus.success());
  }

  updateUI() {
    update();
  }

  loadingUI() {
    change(null, status: RxStatus.loading());
  }
}

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.calo,
      this.time,
      this.workout,
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
  final num? calo;

  /// Holds y value of the datapoint(for 3nd series)
  final num? workout;

  final num? time;

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

class ChartModel {
  String day;
  int time;
  int workout;
  int calo;
  ChartModel(
      {required this.day,
      required this.time,
      required this.workout,
      required this.calo});
}
