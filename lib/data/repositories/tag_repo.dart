import 'dart:convert';
import 'package:calories/data/models/tag.dart';
import 'package:calories/data/repositories/repo.dart';
import 'package:calories/data/storage.dart';
import 'package:calories/widgets/share_function/share_funciton.dart';
import 'package:get_storage/get_storage.dart';

class TagRepo extends Repo {
  GetStorage box = GetStorage();
  // lấy thông tin danh sách tag
  Future<List<Tag?>> getTags({bool isCached = false}) async {
    List<Tag?> lstTag = [];
    if (isCached) {
      jsonDecode(box.read(Storages.dataTag)).forEach((element) {
        lstTag.add(Tag.fromJson(element));
      });
    } else {
      var res = await dioRepo.get('/api/v1/tags');
      var result = jsonDecode(res.toString());
      if (result["success"]) {
        result['data'].forEach((element) {
          lstTag.add(Tag.fromJson(element));
        });
        await box.write(Storages.dataTag, jsonEncode(result['data']));
      } else {
        buildToast(type: TypeToast.failure, title: result["message"]);
      }
    }
    return lstTag;
  }
}
