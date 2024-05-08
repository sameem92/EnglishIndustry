import 'package:englishindustry/components/coming_soon_component.dart';
import 'package:englishindustry/data/data_api_service.dart';
import 'package:englishindustry/components/how_to_component.dart';
import 'package:englishindustry/components/story_component.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final Map<String, dynamic> data;
  final List<dynamic> myWeeks, kidsWeeks;
  final int homeType;
  final bool isUserHome;

  const Details({
    Key key,
    @required this.data,
    @required this.myWeeks,
    @required this.kidsWeeks,
    @required this.homeType,
    @required this.isUserHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Story(
          data: data,
        ),
        HowTo(
          title: AppLocalizations.of(context).translate("howToLearn"),
          svgPath: "assets/images/how_to_learn.svg",
          content: data["howtolearn"]["learntext"],
          videoUrl: data["howtolearn"]["learnvideo"],
          bgColor: ThemeStyles.paleLightRed,
        ),
        HowTo(
          title: AppLocalizations.of(context).translate("howToWork"),
          svgPath: "assets/images/how_to_wok.svg",
          content: data["howtowork"]["worktext"],
          videoUrl: data["howtowork"]["workvideo"],
          bgColor: ThemeStyles.offWhite,
        ),
        TrainningPrograms(
          title: AppLocalizations.of(context).translate("abroadStudy"),
          content: data["abroadstudy"],
          bgColor: ThemeStyles.paleLightRed,
        ),
        TrainningPrograms(
          title: AppLocalizations.of(context).translate("eduProgm"),
          content: data["educationalprogram"],
          bgColor: ThemeStyles.offWhite,
        ),
        // ThemeStyles.space(),
        isUserHome
            ? Container(
                padding: EdgeInsets.all(ThemeStyles.setWidth(30)),
                width: ThemeStyles.setFullWidth(),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/footer_bg.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: ThemeStyles.setFullWidth(),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 110.0,
                                  height: 110.0,
                                  decoration: BoxDecoration(
                                    color: ThemeStyles.offWhite,
                                    borderRadius: BorderRadius.circular(
                                        ThemeStyles.setWidth(50)),
                                    image: DecorationImage(
                                      image: data["statistics"]["userimage"] !=
                                              null
                                          ? NetworkImage(
                                              DataApiService.imagebaseUrl +
                                                  data["statistics"]
                                                      ["userimage"],
                                            )
                                          : const AssetImage(
                                              "assets/images/account_img.png"),
                                      fit: data["statistics"]["userimage"] !=
                                              null
                                          ? BoxFit.cover
                                          : BoxFit.contain,
                                    ),
                                  ),
                                ),
                                ThemeStyles.halfSpace(),
                                Text(
                                  data["statistics"]["username"],
                                  textAlign: TextAlign.center,
                                  style: ThemeStyles.regularStyle().copyWith(
                                    color: ThemeStyles.white,
                                    fontSize: ThemeStyles.setWidth(15),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    // ThemeStyles.space(),
                    ThemeStyles.space(),
                    SizedBox(
                      width: ThemeStyles.setFullWidth(),
                      child: Text(
                        AppLocalizations.of(context).translate("stats"),
                        textAlign: TextAlign.center,
                        style: ThemeStyles.boldStyle().copyWith(
                          color: ThemeStyles.white,
                          fontSize: ThemeStyles.setWidth(25),
                        ),
                      ),
                    ),
                    // ThemeStyles.space(),
                    ThemeStyles.space(),
                    footerContent(
                      AppLocalizations.of(context).translate("subsPlan"),
                      data["statistics"]["subscription_plan_id"] == 0
                          ? AppLocalizations.of(context).translate("freePlan")
                          : data["statistics"]["subscription_plan_id"] == 1
                              ? data["subscription_plans"][0]["title"]
                              : data["subscription_plans"][1]["title"],
                    ),
                    ThemeStyles.halfSpace(),
                    footerContent(
                      AppLocalizations.of(context).translate("currWeek"),
                      homeType == 0
                          ? myWeeks[myWeeks.length - 1]["name"]
                          : kidsWeeks[kidsWeeks.length - 1]["name"],
                    ),
                    ThemeStyles.halfSpace(),
                    data["statistics"]["completed_tasks"] != null
                        ? Column(
                            children: [
                              footerContent(
                                  AppLocalizations.of(context)
                                      .translate("taskComp"),
                                  data["statistics"]["completed_tasks"]
                                          .toString() +
                                      AppLocalizations.of(context)
                                          .translate("tasks")),
                              ThemeStyles.halfSpace(),
                              footerContent(
                                  AppLocalizations.of(context)
                                      .translate("examComp"),
                                  data["statistics"]["completed_exams"]
                                          .toString() +
                                      AppLocalizations.of(context)
                                          .translate("exams")),
                              ThemeStyles.halfSpace(),
                              footerContent(
                                  AppLocalizations.of(context)
                                      .translate("examAvgRate"),
                                  data["statistics"]["exam_average_ratio"]
                                          .toString() +
                                      " %"),
                            ],
                          )
                        : const SizedBox(
                            height: 0.0,
                          ),
                    ThemeStyles.space(),
                    ThemeStyles.space(),
                    ThemeStyles.space(),
                    ThemeStyles.space(),
                    ThemeStyles.space(),
                  ],
                ),
              )
            : const SizedBox(
                height: 0.0,
              )
      ],
    );
  }

  Container circleImg(ImageProvider img) {
    return Container(
      width: ThemeStyles.setWidth(80),
      height: ThemeStyles.setHeight(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ThemeStyles.setWidth(70)),
        image: DecorationImage(image: img, fit: BoxFit.cover),
      ),
    );
  }

  Container footerContent(String title, String subTitle) {
    return Container(
      width: ThemeStyles.setFullWidth(),
      padding: EdgeInsets.all(
        ThemeStyles.setWidth(20),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          ThemeStyles.setWidth(15),
        ),
        color: ThemeStyles.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: ThemeStyles.boldStyle().copyWith(
              color: ThemeStyles.red,
              fontSize: ThemeStyles.setWidth(14),
            ),
          ),
          Text(
            subTitle,
            style: ThemeStyles.boldStyle().copyWith(
              color: ThemeStyles.red,
              fontSize: ThemeStyles.setWidth(12),
            ),
          ),
        ],
      ),
    );
  }
}
