import 'package:calories/data/models/food.dart';
import 'package:calories/data/repositories/repo.dart';
import 'package:calories/modules/calorie_calculator/calorie_calculator_controller.dart';
import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/image_custom.dart';
import 'package:calories/widgets/loading_custom.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:calories/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CalorieCalculatorScreen extends StatefulWidget {
  const CalorieCalculatorScreen({super.key});
  static const String routeName = '/calorie_calculator';

  @override
  State<CalorieCalculatorScreen> createState() =>
      _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  CalorieCalculatorController foodController =
      Get.put(CalorieCalculatorController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(context),
      appBar: appBarCustom(
        title: 'Tính calo thực phẩm',
        isPadding: false,
        bigTitle: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(LucideIcons.arrowLeft),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return foodController.obx(
      onLoading: const LoadingCustom(),
      (state) => SafeArea(
        child: Stack(
          children: [
            foodController.obx(
              (state) => RefreshIndicator(
                onRefresh: () async {
                  foodController.loadingUI();
                  await Future.delayed(const Duration(seconds: 2),
                      () => foodController.onRefresh());
                },
                child: SingleChildScrollView(
                  child: Container(
                    margin: alignment_20_0(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4 * 18),
                        foodList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: searchBox(context),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: totalCalorie(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget totalCalorie(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: Container(
        margin: alignment_20_0(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                      height: Get.height * 0.8,
                      margin: const EdgeInsets.symmetric(horizontal: 4 * 8),
                      // child: SingleChildScrollView(
                      //   child: Column(
                      //     children: [
                      //       const SizedBox(height: 4 * 2),
                      //       textTitleMedium(text: 'Danh sách'),
                      //       Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: foodController.obx(
                      //           (state) => textBodyMedium(
                      //               text:
                      //                   'Tổng calo: ${foodController.totalCalori}'),
                      //         ),
                      //       ),
                      //       const SizedBox(height: 4 * 4),
                      //       addedFoodList(),
                      //     ],
                      //   ),
                      // ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              const SizedBox(height: 4 * 2),
                              textTitleMedium(text: 'Danh sách'),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: foodController.obx(
                                  (state) => textBodyMedium(
                                      text:
                                          'Tổng calo: ${foodController.totalCalori}'),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4 * 20),
                            child: addedFoodList(),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: foodController.obx(
                (state) => textHeadlineMedium(
                  text: 'Calo: ${foodController.totalCalori}',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget filterChip({required String tag}) {
    return FilterChip(
      label: textBodySmall(text: tag),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      onSelected: (bool value) {},
    );
  }

  Widget searchBox(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Container(
        margin: alignment_20_0(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 4, bottom: 4),
              child: searchBar(
                width: 0.75,
                controller: foodController.searchTE,
                onChange: (value) {
                  foodController.searchListFood(search: value);
                },
              ),
            ),
            // filterButton(context),
            IconButton(
              onPressed: () => filterAlertTags(
                result: foodController.listTagFoods,
                choices: foodController.listTagFoodsChoice,
                onChange: (tag) {
                  bool add = true;
                  if (foodController.listTagFoodsChoice.isNotEmpty) {
                    for (var item in foodController.listTagFoodsChoice) {
                      if (item?.id == tag?.id) {
                        foodController.listTagFoodsChoice.remove(item);
                        add = false;
                        break;
                      }
                    }
                  } else {
                    // foodController.listTagsWorkoutsChoices
                    //     .add(tag);
                  }
                  add ? foodController.listTagFoodsChoice.add(tag) : null;
                  foodController.changeUI();
                  foodController.updateUI();
                },
                onSubmit: () {
                  foodController.searchListFoodsInTag();
                },
              ),
              icon: const Icon(LucideIcons.filter),
            )
          ],
        ),
      ),
    );
  }

  IconButton filterButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: textBodyMedium(text: 'Hủy'),
                  ),
                  textTitleMedium(text: 'Lọc'),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: textBodyMedium(text: 'Xác nhận'),
                  ),
                ],
              ),
              // content: Wrap(
              //   spacing: 4,
              //   children: List.generate(
              //     foodController.listFoodTypes.length,
              //     (index) => filterChip(
              //       tag: foodController.listFoodTypes[index].toString(),
              //     ),
              //   ),
              // ),
            );
          },
        );
      },
      icon: const Icon(
        LucideIcons.filter,
      ),
    );
  }

  Widget addedFoodList() {
    return foodController.obx(
      (state) => ListView.builder(
        itemCount: foodController.listAddedFood.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => addedFoodItem(
          image: '$baserUrlMedia${foodController.listAddedFood[index]?.image}',
          foodName: foodController.listAddedFood[index]?.name ?? '',
          calo: foodController.listAddedFood[index]?.calo ?? 0,
          quantity: foodController.listAddedFood[index]?.quantity ?? 0,
          id: foodController.listAddedFood[index]?.id ?? 0,
        ),
      ),
    );
  }

  Widget foodList() {
    return foodController.obx(
      (state) => Container(
        margin: const EdgeInsets.only(bottom: 4 * 12),
        child: foodController.listFoodResult.isNotEmpty
            ? RefreshIndicator(
                onRefresh: () async {
                  foodController.loadingUI();
                  await Future.delayed(
                    const Duration(seconds: 2),
                    () => foodController.onRefresh(),
                  );
                },
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: foodController.listFoodResult.length,
                  itemBuilder: (context, index) => foodItem(
                    image:
                        '$baserUrlMedia${foodController.listFoodResult[index]?.image}',
                    foodName: foodController.listFoodResult[index]?.name ?? '',
                    calo: foodController.listFoodResult[index]?.calo ?? 0,
                    food: foodController.listFoodResult[index],
                  ),
                ),
              )
            : noData(
                inReload: () {
                  foodController.listFoodResult
                      .addAll(foodController.listFoods);
                  foodController.searchTE.clear();
                  foodController.updateUI();
                },
              ),
      ),
    );
  }

  Container foodItem(
      {required String image,
      required String foodName,
      required num calo,
      required Food? food}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4 * 4),
      height: Get.height * 0.102,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        // borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: imageNetwork(
              url: image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 4 * 4),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4 * 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textHeadlineSmall(text: foodName, fontSize: 20),
                  const SizedBox(height: 4),
                  textBodySmall(
                      text: '$calo calo/100g', color: Colors.grey[600]),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              foodController.addFood(food: food);
            },
            // () {
            //   final itemExist = foodController.listAddedFood
            //       .firstWhere((e) => e?.id == food?.id, orElse: () => null);
            //   if (itemExist != null) {
            //     var add = itemExist.quantity;
            //     if (add != null) add++;
            //     itemExist.quantity = add;
            //   } else {
            //     foodController.listAddedFood.add(
            //       FoodAdded(
            //         id: food?.id,
            //         name: food?.name,
            //         calo: food?.calo,
            //         image: food?.image,
            //       ),
            //     );
            //   }

            //   foodController.updateUI();
            //   foodController.changeUI();
            //   buildToast(
            //     type: TypeToast.success,
            //     title: 'Đã thêm ${food?.name}',
            //   );
            // },
            icon: const Icon(
              LucideIcons.plusCircle,
              size: 24,
            ),
          ),
          const SizedBox(width: 4 * 4),
        ],
      ),
    );
  }

  Widget addedFoodItem({
    required String image,
    required String foodName,
    required num calo,
    required num quantity,
    required num id,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4 * 4),
      height: Get.height * 0.08,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        // borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: imageNetwork(
              url: image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 4 * 4),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4 * 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textHeadlineSmall(text: foodName, fontSize: 20),
                  const SizedBox(height: 4),
                  textBodySmall(
                      text: '$calo calo/100g', color: Colors.grey[600]),
                ],
              ),
            ),
          ),
          foodController.obx((state) => textBodySmall(text: 'x $quantity')),
          const SizedBox(width: 4 * 4),
          IconButton(
            onPressed: () {
              foodController.removeFood(id: id);
            },
            icon: const Icon(
              LucideIcons.delete,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
