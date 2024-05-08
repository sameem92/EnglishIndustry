import 'package:englishindustry/data/header_interceptor.dart';
import 'package:englishindustry/utility/double_shadow_container.dart';
import 'package:englishindustry/pages/splash_page.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/constants.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:shared_preferences/shared_preferences.dart';

typedef IndexCallback = void Function(int val);

class UserHomeHeader extends StatefulWidget {
  final IndexCallback callback;
  final int currentNavIndex;
  final bool isUserHome;

  const UserHomeHeader(
      {Key key,
      @required this.callback,
      @required this.currentNavIndex,
      @required this.isUserHome})
      : super(key: key);

  @override
  State<UserHomeHeader> createState() => _UserHomeHeaderState();
}

class _UserHomeHeaderState extends State<UserHomeHeader> {
  int currentLangIndex;

  @override
  initState() {
    currentLangIndex = AppConstants.langCode == "en" ? 0 : 1;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int currentNavIndex = 0;
    return Container(

      width: ThemeStyles.setFullWidth(),
      height: ThemeStyles.setHeight(140),
      padding: EdgeInsets.symmetric(
          horizontal: ThemeStyles.setWidth(5),
          vertical: ThemeStyles.setHeight(5)),
      decoration: const BoxDecoration(
        // border: BoxBorder(),

        image: DecorationImage(
          image: AssetImage("assets/images/home_header.png"),
          fit: BoxFit.fill,

        ),

      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: ThemeStyles.setWidth(235),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: ThemeStyles.setHeight(150),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.callback(0);
                                    currentNavIndex = 0;
                                  });
                                },
                                child: headerContainer(
                                    AppLocalizations.of(context)
                                        .translate("home"),
                                    "assets/images/home_icon.png",
                                    0),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.callback(1);
                                    currentNavIndex = 1;
                                  });
                                },
                                child: headerContainer(
                                    AppLocalizations.of(context)
                                        .translate("kids"),
                                    "assets/images/kid_reading_icon.png",
                                    1),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.callback(2);
                                    currentNavIndex = 2;
                                  });
                                },
                                child: headerContainer(
                                    AppLocalizations.of(context)
                                        .translate("words"),
                                    "assets/images/abc_icon.png",
                                    2),
                              ),
                            ],
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            if (!widget.isUserHome) {
                              AppFuture.goLogin(context);
                            } else {
                              setState(() {
                                widget.callback(
                                    widget.currentNavIndex == 4 ? 4 : 3);
                                currentNavIndex =
                                    widget.currentNavIndex == 4 ? 4 : 3;
                              });
                            }
                          },
                          child: widget.currentNavIndex != 4
                              // ? dictionaryContainer(
                              //     AppLocalizations.of(context)
                              //         .translate("dictionary"),
                              //     4)
                              ?accountContainer(
                                  AppLocalizations.of(context)
                                      .translate("account"),
                                  "assets/images/account_icon.png",
                                  3):const SizedBox(),
                        ),
                      ],
                    ),
                  ),

                  // language
                  widget.currentNavIndex != 4
                      ? IntrinsicHeight(
                          child: Container(
                            width: ThemeStyles.setWidth(90),
                            decoration: BoxDecoration(
                              color: ThemeStyles.white,
                              borderRadius: BorderRadius.circular(
                                ThemeStyles.setWidth(20),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      currentLangIndex = 0;
                                      MainProvider.setLocale(
                                        context,
                                        const Locale('en', "US"),
                                      );
                                      HeaderInterceptor.LANG = "en";
                                      setState(() {
                                        AppFuture.getDataForUserHome(
                                            context, currentNavIndex);
                                      });
                                    });
                                  },
                                  child: langContainer(0),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      currentLangIndex = 1;
                                      MainProvider.setLocale(
                                        context,
                                        const Locale('ar', "AE"),
                                      );
                                      HeaderInterceptor.LANG = "ar";
                                      setState(() {
                                        AppFuture.getDataForUserHome(
                                            context, currentNavIndex);
                                      });
                                    });
                                  },
                                  child: langContainer(1),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 0.0,
                        ),
                ],
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.center,
              child: DoubleShadowContainer(
                width: ThemeStyles.setWidth(55),
                height: ThemeStyles.setWidth(55),
                padding: 10,
                shadWidth: 3,
                shadOpacity: 0.2,
                borderRadius: ThemeStyles.setWidth(120),
                child: Image.asset("assets/images/logo.png"),
                borderColor: ThemeStyles.white.withOpacity(0.3),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container langContainer(int langIndex) {
    return Container(
      padding: EdgeInsets.all(ThemeStyles.setWidth(1)),
      decoration: BoxDecoration(
        color: langIndex == currentLangIndex
            ? ThemeStyles.darkred
            : ThemeStyles.white,
        borderRadius: BorderRadius.circular(
          ThemeStyles.setWidth(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            langIndex == 0 ? "ENG" : "ARB",
            style: ThemeStyles.regularStyle().copyWith(
                color: langIndex == currentLangIndex
                    ? ThemeStyles.white
                    : ThemeStyles.darkred,
                fontSize: ThemeStyles.setWidth(10)),
          ),
          ThemeStyles.hSpace(),
          Container(
            width: ThemeStyles.setWidth(30),
            height: ThemeStyles.setHeight(30),

            padding: EdgeInsets.all(ThemeStyles.setWidth(8)),
            decoration: BoxDecoration(
              color: ThemeStyles.white,
              borderRadius: BorderRadius.circular(
                ThemeStyles.setWidth(30),
              ),
            ),
            child: SvgPicture.asset(
              "assets/images/down_arrow.svg",
            ),
          )
        ],
      ),
    );
  }

  Container headerContainer(String title, String svgPath, int tapIndex) {
    return Container(
      height: ThemeStyles.setHeight(30),
      decoration: BoxDecoration(
          color: tapIndex == widget.currentNavIndex
              ? ThemeStyles.offWhite
              : ThemeStyles.transparent,
          borderRadius: BorderRadius.circular(ThemeStyles.setWidth(30))),
      padding: EdgeInsets.symmetric(
        vertical: ThemeStyles.setHeight(5),
        horizontal: ThemeStyles.setWidth(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            svgPath,
            width: ThemeStyles.setWidth(20),
          ),
          ThemeStyles.hSmSpace(),
          Text(
            title,
            style: ThemeStyles.boldStyle().copyWith(
              color: ThemeStyles.darkred,
              fontSize: ThemeStyles.setWidth(12),
            ),
          ),
        ],
      ),
    );
  }

  Container accountContainer(String title, String svgPath, int tapIndex) {
    return Container(
      height: ThemeStyles.setHeight(30),
      width: ThemeStyles.setWidth(110),
      decoration: BoxDecoration(
          color: tapIndex == widget.currentNavIndex
              ? ThemeStyles.offWhite
              : ThemeStyles.transparent,
          borderRadius: BorderRadius.circular(ThemeStyles.setWidth(30))),
      padding: EdgeInsets.symmetric(
        vertical: ThemeStyles.setHeight(5),
        horizontal: ThemeStyles.setWidth(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            svgPath,
            width: ThemeStyles.setWidth(20),
          ),
          ThemeStyles.hSmSpace(),
          Text(
            title,
            style: ThemeStyles.boldStyle().copyWith(
              color: ThemeStyles.darkred,
              fontSize: ThemeStyles.setWidth(12),
            ),
          ),
        ],
      ),
    );
  }

  Container dictionaryContainer(String title, int tapIndex) {
    return Container(
      height: ThemeStyles.setHeight(45),
      width: ThemeStyles.setWidth(110),
      decoration: BoxDecoration(
          color: tapIndex == widget.currentNavIndex
              ? ThemeStyles.offWhite
              : ThemeStyles.transparent,
          borderRadius: BorderRadius.circular(ThemeStyles.setWidth(30))),
      padding: EdgeInsets.symmetric(
        //vertical: ThemeStyles.setHeight(10),
        horizontal: ThemeStyles.setWidth(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: ThemeStyles.regularStyle().copyWith(
              color: ThemeStyles.darkred,
            ),
          ),
        ],
      ),
    );
  }
}
