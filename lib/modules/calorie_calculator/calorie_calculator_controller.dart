// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:calories/widgets/share_function/share_funciton.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:calories/data/models/food.dart';
import 'package:calories/data/models/tag.dart';
import 'package:calories/data/repositories/food_repo.dart';
import 'package:calories/data/repositories/tag_repo.dart';

class FoodAdded {
  num? id;
  String? name;
  String? image;
  num? calo;
  num? quantity;

  FoodAdded({
    this.id,
    this.name,
    this.image,
    this.calo,
    this.quantity = 1,
  });
}

class CalorieCalculatorController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  int selectItemScreen = 0;
  FoodRepo foodRepo = FoodRepo();
  TagRepo tagRepo = TagRepo();
  List<Food?> listFoods = [];
  List<Food?> listFoodResult = [];
  List<Tag?> listTagFoods = [];
  List<Tag?> listTagFoodsChoice = [];

  List<FoodAdded?> listAddedFood = [];

  num totalCalori = 0;

  TextEditingController searchTE = TextEditingController();

  @override
  Future<void> onInit() async {
    loadingUI();
    initTag();
    getDataFood();
    changeUI();
    super.onInit();
  }

  Future<void> getDataFood() async {
    listFoods = await foodRepo.getFood();
    listFoodResult.addAll(listFoods);

    updateUI();
  }

  void searchListFood({required String search}) {
    listFoodResult = listFoods
        .where((element) =>
            element?.name?.toLowerCase().contains(search.toLowerCase()) ??
            false)
        .toList();
    updateUI();
  }

  void calTotalCalo() {
    if (listAddedFood.isEmpty) {
      totalCalori = 0;
    } else {
      for (var item in listAddedFood) {
        // if (item != null) {
        //   totalCalori += item.calo! * item.quantity!;
        // }
        totalCalori += (item?.calo ?? 0) * (item?.quantity ?? 0);
      }
    }
  }

  initTag() async {
    listTagFoods.clear();
    listTagFoodsChoice.clear();
    List<Tag?> lst = await tagRepo.getTags(isCached: true);
    listTagFoods = lst.where((element) => element?.type == 1).toList();
  }

  void searchListFoodsInTag() {
    listFoodResult.clear();

    if (listTagFoodsChoice.isEmpty) {
      listFoodResult.addAll(listFoods);
      return;
    }

    for (var item1 in listFoods) {
      for (var item3 in listTagFoodsChoice) {
        if (item1?.tag?.id == item3?.id &&
            item1?.tag?.id != null &&
            item3?.id != null) {
          listFoodResult.add(item1);
        }
      }
    }
    listFoodResult = listFoodResult.toSet().toList();
    changeUI();
    updateUI();
  }

  void removeFood({num? id}) {
    var toRemove = [];
    for (var item in listAddedFood) {
      if (item?.id == id) {
        item?.quantity = (item.quantity ?? 0) - 1;
        totalCalori -= item?.calo ?? 0;
      }
      if (item?.quantity == 0) {
        toRemove.add(item);
      }
    }
    listAddedFood.removeWhere((e) => toRemove.contains(e));
    changeUI();
    updateUI();
  }

  void addFood({Food? food}) {
    final itemExist =
        listAddedFood.firstWhere((e) => e?.id == food?.id, orElse: () => null);
    if (itemExist != null) {
      itemExist.quantity = (itemExist.quantity ?? 0) + 1;
      totalCalori += itemExist.calo!;
    } else {
      listAddedFood.add(
        FoodAdded(
          id: food?.id,
          name: food?.name,
          calo: food?.calo,
          image: food?.image,
        ),
      );
      totalCalori += food?.calo ?? 0;
    }

    updateUI();
    changeUI();
    buildToast(
      type: TypeToast.success,
      title: 'Đã thêm ${food?.name}',
    );
  }

  onRefresh() async {
    loadingUI();
    getDataFood();
    searchTE.clear();
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
