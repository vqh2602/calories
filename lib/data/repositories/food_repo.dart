import 'dart:convert';

import 'package:calories/data/models/food.dart';
import 'package:calories/data/models/tag.dart';
import 'package:calories/data/repositories/repo.dart';
import 'package:calories/data/storage.dart';
import 'package:calories/widgets/share_function/share_funciton.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';

class FoodRepo extends Repo {
  final LocalAuthentication auth = LocalAuthentication();
  GetStorage box = GetStorage();

  Future<List<Food?>> getFood() async {
    List<Food?> lstFood = [];

    //get food data from api
    var res = await dioRepo.get('/api/v1/foods');
    var result = jsonDecode(res.toString());
    if (result["success"]) {
      result['data'].forEach((element) {
        lstFood.add(Food.fromJson(element));
      });
      await box.write(Storages.dataBlog, jsonEncode(result['data']));
    } else {
      buildToast(type: TypeToast.failure, title: result["message"]);
    }

    return lstFood;
  }

  Future<List<String?>> getFoodType() async {
    List<Tag?> lstTag = [];
    List<String?> lstFoodType = [];

    var res = await dioRepo.get('/api/v1/tags');
    var result = jsonDecode(res.toString());
    if (result["success"]) {
      result['data'].forEach(
        (element) {
          lstTag.add(Tag.fromJson(element));
        },
      );
    } else {
      buildToast(type: TypeToast.failure, title: result["message"]);
    }

    for (var element in lstTag) {
      if (element?.type == 1) {
        lstFoodType.add(element?.name);
      }
    }

    return lstFoodType;
  }
}
