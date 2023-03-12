import 'dart:convert';
import 'dart:developer';

import 'package:calories/data/models/user.dart';
import 'package:calories/data/repositories/repo.dart';
import 'package:calories/data/storage.dart';
import 'package:calories/widgets/share_function/share_funciton.dart';
import 'package:get_storage/get_storage.dart';

class UserRepo extends Repo {
  final box = GetStorage();
  // lấy thông tin ng dùng
  Future<User?> getUserByID(
      {required String userID, bool isCached = false}) async {
    User? user;
    if (isCached) {
      user = User.fromJson(jsonDecode(box.read(Storages.dataUser)));
    } else {
      var res = await dioRepo.get('/api/v1/users/$userID');
      var result = jsonDecode(res.toString());
      if (result["success"]) {
        user = User.fromJson(result['data']);
        box.write(Storages.dataUser, jsonEncode(result['data']));
      } else {
        buildToast(type: TypeToast.failure, title: result["message"]);
      }
    }
    return user;
  }

  // đăng nhập
  Future<User?> loginWithEmail(
      {required String email, required String passW}) async {
    User? user;
    var res = await dioRepo
        .post('/api/login', data: {"email": email, "password": passW});
    var result = jsonDecode(res.toString());
    if (result["success"] ?? false) {
      user = User.fromJson(result['data']);
      box.write(Storages.dataUser, jsonEncode(result['data']));
      buildToast(
          type: TypeToast.success,
          title: 'Đăng nhập thành công',
          message: 'Chào mừng ${user.name}');
    } else {
      buildToast(
          type: TypeToast.failure, title: result["message"] ?? 'có lỗi sảy ra');
    }
    log('Đăng nhập, user: ${user?.toJson().toString()}');
    return user;
  }

  // đăng nhập
  Future<User?> signupWithEmail(
      {required String email, required String passW}) async {
    User user = User();
    var res = await dioRepo.get('/api/register');
    var result = jsonDecode(res.toString());
    if (result["success"]) {
      user = User.fromJson(result['data']);
      box.write(Storages.dataUser, jsonEncode(result['data']));
    } else {
      buildToast(type: TypeToast.failure, title: result["message"]);
    }
    return user;
  }
}
