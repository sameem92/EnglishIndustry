import 'package:cached_network_image/cached_network_image.dart';
import 'package:englishindustry/utility/day_shape_clipper.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class StaticContent {
  static String getDayName(int dayIndex) {
    switch (dayIndex) {
      case 0:
        return AppConstants.langCode == "en" ? "Saturday" : "السبت";
        break;
      case 1:
        return AppConstants.langCode == "en" ? "Sunday" : "الأحد";
        break;
      case 2:
        return AppConstants.langCode == "en" ? "MonDay" : "الإثنين";
        break;
      case 3:
        return AppConstants.langCode == "en" ? "Tuesday" : "الثلاثاء";
        break;
      case 4:
        return AppConstants.langCode == "en" ? "Wednesday" : "الأربعاء";
        break;
      case 5:
        return AppConstants.langCode == "en" ? "Thursday" : "الخميس";
        break;
      case 6:
        return AppConstants.langCode == "en" ? "Friday" : "الجمعة";
        break;
      default:
        return "Friday";
        break;
    }
  }

  static Positioned dayName(String dayname, Color fontClr) {
    return Positioned(
      top: ThemeStyles.setWidth(12),
      left: 0.0,
      right: 0.0,
      child: Text(
        dayname,
        textAlign: TextAlign.center,
        style: ThemeStyles.boldStyle().copyWith(
          color: fontClr,
          fontSize: ThemeStyles.setWidth(
            13,
          ),
        ),
      ),
    );
  }

  static Positioned kidDayName(int index, Color fontClr) {
    return Positioned(
      top: ThemeStyles.setWidth(12),
      left: 0.0,
      right: 0.0,
      child: Text(
        getDayName(index),
        textAlign: TextAlign.center,
        style: ThemeStyles.boldStyle().copyWith(
          color: fontClr,
          fontSize: ThemeStyles.setWidth(
            13,
          ),
        ),
      ),
    );
  }

  static Positioned dayTitle(String title) {
    return Positioned(
      top: ThemeStyles.setHeight(107),
      right: 0.0,
      left: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ThemeStyles.setWidth(35),
        ),
        height: ThemeStyles.setHeight(130),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: ThemeStyles.regularStyle().copyWith(
            color: ThemeStyles.red,
            fontSize: ThemeStyles.setWidth(11),
            // height: 1.2,
          ),
        ),
      ),
    );
  }

  static Positioned lockIcon(int icontype) {
    return Positioned(
      top: ThemeStyles.setWidth(30),
      right: 0.0,
      child: SvgPicture.asset(
        icontype == 0
            ? "assets/images/locked_icon.svg"
            : icontype == 1
                ? "assets/images/done_lock_icon.svg"
                : icontype == 2
                    ? "assets/images/wait_lock_icon.svg"
                    : "assets/images/exam_lock_icon.svg",
        height: ThemeStyles.setHeight(20),
      ),
    );
  }

  static Positioned getImgForDay(String imgPath, bool isNetwork) {
    return Positioned(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ThemeStyles.setWidth(10),
          vertical: ThemeStyles.setHeight(5),
        ),
        width: ThemeStyles.setWidth(155),
        height: ThemeStyles.setHeight(125),
        child: ClipPath(
          child: !isNetwork
              ? Image.asset(
                  imgPath,
                  fit: BoxFit.cover,
                )
              :
          // Image.network(
          //         imgPath,
          //
          //         errorBuilder: (_, __, ___) {
          //           return Container(
          //             width: ThemeStyles.setWidth(130),
          //             height: ThemeStyles.setWidth(130),
          //             padding: EdgeInsets.all(ThemeStyles.setWidth(20)),
          //             decoration: BoxDecoration(
          //                 border: Border.all(color: ThemeStyles.offWhite),
          //                 color: ThemeStyles.white,
          //                 borderRadius:
          //                     BorderRadius.circular(ThemeStyles.setWidth(80))),
          //             child: Center(
          //               child: Image.asset(
          //                 "assets/images/day_shape.png",
          //                 height: ThemeStyles.setHeight(80),
          //               ),
          //             ),
          //           );
          //         },
          //         fit: BoxFit.cover,
          //       ),
          CachedNetworkImage(
            key: UniqueKey(),
            imageUrl: imgPath,
            fadeInCurve: Curves.easeIn,
            width: ThemeStyles.setWidth(130),
            height:ThemeStyles.setWidth(130),
            fadeInDuration: const Duration(microseconds: 1),
            filterQuality: FilterQuality.low,
            maxHeightDiskCache: 400,
            maxWidthDiskCache: 400,
            fit: BoxFit.fill,
            placeholder: (BuildContext context, String url) => Image.asset(
              "assets/images/day_shape.png",
              fit: BoxFit.fill,
              cacheHeight: 1,
              color: Colors.transparent,
              cacheWidth: 1,
              width: ThemeStyles.setWidth(130),
              height: ThemeStyles.setWidth(130),
            ),
            errorWidget: (BuildContext context, String url, error) {
              return Image.asset(
                "assets/images/day_shape.png",
                fit: BoxFit.fill,
                cacheHeight: 1,
                cacheWidth: 1,
                width:ThemeStyles.setWidth(130),
                height: ThemeStyles.setWidth(130),
                color: Colors.transparent,
              );
            },
          ),

          clipper: DayShapClipper(),
        ),
      ),
    );
  }

  static Container changPlan(String title, Color bgColor, int planPrice) {
    return Container(
      width: ThemeStyles.setWidth(180),
      padding: EdgeInsets.symmetric(
        horizontal: ThemeStyles.setWidth(25),
        vertical: ThemeStyles.setWidth(2),
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(
          ThemeStyles.setWidth(30),
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: ThemeStyles.boldStyle().copyWith(
              color: ThemeStyles.white,
            ),
          ),
          Text(
            planPrice.toString() + " " + "SAR",
            textAlign: TextAlign.center,
            style: ThemeStyles.regularStyle().copyWith(
              color: ThemeStyles.white,
            ),
          ),
        ],
      ),
    );
  }
}
