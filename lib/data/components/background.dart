//class background {}

import 'package:flutter/material.dart';
import 'package:flutter_group_on/core/config/sized_config.dart';
import 'package:flutter_group_on/core/constants/colors/color_constants.dart';

Decoration backGroundDecoration() {
  return const BoxDecoration(
      gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [
      0.1,
      0.9,
    ],
    colors: [backgroundTopColor, backgroundBottomColor],
  ));
}

ClipOval topLeftClipOval() {
  return ClipOval(
    child: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [
          0.1,
          0.9,
        ],
        colors: [Color(0xffE14141), Color(0xff011AF9)],
      )),
      height: getProportionateScreenHeight(173),
      width: getProportionateScreenWidth(137),
    ),
  );
}

ClipOval bottomRightClipOval() {
  return ClipOval(
    child: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        stops: [
          0.1,
          0.9,
        ],
        colors: [Color(0xff011AF9), Color(0xffE14141)],
      )),
      height: getProportionateScreenHeight(273),
      width: getProportionateScreenWidth(237),
    ),
  );
}
