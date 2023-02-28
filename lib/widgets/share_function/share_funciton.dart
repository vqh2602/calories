import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

void dateTimePicker(
    {required Function(dynamic) onchange, required Function onComplete}) {
  Get.bottomSheet(
      backgroundColor: Get.theme.colorScheme.background,
      Container(
        height: 200,
        padding: EdgeInsets.zero,
        child: CupertinoDatePicker(
            onDateTimeChanged: onchange,
            initialDateTime: DateTime.now(),
            //backgroundColor: Colors.white,
            dateOrder: DatePickerDateOrder.dmy,
            mode: CupertinoDatePickerMode.date),
      )).whenComplete(() => onComplete());
}

enum TypeToast { success, failure, transparent, custom }

void buildToast(
    {required TypeToast type,
    required String title,
    String? message,
    SnackPosition snackPosition = SnackPosition.TOP,
    Function? snackBarCustom}) {
  switch (type) {
    case TypeToast.success:
      Get.snackbar(title, message ?? '',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(microseconds: 1500),
          snackPosition: snackPosition);
      break;
    case TypeToast.failure:
      Get.snackbar(title, message ?? '',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(microseconds: 1500),
          snackPosition: snackPosition);
      break;
    case TypeToast.transparent:
      Get.snackbar(title, message ?? '',
          duration: const Duration(microseconds: 1500),
          snackPosition: snackPosition);
      break;
    case TypeToast.custom:
      if (snackBarCustom != null) snackBarCustom();
      break;
  }
}

enum TypeDate { ddMMyyyy, ddMMyyyyhhmm, hhmm, dd, yyyy, mM }

String formatDate({required TypeDate type, required DateTime dateTime}) {
  switch (type) {
    case TypeDate.ddMMyyyy:
      return DateFormat('dd-MM-yyyy').format(dateTime);
    case TypeDate.ddMMyyyyhhmm:
      return DateFormat('dd-MM-yyyy hh:mm').format(dateTime);
    case TypeDate.hhmm:
      return DateFormat('hh:mm').format(dateTime);
    case TypeDate.dd:
      return dateTime.day.toString();
    case TypeDate.yyyy:
      return dateTime.year.toString();
    case TypeDate.mM:
      return dateTime.month.toString();
  }
}
