import 'dart:convert';

import 'package:calories/data/models/blog.dart';
import 'package:calories/data/repositories/repo.dart';
import 'package:calories/data/storage.dart';
import 'package:calories/widgets/share_function/share_funciton.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';

class BlogRepo extends Repo {
  final LocalAuthentication auth = LocalAuthentication();
  GetStorage box = GetStorage();

  // lấy thông tin danh sách blog
  Future<List<Blog?>> getBlog({bool isCached = false}) async {
    List<Blog?> lstBlog = [];

    if (isCached) {
      jsonDecode(box.read(Storages.dataBlog)).forEach((element) {
        lstBlog.add(Blog.fromJson(element));
      });
    } else {
      var res = await dioRepo.get('/api/v1/blogs');
      var result = jsonDecode(res.toString());
      if (result["success"]) {
        result['data'].forEach((element) {
          lstBlog.add(Blog.fromJson(element));
        });
        await box.write(Storages.dataBlog, jsonEncode(result['data']));
      } else {
        buildToast(type: TypeToast.failure, title: result["message"]);
      }
    }

    return lstBlog;
  }
}
