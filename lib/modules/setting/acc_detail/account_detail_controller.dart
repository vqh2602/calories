import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:calories/data/models/user.dart';
import 'package:calories/data/repositories/user_repo.dart';
import 'package:calories/data/storage.dart';
import 'package:calories/modules/setting/setting_controller.dart';
import 'package:calories/widgets/share_function/share_funciton.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class AccountDetailController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  SettingController settingController = Get.find();
  late TextEditingController emailTE,
      birtTE,
      addressTE,
      heightTE,
      weightTE,
      lastNameTE,
      firstNameTE;
  GetStorage box = GetStorage();
  UserRepo userRepo = UserRepo();
  num sex = 1;
  late User user;
  Uint8List? base64Image;
  String base64ImageConvert = '';

  @override
  Future<void> onInit() async {
    super.onInit();
    loadingUI();
    initData();
    getDataUser();
    changeUI();
  }

  getDataUser() async {
    user = User.fromJson(jsonDecode(await box.read(Storages.dataUser)));
    //print('user: ${user.toJson()}');
    emailTE.text = user.email ?? '';
    firstNameTE.text = splitNameUser(name: user.name ?? '', isLastName: false);
    lastNameTE.text = splitNameUser(name: user.name ?? '', isLastName: true);
    birtTE.text = user.birthday ?? '';
    sex = user.gender ?? 1;
    addressTE.text = user.address ?? ' ';
    heightTE.text = user.height?.toString() ?? '';
    weightTE.text = user.weight?.toString() ?? '';
    // base64Image = await convertImageToBase64(
    //     base64String: box.read(Storages.dataUrlAvatarUser) ?? '');
    base64Image = await convertImageToBase64(base64String: user.avatar ?? '');
    base64ImageConvert = user.avatar ?? '';
    updateUI();
  }

  initData() {
    emailTE = TextEditingController();
    birtTE = TextEditingController();
    addressTE = TextEditingController();
    heightTE = TextEditingController();
    weightTE = TextEditingController();
    firstNameTE = TextEditingController();
    lastNameTE = TextEditingController();
  }

  Future<void> setAvatar() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    try {
      base64ImageConvert = await convertImageToBase64(file: File(image!.path));
      //print('convert image to base64: $base64ImageConvert');
      base64Image =
          await convertImageToBase64(base64String: base64ImageConvert);
      await box.write(Storages.dataUrlAvatarUser, base64ImageConvert);
    } catch (_) {}
    changeUI();
  }

  Future<void> updateUser() async {
    loadingUI();
    await userRepo.updateUser(
        userID: user.id.toString(),
        name: '${firstNameTE.text}@${lastNameTE.text}',
        sex: sex,
        birthday: user.birthday ?? '',
        h: double.parse(heightTE.text),
        w: double.parse(weightTE.text),
        avatar: base64ImageConvert,
        //avatar: 'test',
        address: addressTE.text);
    await userRepo.getUserByID(userID: user.id.toString());
    settingController.base64Image = base64Image;
    settingController.updateUI();
    changeUI();
  }

  String? validateString(String? text) {
    if (text == null || text.isEmpty) {
      return "Trường bắt buộc";
    }
    return null;
  }

  String? numberValidator(String? value) {
    if (value == null || value == '') {
      return null;
    }
    final n = num.tryParse(value);
    if (n == null) {
      return '$value không phải kiểu số';
    }
    return null;
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
