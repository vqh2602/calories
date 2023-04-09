import 'dart:async';
import 'dart:convert';

import 'package:calories/data/models/user.dart';
import 'package:calories/data/models/user_bmi.dart';
import 'package:calories/data/models/user_workout.dart';
import 'package:calories/data/repositories/user_repo.dart';
import 'package:calories/data/storage.dart';
import 'package:calories/widgets/share_function/share_funciton.dart';
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
  List<UserWorkout?> listUserWorkOutDays = [];

  List<UserBmi?> listUserBmi = [];
  List<UserBmi?> listUserBmiResult = [];

  List<ChartSampleData> chartDataWorkout = []; // list biểu đồ workout
  List<ChartSampleDataBmi> chartDataBmi = [];
  // list biểu đồ
  List<ChartModel> listChartModelWorkout =
      []; // list chứa data sau khi đã gom nhóm
  List<List<ChartModel>> sublistChartModelWorkout =
      []; // list chứa data sau khi đã tách làm các list con gồm 7 phần tử
  List<List<ChartModelBmi>> sublistChartModelBmi = [];
  String workout = '0', kcal = '0', time = '0';
  int indexListChartWorkout = 0,
      indexListChartBmi = 0; // đang ở sublist nào. mặc định là 0
  @override
  Future<void> onInit() async {
    loadingUI();
    clearData();
    await initUser();
    await initData();
    await initDataToDay();
    changeUI();
    super.onInit();
  }

  onRefresh() async {
    clearData();
    clearDataBmi();
    await initUser();
    await initData();
    await initDataToDay();
    changeUI();
  }

  clearData({bool isAll = false}) {
    listUserWorkOut.clear();
    listUserWorkOutResult.clear();
    chartDataWorkout.clear();
    listChartModelWorkout.clear();
    listUserWorkOutDays.clear();
    if(isAll) {
      workout = '0';
      kcal = '0';
      time = '0';
    }
    indexListChartWorkout = 0;
  }

  clearDataBmi() {
    indexListChartBmi = 0;
    sublistChartModelBmi.clear();
    listUserBmi.clear();
    listUserBmiResult.clear();
    chartDataBmi.clear();
  }

  initUser() async {
    user = User.fromJson(jsonDecode(await box.read(Storages.dataUser)));
  }

  Future<void> initData({DateTime? dateTime, bool? isWorkout}) async {
    DateTime dateTimeData = dateTime ?? DateTime.now();
    // workout call api
    if (isWorkout == null || isWorkout) {
      clearData(isAll: false);
      listUserWorkOut = await userRepo.getUserWorkOut(
          userId: user.id.toString(),
          month: dateTimeData.month,
          year: dateTimeData.year);
      listUserWorkOutResult.addAll(listUserWorkOut);
      listUserWorkOutResult.sort((a, b) => a!.updatedAt!.compareTo(b!.updatedAt!));
      groupListData(
          result: listUserWorkOutResult, chartModel: listChartModelWorkout);
    }
    // //work out bmi
    if (isWorkout == null || !isWorkout) {
      clearDataBmi();
      listUserBmi = await userRepo.getUserBmi(
          userId: user.id.toString(), dateTime: dateTimeData);
      listUserBmiResult.addAll(listUserBmi);
      listUserBmiResult.sort((a, b) => a!.updatedAt!.compareTo(b!.updatedAt!));
     // print('bmi result: ${listUserBmiResult.length}');
      addDataChartUserBmi();
    }
  }

  Future<void> initDataToDay() async {
    listUserWorkOutDays = await userRepo.getUserWorkOut(
        userId: user.id.toString(),
        month: DateTime.now().month,
        year: DateTime.now().year);
    groupListData(
        result: listUserWorkOutDays, chartModel: null, isGetDays: true);
  updateUI();
  }

  void groupListData(
      {required List<UserWorkout?> result,
      required List<ChartModel>? chartModel,
      bool isGetDays = false}) {
    Map listResult = result.groupListsBy((e) =>
        DateFormat('dd/MM/yyyy').format(DateTime.parse(e?.createdAt ?? '')));

    // print('list: ${listResult.toString()}');
    for (var entry in listResult.entries) {
      // print(entry.key);
      // print(entry.value);
      if (!isGetDays) {
        chartModel?.add(ChartModel(
            day: DateFormat('dd/MM/yyyy')
                .parse(entry.key.toString())
                .day
                .toString(),
            time: getGroupDataUserWorkOut(entry.value, 2),
            workout: getGroupDataUserWorkOut(entry.value, 1),
            calo: getGroupDataUserWorkOut(entry.value, 0)));
      } else {
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
    }
    isGetDays ? null : addDataChartUserWork();
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

  // thêm data từ listchartmodel thành các chuỗi con
  void addDataChartUserWork() {
    sublistChartModelWorkout.clear();
    indexListChartWorkout = 0;
// Tách danh sách ban đầu thành các danh sách con (7 phần tử)
    for (int i = 0; i < listChartModelWorkout.length; i += 7) {
      int end = (i + 7 < listChartModelWorkout.length)
          ? i + 7
          : listChartModelWorkout.length;
      List<ChartModel> sublist = listChartModelWorkout.sublist(i, end);
      sublistChartModelWorkout.add(sublist);
    }
    setDataChartUserWork();
  }

  // thêm data từ listchartmodel thành các chuỗi con
  void addDataChartUserBmi() {
    sublistChartModelBmi.clear();
    indexListChartBmi = 0;
// Tách danh sách ban đầu thành các danh sách con (7 phần tử)
    for (int i = 0; i < listUserBmiResult.length; i += 7) {
      int end =
          (i + 7 < listUserBmiResult.length) ? i + 7 : listUserBmiResult.length;
      List<UserBmi?> sublist = listUserBmiResult.sublist(i, end);
      sublistChartModelBmi.add(sublist
          .map((e) => ChartModelBmi(
              day: DateTime.parse(e?.createdAt ?? '').day.toString(),
              bmi: calculateBMI(
                  h: double.parse(e?.height.toString() ?? '0'),
                  w: double.parse(e?.weight.toString() ?? '0'))))
          .toList());
    }
    //print('bmi sublist: ${sublistChartModelBmi.length}');
    setDataChartUserBmi();
  }

// từ chuỗi con cho phép bấm next hoặc quay lại list con (max 7 phần tử) tương ứng
  void setDataChartUserWork({bool? isNext}) {
    // In các danh sách con
    chartDataWorkout.clear();
    if (indexListChartWorkout >= 0 &&
        indexListChartWorkout < sublistChartModelWorkout.length &&
        sublistChartModelWorkout.isNotEmpty) {
      (isNext != null && !isNext && indexListChartWorkout > 0)
          ? indexListChartWorkout--
          : null;
      (isNext != null &&
              isNext &&
              indexListChartWorkout < sublistChartModelWorkout.length - 1)
          ? indexListChartWorkout++
          : null;
      for (ChartModel item in sublistChartModelWorkout[indexListChartWorkout]) {
        chartDataWorkout.add(
          ChartSampleData(
              x: item.day,
              calo: item.calo,
              time: item.time,
              workout: item.workout),
        );
      }
    } else if (listChartModelWorkout.length < 7) {
      // nếu list cha trống hoặc tổng phần tử < 7 thì lấy luôn list cha
      for (ChartModel item in listChartModelWorkout) {
        indexListChartWorkout = 0;
        chartDataWorkout.add(
          ChartSampleData(
              x: item.day,
              calo: item.calo,
              time: item.time,
              workout: item.workout),
        );
      }
    }
    update();
    changeUI();
  }

  void setDataChartUserBmi({bool? isNext}) {
    // In các danh sách con
    chartDataBmi.clear();
    if (indexListChartBmi >= 0 &&
        indexListChartBmi < sublistChartModelBmi.length &&
        sublistChartModelBmi.isNotEmpty) {
      (isNext != null && !isNext && indexListChartBmi > 0)
          ? indexListChartBmi--
          : null;
      (isNext != null &&
              isNext &&
              indexListChartBmi < sublistChartModelBmi.length)
          ? indexListChartBmi++
          : null;
      for (ChartModelBmi item in sublistChartModelBmi[indexListChartBmi]) {
        chartDataBmi.add(
          ChartSampleDataBmi(x: item.day, bmi: item.bmi),
        );
      }
    } else if (listUserBmiResult.length < 7) {
      // nếu list cha trống hoặc tổng phần tử < 7 thì lấy luôn list cha
      for (UserBmi? item in listUserBmiResult) {
        indexListChartBmi = 0;
        chartDataBmi.add(
          ChartSampleDataBmi(
              x: DateTime.parse(item?.createdAt ?? '').day.toString(),
              bmi: calculateBMI(
                  h: double.parse(item?.height.toString() ?? '0'),
                  w: double.parse(item?.weight.toString() ?? '0'))),
        );
      }
    }
    //print('chart bmi : ${chartDataBmi.length}');
    update();
    changeUI();
  }

  /// get the spline series sample with dynamically updated data points.
  List<SplineSeries<ChartSampleData, String>> getDefaultSplineSeries() {
    return <SplineSeries<ChartSampleData, String>>[
      SplineSeries<ChartSampleData, String>(
        dataSource: chartDataWorkout,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.calo,
        color: Colors.grey,
        markerSettings: const MarkerSettings(isVisible: true),
        name: 'Kcal',
      ),
      SplineSeries<ChartSampleData, String>(
        dataSource: chartDataWorkout,
        name: 'Thời gian',
        color: Colors.blueGrey,
        markerSettings: const MarkerSettings(isVisible: true),
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.time,
      ),
      SplineSeries<ChartSampleData, String>(
        dataSource: chartDataWorkout,
        name: 'Bài tập',
        color: Get.theme.colorScheme.onBackground,
        markerSettings: const MarkerSettings(isVisible: true),
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.workout,
      )
    ];
  }

  /// get the spline series sample with dynamically updated data points.
  List<SplineSeries<ChartSampleDataBmi, String>> getDefaultSplineSeriesBmi() {
    return <SplineSeries<ChartSampleDataBmi, String>>[
      SplineSeries<ChartSampleDataBmi, String>(
        dataSource: chartDataBmi,
        xValueMapper: (ChartSampleDataBmi sales, _) => sales.x as String,
        yValueMapper: (ChartSampleDataBmi sales, _) => sales.bmi,
        color: Get.theme.colorScheme.onBackground,
        markerSettings: const MarkerSettings(isVisible: true),
        name: 'BMI',
      ),
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

class ChartSampleDataBmi {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleDataBmi(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.bmi,
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
  final num? bmi;

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

class ChartModelBmi {
  String day;
  double bmi;
  ChartModelBmi({required this.day, required this.bmi});
}
