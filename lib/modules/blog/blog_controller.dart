import 'dart:async';

import 'package:calories/data/models/blog.dart';
import 'package:calories/data/repositories/blog_repo.dart';
import 'package:get/get.dart';

class BlogController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  BlogRepo blogRepo = BlogRepo();
  List<Blog?> listBlogs = [];

  @override
  Future<void> onInit() async {
    getDataBlog();
    changeUI();
    super.onInit();
  }

  Future<void> getDataBlog() async {
    listBlogs = await blogRepo.getBlog();
    updateUI();
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
