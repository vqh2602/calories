import 'dart:convert';

import 'package:calories/data/models/user.dart';
import 'package:calories/data/repositories/dashboard_repo.dart';
import 'package:calories/data/repositories/user_repo.dart';
import 'package:calories/data/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  // DashboardController dashboardController = Get.find();
  late User user;
  GetStorage box = GetStorage();
  DashboardRepo dashboardRepo = DashboardRepo();
  UserRepo userRepo = UserRepo();

  TextEditingController heightTE = TextEditingController();
  TextEditingController weightTE = TextEditingController();
  String userID = '';
  late double height;
  late double weight;

  getDataUser() async {
    user = User.fromJson(jsonDecode(await box.read(Storages.dataUser)));
    updateUI();
  }

  Future<void> updateBMI() async {
    user = User.fromJson(jsonDecode(await box.read(Storages.dataUser)));
    height = double.parse(heightTE.text);
    weight = double.parse(weightTE.text);
    await dashboardRepo.updateBMI(
      userID: user.id.toString(),
      height: height,
      weight: weight,
    );
    await userRepo.updateHeightWeight(
      userID: user.id.toString(),
      height: height,
      weight: weight,
    );
    user = user.copyWith(
      height: height,
      weight: weight,
    );
    box.write(Storages.dataUser, jsonEncode(user));

    changeUI();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    loadingUI();
    getDataUser();

    Future.delayed(const Duration(seconds: 2), () {
      changeUI();
    });
  }

  String? numberValidator(String? value) {
    if (value == null || value == '') {
      return null;
    }
    final n = num.tryParse(value);
    if (n == null) {
      return '$value không phải kiểu số';
    }
    return null;
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
