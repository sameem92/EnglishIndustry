import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

abstract class ThemeStyles {
  //sizes
  static double sizeWidth = ScreenUtil().setWidth(360);
  static double sizeHeight = ScreenUtil().setHeight(690);
  static double setWidth(int i) {
    return ScreenUtil().setWidth(i);
  }

  static double setHeight(int i) {
    return ScreenUtil().setHeight(i);
  }

  static double setFullWidth() {
    return ScreenUtil().setWidth(360);
  }

  static double setFullHeight() {
    return ScreenUtil().setHeight(690);
  }

  static SizedBox space() {
    return SizedBox(
      height: ThemeStyles.setHeight(20),
    );
  }

  static SizedBox halfSpace() {
    return SizedBox(
      height: ThemeStyles.setHeight(10),
    );
  }

  static SizedBox quartSpace() {
    return SizedBox(
      height: ThemeStyles.setHeight(5),
    );
  }

  static SizedBox hSpace() {
    return SizedBox(
      width: ThemeStyles.setWidth(8),
    );
  }

  static SizedBox hSmSpace() {
    return SizedBox(
      width: ThemeStyles.setWidth(4),
    );
  }

  //colors
  static const darkred = Color(0xFF9b0046);
  static const red = Color(0xFFc1446e);
  static const greyred = Color(0xFFc3698a);
  static const lightRed = Color(0xFFd3a9be);
  static const paleLightRed = Color(0xFFefd7df);
  static const lightGrey = Color(0xFFC8C7C7);
  static const offWhite = Color(0xFFeaeff2);
  static const white = Color(0xFFFFFFFF);
  static const grey = Color(0xFF6c6c6e);
  static const black = Color(0xFF2D091D);
  static const green = Color.fromARGB(255, 53, 207, 68);
  static const error = Color.fromARGB(255, 255, 44, 48);

  static const transparent = Color(0x002D091D);

  //styles
  static TextStyle boldStyle() {
    return const TextStyle(
      fontFamily: "Product",
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle regularStyle() {
    return const TextStyle(
      fontFamily: "Product",
      fontWeight: FontWeight.w400,
    );
  }

  static BoxDecoration doubleShadowDecoration(
      int shadWidth, double shadOpacity, double borderRadius) {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          blurRadius: ThemeStyles.setWidth(shadWidth),
          color: ThemeStyles.lightRed.withOpacity(shadOpacity),
          offset: Offset(
            ThemeStyles.setWidth((shadWidth / 2).round()),
            ThemeStyles.setWidth((shadWidth / 2).round()),
          ),
        ),
        BoxShadow(
          blurRadius: ThemeStyles.setWidth(shadWidth),
          color: ThemeStyles.white,
          offset: Offset(
            -ThemeStyles.setWidth((shadWidth / 2).round()),
            -ThemeStyles.setWidth((shadWidth / 2).round()),
          ),
        )
      ],
      color: ThemeStyles.offWhite,
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  static BoxDecoration innerDoubleShadowDecoration(
      double borderRadius, bool isTapped) {
    return BoxDecoration(
      color: ThemeStyles.offWhite,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
          color: isTapped ? ThemeStyles.lightGrey : ThemeStyles.transparent),
      boxShadow: isTapped
          ? []
          : [
              BoxShadow(
                offset:
                    Offset(-ThemeStyles.setWidth(8), -ThemeStyles.setWidth(8)),
                blurRadius: ThemeStyles.setWidth(12),
                color: Colors.white.withOpacity(.7),
                inset: true,
              ),
              BoxShadow(
                offset:
                    Offset(ThemeStyles.setWidth(8), ThemeStyles.setWidth(8)),
                blurRadius: ThemeStyles.setWidth(12),
                color: ThemeStyles.lightRed.withOpacity(0.4),
                inset: true,
              ),
            ],
    );
  }

  static BoxDecoration innerShadowDecoration(
      double borderRadius, bool isTapped) {
    return BoxDecoration(
      color: ThemeStyles.offWhite,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
          color: isTapped ? ThemeStyles.lightGrey : ThemeStyles.transparent),
      boxShadow: isTapped
          ? []
          : [
              BoxShadow(
                blurRadius: ThemeStyles.setWidth(12),
                color: ThemeStyles.lightRed.withOpacity(0.5),
                inset: true,
              ),
            ],
    );
  }
}
