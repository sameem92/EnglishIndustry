import 'package:englishindustry/data/data_api_service.dart';
import 'package:englishindustry/pages/day_page.dart';
import 'package:englishindustry/pages/exam_day_page.dart';
import 'package:englishindustry/utility/static_content.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Weeks extends StatefulWidget {
  final Map<String, dynamic> data;
  final bool isUserHome;
  final List<dynamic> myWeeks;
  const Weeks({
    Key key,
    @required this.data,
    @required this.myWeeks,
    @required this.isUserHome,
  }) : super(key: key);

  @override
  State<Weeks> createState() => _WeeksState();
}

class _WeeksState extends State<Weeks> {
  Map<String, dynamic> data;
  List<dynamic> currentWeekDays, myWeeks;

  int currentWeekIndex;
  bool isData, canTapDay;

  @override
  void initState() {
    data = widget.data;
    myWeeks = widget.myWeeks;
    currentWeekIndex = myWeeks.length - 1;
    currentWeekDays = data["calendar"];
    isData = true;
    canTapDay = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ThemeStyles.quartSpace(),
        widget.isUserHome
            ? Container(
                margin:
                    EdgeInsets.symmetric(horizontal: ThemeStyles.setWidth(15)),
                child: Wrap(
                  spacing: ThemeStyles.setWidth(10),
                  runSpacing: ThemeStyles.setHeight(10),
                  children: [
                    for (var i = 0; i < myWeeks.length; i++)
                      InkWell(
                        onTap: () {
                          setState(() {
                            currentWeekIndex = i;
                            isData = false;
                            AppFuture.checkConnection(context).then((value) {
                              if (value) {
                                AppFuture.getUserHomeData(
                                        context, myWeeks[i]["id"].toString())
                                    .then((updatedData) {
                                  if (updatedData != null) {
                                    setState(() {
                                      isData = true;
                                      data = updatedData;

                                      currentWeekDays = data["calendar"];
                                    });
                                  }
                                });
                              } else {
                                AppFuture.customToast(
                                    AppLocalizations.of(context)
                                        .translate("checkInternet"));
                              }
                            });
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ThemeStyles.setWidth(25),
                            vertical: ThemeStyles.setWidth(10),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              ThemeStyles.setWidth(30),
                            ),
                            color: currentWeekIndex == i
                                ? ThemeStyles.darkred
                                : ThemeStyles.paleLightRed,
                          ),
                          child: Text(
                            widget.myWeeks[i]["name"],
                            style: ThemeStyles.regularStyle().copyWith(
                              color: currentWeekIndex == i
                                  ? ThemeStyles.white
                                  : ThemeStyles.darkred,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              )
            : const SizedBox(
                height: 0.0,
              ),
        // ThemeStyles.halfSpace(),
        ThemeStyles.quartSpace(),
        isData
            ? Align(
                alignment: Alignment.center,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: ThemeStyles.setWidth(8),
                  runSpacing: ThemeStyles.setHeight(5),
                  children: [
                    for (var i = 0; i < currentWeekDays.length; i++)
                      SizedBox(
                        height: ThemeStyles.setWidth(155),
                        child: i == 0 || i == 4 || i == 5 || i == 6
                            ? InkWell(
                                onTap: () {
                                  if (!widget.isUserHome) {
                                    AppFuture.goLogin(context);
                                  } else {
                                    switch (currentWeekDays[i]["active"]) {
                                      case 0:
                                        AppFuture.customToast(
                                            AppLocalizations.of(context)
                                                .translate("subsLock0"));
                                        break;
                                      case 2:
                                        AppFuture.customToast(
                                            AppLocalizations.of(context)
                                                .translate("waitLock2"));
                                        break;
                                      case 3:
                                        AppFuture.customToast(
                                            AppLocalizations.of(context)
                                                .translate("examLock"));
                                        break;
                                      default:
                                        getDayData(i);
                                        break;
                                    }
                                  }
                                },
                                child: Stack(
                                  children: [
                                    StaticContent.getImgForDay(
                                        "assets/images/day_shape.png", false),
                                    StaticContent.dayName(
                                        currentWeekDays[i][
                                            AppLocalizations.of(context)
                                                .translate("dayName")],
                                        ThemeStyles.darkred),
                                    i != 4&& i != 5 && i != 6? Positioned(
                                      top: ThemeStyles.setHeight(35),
                                      left: 0.0,
                                      right: 0.0,
                                      child: Text(
                                        i != 4? currentWeekDays[i]["title"]:'',
                                        textAlign: TextAlign.center,
                                        style:
                                            ThemeStyles.regularStyle().copyWith(
                                          color: ThemeStyles.white,
                                          fontSize: ThemeStyles.setWidth(11),
                                        ),
                                      ),
                                    ):Column(),
                                    i != 4&& i != 5 && i != 6?  Positioned(
                                      top: ThemeStyles.setHeight(50),
                                      left: 0.0,
                                      right: 0.0,
                                      child: Text(
                                        currentWeekDays[i]["subtitle"],
                                        textAlign: TextAlign.center,
                                        style:
                                            ThemeStyles.regularStyle().copyWith(
                                          color: ThemeStyles.white,
                                          fontSize: ThemeStyles.setWidth(11),
                                        ),
                                      ),
                                    ):Column(),
                                    StaticContent.lockIcon(widget.isUserHome
                                        ? currentWeekDays[i]["active"]
                                        : 0),
                                    i != 4?StaticContent.dayTitle(
                                        currentWeekDays[i]["description"]):Positioned(
                                      top: ThemeStyles.setHeight(107),
                                      right: 0.0,
                                      left: 0.0,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: ThemeStyles.setWidth(35),
                                        ),
                                        height: ThemeStyles.setHeight(130),
                                        child: Text(
                                          AppLocalizations.of(context).translate("exams"),
                                          textAlign: TextAlign.center,
                                          style: ThemeStyles.regularStyle().copyWith(
                                            color: ThemeStyles.red,
                                            fontSize: ThemeStyles.setWidth(11),
                                            // height: 1.2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    i != 4?   Positioned(
                                      right: 0.0,
                                      left: 0.0,
                                      top: ThemeStyles.setHeight( i == 5 || i == 6 ? 40:70),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          i == 0?
                                          Row(
                                            children: const [
                                              Icon(Icons.play_lesson_outlined,color: ThemeStyles.offWhite,),
                                              SizedBox(width: 5,)
                                            ],
                                          ):Column(),

                                          SvgPicture.asset(
                                            "assets/images/review_icon.svg",
                                            color: ThemeStyles.white,
                                            height: ThemeStyles.setWidth(i == 5 || i == 6?35:20),

                                          ),
                                        ],
                                      ),
                                    ):
                                    Positioned(
                                      right: 0.0,
                                      left: 0.0,
                                      top: ThemeStyles.setHeight(40),
                                      child: const Icon(Icons.extension_rounded,color: ThemeStyles.offWhite,size: 40,)
                                    )

                                  ],
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  if (!widget.isUserHome) {
                                    AppFuture.goLogin(context);
                                  } else {
                                    switch (currentWeekDays[i]["active"]) {
                                      case 0:
                                        AppFuture.customToast(
                                            AppLocalizations.of(context)
                                                .translate("subsLock0"));
                                        break;
                                      case 2:
                                        AppFuture.customToast(
                                            AppLocalizations.of(context)
                                                .translate("waitLock2"));
                                        break;
                                      case 3:
                                        AppFuture.customToast(
                                            AppLocalizations.of(context)
                                                .translate("examLock"));
                                        break;
                                      default:
                                        getDayData(i);
                                        break;
                                    }
                                  }
                                },
                                child: Stack(
                                  children: [
                                    StaticContent.getImgForDay(
                                        DataApiService.imagebaseUrl +
                                            currentWeekDays[i]["image"],
                                        true),
                                    StaticContent.dayName(
                                        currentWeekDays[i][
                                            AppLocalizations.of(context)
                                                .translate("dayName")],
                                        ThemeStyles.white),
                                    StaticContent.lockIcon(widget.isUserHome
                                        ? currentWeekDays[i]["active"]
                                        : 0),
                                    StaticContent.dayTitle(
                                        currentWeekDays[i]["description"]),
                                  ],
                                ),
                              ),
                      ),
                  ],
                ),
              )
            : SizedBox(
                height: ThemeStyles.setFullWidth(),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: ThemeStyles.red,
                  ),
                ),
              ),
        ThemeStyles.space(),
        ThemeStyles.space(),
        ThemeStyles.space(),
      ],
    );
  }

  void getDayData(int i) {
    canTapDay
        ? AppFuture.checkConnection(context).then(
            (value) {
              if (value) {
                AppFuture.getWeekDayData(
                  context,
                  currentWeekDays[i]["id"].toString(),
                ).then((weekDayData) {
                  if (weekDayData != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => i == 6 || i == 5
                            ? getDayContent(2, weekDayData, i)
                            : i == 4
                                ? ExamDay(
                                    data: weekDayData,
                                    dayName: currentWeekDays[i][
                                        AppLocalizations.of(context)
                                            .translate("dayName")],
                                    lessonTitle: currentWeekDays[i]
                                        ["description"],
                                    lessonSubtitle: currentWeekDays[i]["title"],
                                    lessonType: currentWeekDays[i]["subtitle"],
                                  )
                                : i == 0
                                    ? getDayContent(0, weekDayData, i)
                                    : getDayContent(1, weekDayData, i),
                      ),
                    );
                  }
                });
              } else {
                AppFuture.customToast(
                    AppLocalizations.of(context).translate("checkInternet"));
              }
            },
          )
        : null;
    setState(() {
      canTapDay = false;
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          canTapDay = true;
        });
      });
    });
  }

  Day getDayContent(int dayType, Map<String, dynamic> data, int index) {
    return Day(
      data: data,
      dayType: dayType,
    );
  }
}
