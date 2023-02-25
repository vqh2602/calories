import 'package:calories/data/repositories/repo.dart';

class UserRepo extends Repo{

  Future<dynamic> getCategoriesByID({required String type})async {
    var res = await dio.get('/get');
    return res;
  }

}