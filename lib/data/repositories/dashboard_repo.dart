import 'dart:convert';

import 'package:calories/data/repositories/repo.dart';
import 'package:calories/widgets/share_function/share_funciton.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';

class DashboardRepo extends Repo {
  final LocalAuthentication auth = LocalAuthentication();
  GetStorage box = GetStorage();

  // update height, weight for BMI
  Future<void> updateBMI({
    required String userID,
    required double height,
    required double weight,
  }) async {
    var res = await dioRepo.post(
      '/api/v1/bmi/$userID',
      data: {
        "weight": height,
        "height": weight,
      },
    );
    var result = jsonDecode(res.toString());
    if (result["success"] ?? false) {
      buildToast(
        type: TypeToast.success,
        title: 'Cập nhật thành công',
      );
    } else {
      buildToast(
          type: TypeToast.failure, title: result["message"] ?? 'Có lỗi xảy ra');
    }
  }
}
