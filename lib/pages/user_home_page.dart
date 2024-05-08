import 'package:englishindustry/components/account_component.dart';
import 'package:englishindustry/pages/dictionary_page.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/components/user_home_content_component.dart';
import 'package:englishindustry/components/user_home_header_component.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:englishindustry/components/words_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserHome extends StatefulWidget {
  final int strtPageIndex;
  final Map<String, dynamic> userProfileData, userHomeData, kidsHomeData;
  final List<dynamic> myWeeks, kidsMyWeeks;
  final bool isUserHome;

  const UserHome({
    Key key,
    @required this.userProfileData,
    @required this.userHomeData,
    @required this.strtPageIndex,
    @required this.kidsHomeData,
    @required this.myWeeks,
    @required this.kidsMyWeeks,
    @required this.isUserHome,
  }) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final ValueNotifier<int> strtPageIndex = ValueNotifier(0);
  bool canLeavePage;

  @override
  void initState() {
    strtPageIndex.value = widget.strtPageIndex;
    canLeavePage = true;
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<bool> leavePage() async {
    if (canLeavePage) {
      AppFuture.customToast(
        AppLocalizations.of(context).translate("pressToExit"),
      );
    }
    setState(() {
      canLeavePage = !canLeavePage;
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        canLeavePage = true;
      });
    });
    return canLeavePage;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: leavePage,
      child: SafeArea(
        bottom: false,

        child: Scaffold(
          floatingActionButton: strtPageIndex.value != 4
              ? Container(
                  // margin: EdgeInsets.all(ThemeStyles.setWidth(5)),
                  width: ThemeStyles.setWidth(70),
                  height: ThemeStyles.setWidth(70),
                  decoration: ThemeStyles.innerDoubleShadowDecoration(
                      ThemeStyles.setWidth(50), false),
                  child: FloatingActionButton(
                    backgroundColor: ThemeStyles.transparent,
                    elevation: 0.0,
                    onPressed: () {
                      setState(() {
                        strtPageIndex.value = 4;
                      });
                    },
                    child: SvgPicture.asset(
                      "assets/images/dictionary_icon.svg",
                      height: ThemeStyles.setHeight(35),
                    ),
                  ),
                )
              : null,
          backgroundColor: ThemeStyles.offWhite,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ValueListenableBuilder(

                valueListenable: strtPageIndex,
                builder: (BuildContext context, int navIndex, Widget child) {
                  return UserHomeHeader(

                    isUserHome: widget.isUserHome,
                    callback: (int val) {
                      setState(() {
                        strtPageIndex.value = val;
                      });
                    },
                    currentNavIndex: navIndex,
                  );
                },
              ),
              strtPageIndex.value == 0
                  ? UserHomeContent(
                      homeType: 0,
                      data: widget.userHomeData,
                      myWeeks: widget.myWeeks,
                      kidsWeeks: widget.kidsMyWeeks,
                      isUserHome: widget.isUserHome,
                    )
                  : strtPageIndex.value == 1
                      ? UserHomeContent(
                          homeType: 1,
                          data: widget.kidsHomeData,
                          myWeeks: widget.myWeeks,
                          kidsWeeks: widget.kidsMyWeeks,
                          isUserHome: widget.isUserHome,
                        )
                      : strtPageIndex.value == 2
                          ? Words(
                              isUserHome: widget.isUserHome,
                            )
                          : strtPageIndex.value == 3
                              ? Account(
                                  data: widget.userProfileData,
                                )
                              : const Dictionary(),
            ],
          ),
        ),
      ),
    );
  }

  Column micContent(int langindex) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/images/mic_icon.svg",
          width: ThemeStyles.setWidth(50),
          color: langindex == 0 ? ThemeStyles.red : ThemeStyles.green,
        ),
        ThemeStyles.halfSpace(),
        Text(
          langindex == 0 ? "Start English Speach" : "Start Arabic Speach",
          style: ThemeStyles.regularStyle().copyWith(
            color: langindex == 0 ? ThemeStyles.red : ThemeStyles.green,
            fontSize: ThemeStyles.setWidth(12),
          ),
        )
      ],
    );
  }

  Column dictionaryContent(String title, String result) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: ThemeStyles.regularStyle().copyWith(
                color: ThemeStyles.red,
                fontSize: ThemeStyles.setWidth(12),
              ),
            ),
          ],
        ),
        ThemeStyles.halfSpace(),
        ThemeStyles.quartSpace(),
        Container(
          width: ThemeStyles.setFullWidth(),
          height: ThemeStyles.setHeight(150),
          padding: EdgeInsets.all(
            ThemeStyles.setWidth(20),
          ),
          decoration: ThemeStyles.innerDoubleShadowDecoration(
            ThemeStyles.setWidth(20),
            false,
          ),
          child: Center(
            child: Text(
              result,
              style: ThemeStyles.regularStyle().copyWith(
                color: ThemeStyles.red,
                fontSize: ThemeStyles.setWidth(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
