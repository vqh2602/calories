import 'package:calories/data/repositories/repo.dart';

class UserRepo extends Repo{

  Future<dynamic> getCategoriesByID({required String type})async {
    var res = await dioRepo.get('/get');
    return res;
  }

}