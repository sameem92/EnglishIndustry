import 'package:englishindustry/data/data_api_service.dart';
import 'package:englishindustry/pages/day_page.dart';
import 'package:englishindustry/utility/static_content.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:flutter/material.dart';

class WeeksForChildren extends StatefulWidget {
  final Map<String, dynamic> data;
  final List<dynamic> kidsWeeks;
  final bool isUserHome;
  const WeeksForChildren({
    Key key,
    @required this.data,
    @required this.kidsWeeks,
    @required this.isUserHome,
  }) : super(key: key);

  @override
  State<WeeksForChildren> createState() => _WeeksForChildrenState();
}

class _WeeksForChildrenState extends State<WeeksForChildren> {
  int currentWeekIndex, passedweeks;
  Map<String, dynamic> data;

  List<dynamic> currentWeekDays, kidsWeeks;
  bool isData, canTapDay;
  @override
  void initState() {
    data = widget.data;
    kidsWeeks = widget.kidsWeeks;
    currentWeekIndex = kidsWeeks.length - 1;
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
            ? Wrap(
                spacing: ThemeStyles.setWidth(20),
                runSpacing: ThemeStyles.setHeight(15),
                children: [
                  for (var i = 0; i < kidsWeeks.length; i++)
                    InkWell(
                      onTap: () {
                        setState(() {
                          currentWeekIndex = i;
                          isData = false;
                          AppFuture.checkConnection(context).then((value) {
                            if (value) {
                              AppFuture.getKidsUserHomeData(
                                      context, kidsWeeks[i]["id"].toString())
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
                              AppFuture.customToast(AppLocalizations.of(context)
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
                          kidsWeeks[i]["name"],
                          style: ThemeStyles.regularStyle().copyWith(
                            color: currentWeekIndex == i
                                ? ThemeStyles.white
                                : ThemeStyles.darkred,
                          ),
                        ),
                      ),
                    ),
                ],
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
                    for (var i = 1; i < 6; i++)
                      SizedBox(
                        height: ThemeStyles.setWidth(155),
                        child: InkWell(
                          onTap: () {
                            if (!widget.isUserHome) {
                              AppFuture.goLogin(context);
                            } else {
                              switch (currentWeekDays[i - 1]["active"]) {
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
                                      currentWeekDays[i - 1]["image"],
                                  true),
                              StaticContent.kidDayName(i, ThemeStyles.white),
                              StaticContent.lockIcon(
                                widget.isUserHome
                                    ? currentWeekDays[i - 1]["active"]
                                    : 0,
                              ),
                              StaticContent.dayTitle(
                                  currentWeekDays[i - 1]["description"]),
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
                    color: ThemeStyles.darkred,
                  ),
                ),
              ),
        // ThemeStyles.space(),
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
                AppFuture.getKidsWeekDayData(
                  context,
                  currentWeekDays[i - 1]["id"].toString(),
                ).then((weekDayData) {
                  if (weekDayData != null) {
                    debugPrint(
                      currentWeekDays[i - 1]["id"].toString(),
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Day(
                          dayType: 3,
                          data: weekDayData,
                        ),
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
}
