import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

Widget textDisplayLarge({
  required String text,
  double fontSize = 54,
  Color? color,
  FontStyle? fontStyle,
  FontWeight fontWeight = FontWeight.w500,
  Color? backGroundColor,
}) {
  return Text(
    text,
    style: josefinSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      backGroundColor: backGroundColor,
      fontStyle: fontStyle,
    ),
  );
}

Widget textDisplayMedium({
  required String text,
  double fontSize = 45,
  Color? color,
  FontStyle? fontStyle,
  FontWeight fontWeight = FontWeight.w500,
  Color? backGroundColor,
}) {
  return Text(
    text,
    style: josefinSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      backGroundColor: backGroundColor,
      fontStyle: fontStyle,
    ),
  );
}

Widget textDisplaySmall({
  required String text,
  double fontSize = 36,
  Color? color,
  FontStyle? fontStyle,
  FontWeight fontWeight = FontWeight.w500,
  Color? backGroundColor,
}) {
  return Text(
    text,
    style: josefinSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      backGroundColor: backGroundColor,
      fontStyle: fontStyle,
    ),
  );
}

Widget textHeadlineLarge({
  required String text,
  double fontSize = 32,
  Color? color,
  FontStyle? fontStyle,
  FontWeight fontWeight = FontWeight.normal,
  Color? backGroundColor,
}) {
  return Text(
    text,
    style: josefinSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      backGroundColor: backGroundColor,
      fontStyle: fontStyle,
    ),
  );
}

Widget textHeadlineMedium({
  required String text,
  double fontSize = 28,
  Color? color,
  FontStyle? fontStyle,
  FontWeight fontWeight = FontWeight.normal,
  Color? backGroundColor,
}) {
  return Text(
    text,
    style: josefinSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      backGroundColor: backGroundColor,
      fontStyle: fontStyle,
    ),
  );
}

Widget textHeadlineSmall({
  required String text,
  double fontSize = 24,
  Color? color,
  FontStyle? fontStyle,
  FontWeight fontWeight = FontWeight.normal,
  Color? backGroundColor,
}) {
  return Text(
    text,
    style: josefinSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      backGroundColor: backGroundColor,
      fontStyle: fontStyle,
    ),
  );
}

Widget textTitleLarge({
  required String text,
  double fontSize = 22,
  Color? color,
  FontStyle? fontStyle,
  FontWeight fontWeight = FontWeight.w700,
  Color? backGroundColor,
}) {
  return Text(
    text,
    style: josefinSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      backGroundColor: backGroundColor,
      fontStyle: fontStyle,
    ),
  );
}

Widget textTitleMedium({
  required String text,
  double fontSize = 16,
  Color? color,
  FontStyle? fontStyle,
  FontWeight fontWeight = FontWeight.w700,
  Color? backGroundColor,
}) {
  return Text(
    text,
    style: josefinSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      backGroundColor: backGroundColor,
      fontStyle: fontStyle,
    ),
  );
}

Widget textTitleSmall({
  required String text,
  double fontSize = 14,
  Color? color,
  FontStyle? fontStyle,
  FontWeight fontWeight = FontWeight.w700,
  Color? backGroundColor,
}) {
  return Text(
    text,
    style: josefinSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      backGroundColor: backGroundColor,
      fontStyle: fontStyle,
    ),
  );
}

Widget textLableLarge({
  required String text,
  double fontSize = 21,
  Color? color,
  FontStyle? fontStyle,
  FontWeight fontWeight = FontWeight.w600,
  Color? backGroundColor,
}) {
  return Text(
    text,
    style: josefinSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      backGroundColor: backGroundColor,
      fontStyle: fontStyle,
    ),
  );
}

Widget textLableMedium({
  required String text,
  double fontSize = 18,
  Color? color,
  FontStyle? fontStyle,
  FontWeight fontWeight = FontWeight.w600,
  Color? backGroundColor,
}) {
  return Text(
    text,
    style: josefinSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      backGroundColor: backGroundColor,
      fontStyle: fontStyle,
    ),
  );
}

Widget textLableSmall({
  required String text,
  double fontSize = 15,
  Color? color,
  FontStyle? fontStyle,
  FontWeight fontWeight = FontWeight.w600,
  Color? backGroundColor,
}) {
  return Text(
    text,
    style: josefinSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      backGroundColor: backGroundColor,
      fontStyle: fontStyle,
    ),
  );
}

Widget textBodyLarge({
  required String text,
  double fontSize = 20,
  Color? color,
  FontStyle? fontStyle,
  FontWeight fontWeight = FontWeight.normal,
  Color? backGroundColor,
}) {
  return Text(
    text,
    style: josefinSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      backGroundColor: backGroundColor,
      fontStyle: fontStyle,
    ),
  );
}

Widget textBodyMedium({
  required String text,
  double fontSize = 17.5,
  Color? color,
  FontStyle? fontStyle,
  FontWeight fontWeight = FontWeight.normal,
  Color? backGroundColor,
}) {
  return Text(
    text,
    style: josefinSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      backGroundColor: backGroundColor,
      fontStyle: fontStyle,
    ),
  );
}

Widget textBodySmall({
  required String text,
  double fontSize = 14,
  Color? color,
  FontStyle? fontStyle,
  FontWeight fontWeight = FontWeight.normal,
  Color? backGroundColor,
}) {
  return Text(
    text,
    style: josefinSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      backGroundColor: backGroundColor,
      fontStyle: fontStyle,
    ),
  );
}

TextStyle josefinSans({
  required double fontSize,
  Color? color,
  FontStyle? fontStyle,
  FontWeight? fontWeight,
  Color? backGroundColor,
}) {
  return GoogleFonts.josefinSans(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    backgroundColor: backGroundColor,
    fontStyle: fontStyle,
  );
}
