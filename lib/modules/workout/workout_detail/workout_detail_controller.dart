import 'package:calories/data/models/tag.dart';
import 'package:calories/data/repositories/tag_repo.dart';
import 'package:get/get.dart';

class WorkoutDetailController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  TagRepo tagRepo = TagRepo();
  List<Tag?> listTagsWorkouts = [];
  @override
  Future<void> onInit() async {
    await initTag();
    changeUI();
    super.onInit();
  }
  initTag() async {
    listTagsWorkouts.clear();
    List<Tag?> lst = await tagRepo.getTags(isCached: false);
    listTagsWorkouts = lst
        .where((element) =>
    element?.type == 3 &&
        element?.id != 20 &&
        element?.id != 21 &&
        element?.id != 22 &&
        element?.id != 23)
        .toList();
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
