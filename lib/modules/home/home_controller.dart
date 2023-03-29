import 'dart:async';

import 'package:calories/data/repositories/tag_repo.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  int selectItemScreen = 0;
  TagRepo tagRepo = TagRepo();
  @override
  Future<void> onInit() async {
    getTags();
    changeUI();
    super.onInit();
  }

  Future<void> getTags() async {
    tagRepo.getTags();
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
