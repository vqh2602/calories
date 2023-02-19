import 'package:calories/widgets/text_custom.dart';
import 'package:flutter/material.dart';

// khối thông tin tập luyện trong ngày
Widget blockStatisticalToday({Function? onTap}) {
  return InkWell(
    onTap: () {
      onTap != null ? onTap() : null;
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            textLableLarge(text: '10'),
            textBodySmall(text: 'BÀI TẬP')
          ],
        ),
        Column(
          children: [textLableLarge(text: '2000'), textBodySmall(text: 'KCAL')],
        ),
        Column(
          children: [
            textLableLarge(text: '200'),
            textBodySmall(text: 'PHÚT TẬP')
          ],
        ),
      ],
    ),
  );
}
