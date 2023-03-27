import 'package:calories/data/repositories/repo.dart';
import 'package:calories/modules/calorie_calculator/calorie_calculator_controller.dart';
import 'package:calories/widgets/base/base.dart';
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
      (state) => SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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

  Container totalCalorie(BuildContext context) {
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4 * 8),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 4 * 2),
                            textTitleMedium(text: 'Danh sách'),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: textBodyMedium(text: 'Tổng calo: 1500'),
                            ),
                            const SizedBox(height: 4 * 4),
                            addedFoodList(),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: textHeadlineMedium(text: 'Calo: 1500'),
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
              child:
                  searchBar(width: 0.75, controller: TextEditingController()),
            ),
            filterButton(context),
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
              content: Wrap(
                spacing: 4,
                children: List.generate(
                  foodController.listFoodTypes.length,
                  (index) => filterChip(
                    tag: foodController.listFoodTypes[index].toString(),
                  ),
                ),
              ),
            );
          },
        );
      },
      icon: const Icon(
        LucideIcons.filter,
      ),
    );
  }

  Column addedFoodList() {
    return Column(
      children: List.generate(
        foodData.length,
        (index) => addedFoodItem(
          image: foodData[index]['image'],
          foodName: foodData[index]['foodName'],
          calo: foodData[index]['calo'],
          quantity: 10,
        ),
      ),
    );
  }

  Widget foodList() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4 * 12),
      child: Column(
        children: List.generate(
          foodController.listFoods.length,
          (index) => foodItem(
            image: '$baserUrlMedia${foodController.listFoods[index]?.image}',
            foodName: foodController.listFoods[index]?.name ?? '',
            calo: foodController.listFoods[index]?.calo ?? 0,
          ),
        ),
      ),
    );
  }

  Container foodItem({
    required String image,
    required String foodName,
    required num calo,
  }) {
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
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: FractionalOffset.topCenter,
                  image: NetworkImage(image),
                ),
              ),
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
            onPressed: () {},
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

  Container addedFoodItem({
    required String image,
    required String foodName,
    required int calo,
    required int quantity,
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
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: FractionalOffset.topCenter,
                  image: NetworkImage(image),
                ),
              ),
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
          textBodySmall(text: 'SL: $quantity'),
          const SizedBox(width: 4 * 4),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              LucideIcons.edit,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}

List foodData = [
  {
    "image":
        'https://images.unsplash.com/photo-1601493700750-58796129ebb5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    "foodName": "Cà rốt",
    "calo": 150,
  },
  {
    "image":
        'https://images.unsplash.com/photo-1584615467033-75627d04dffe?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    "foodName": "Súp lơ trắng",
    "calo": 50,
  },
  {
    "image":
        'https://images.unsplash.com/photo-1582075482299-4123a7b6a3b3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=485&q=80',
    "foodName": "Ngô",
    "calo": 180,
  },
  {
    "image":
        'https://images.unsplash.com/photo-1608737637507-9aaeb9f4bf30?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80',
    "foodName": "Ớt chuông",
    "calo": 45,
  },
  {
    "image":
        'https://images.unsplash.com/photo-1590165482129-1b8b27698780?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=327&q=80',
    "foodName": "Khoai tây",
    "calo": 265,
  },
  {
    "image":
        'https://images.unsplash.com/photo-1601039641847-7857b994d704?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    "foodName": "Quả bơ",
    "calo": 185,
  },
  {
    "image":
        'https://images.unsplash.com/photo-1509622905150-fa66d3906e09?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80',
    "foodName": "Bí ngô",
    "calo": 245,
  },
];

List<String> tags = [
  'Thịt',
  'Rau',
  'Quả',
  'Củ',
  'Hải sản',
  'Hạt',
  'Sữa',
  'Ngũ cốc',
  'Bơ',
  'Tinh bột',
];
