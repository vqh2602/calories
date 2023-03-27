import 'dart:async';

import 'package:calories/data/models/food.dart';
import 'package:calories/data/repositories/food_repo.dart';
import 'package:get/get.dart';

class CalorieCalculatorController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  int selectItemScreen = 0;
  FoodRepo foodRepo = FoodRepo();
  List<Food?> listFoods = [];
  List<String?> listFoodTypes = [];

  @override
  Future<void> onInit() async {
    getDataFood();
    getDataFoodType();
    changeUI();
    super.onInit();
  }

  Future<void> getDataFood() async {
    listFoods = await foodRepo.getFood();
    updateUI();
  }

  Future<void> getDataFoodType() async {
    listFoodTypes = await foodRepo.getFoodType();
    updateUI();
  }

  onRefresh() async {
    loadingUI();
    getDataFood();
    getDataFoodType();
    changeUI();
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
