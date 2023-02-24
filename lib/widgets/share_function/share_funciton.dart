import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void dateTimePicker({required Function(dynamic) onchange, required Function onComplete}){
  Get.bottomSheet(
      backgroundColor: Colors.white,
      Container(
        height: 200,
        child: CupertinoDatePicker(
            onDateTimeChanged: onchange,
            initialDateTime: DateTime.now(),
            //backgroundColor: Colors.white,
            dateOrder: DatePickerDateOrder.dmy,
            mode: CupertinoDatePickerMode.date),
      )).whenComplete(() => onComplete());
}