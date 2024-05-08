import 'package:englishindustry/utility/double_shadow_container.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final double score;
  const Result({Key key, @required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ThemeStyles.setWidth(20)),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context).translate("examfinished"),
            style: ThemeStyles.regularStyle().copyWith(
              color: ThemeStyles.lightRed,
              fontSize: ThemeStyles.setWidth(18),
            ),
          ),
          ThemeStyles.halfSpace(),
          Text(
            score >= 50 ? "Congraturations".toUpperCase() : "Failed",
            style: ThemeStyles.boldStyle().copyWith(
              color: ThemeStyles.black,
              fontSize: ThemeStyles.setWidth(20),
            ),
          ),
          ThemeStyles.halfSpace(),
          Image.asset(
            score > 50.0 ? "assets/images/success_img.png" : "assets/images/failed_img.png",
            height: ThemeStyles.setWidth(150),
          ),
          ThemeStyles.halfSpace(),
          Text(
            score >= 50
                ? AppLocalizations.of(context).translate("passExamRate")
                : AppLocalizations.of(context).translate("failExamRate"),
            textAlign: TextAlign.center,
            style: ThemeStyles.boldStyle().copyWith(
              color: ThemeStyles.red,
              fontSize: ThemeStyles.setWidth(12),
            ),
          ),
          ThemeStyles.halfSpace(),
          Text(
            "${score.round().toString()} %",
            style: ThemeStyles.boldStyle().copyWith(
              color: score >= 50 ? ThemeStyles.green : ThemeStyles.error,
              fontSize: ThemeStyles.setWidth(40),
            ),
          ),
          ThemeStyles.halfSpace(),
          Container(
            padding: EdgeInsets.all(ThemeStyles.setWidth(20)),
            decoration: ThemeStyles.innerShadowDecoration(
                ThemeStyles.setWidth(30), false),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: score >= 50
                      ? AppLocalizations.of(context).translate("weekIs") + "   "
                      : AppLocalizations.of(context).translate("weekStill") +
                          "   ",
                  style: ThemeStyles.boldStyle().copyWith(
                    color: ThemeStyles.red,
                    fontSize: ThemeStyles.setWidth(15),
                  ),
                ),
                TextSpan(
                  text: score >= 50
                      ? AppLocalizations.of(context).translate("unlocked")
                      : AppLocalizations.of(context).translate("locked"),
                  style: ThemeStyles.boldStyle().copyWith(
                    color: score >= 50 ? ThemeStyles.green : ThemeStyles.error,
                    fontSize: ThemeStyles.setWidth(18),
                  ),
                )
              ]),
            ),
          ),
          // ThemeStyles.space(),
          ThemeStyles.space(),
          Text(
            score >= 50
                ? AppLocalizations.of(context).translate("goodJob")
                : AppLocalizations.of(context).translate("PlzTry"),
            style: ThemeStyles.boldStyle().copyWith(
                color: ThemeStyles.red,
                fontSize: ThemeStyles.setWidth(14),
                fontStyle: FontStyle.italic),
          ),

          ThemeStyles.space(),
          ThemeStyles.space(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DoubleShadowContainer(
                width: ThemeStyles.setWidth(70),
                height: ThemeStyles.setWidth(70),
                padding: 12,
                shadWidth: 15,
                shadOpacity: 0.3,
                borderRadius: ThemeStyles.setWidth(120),
                child: Image.asset("assets/images/logo.png"),
                borderColor: ThemeStyles.white.withOpacity(0.5),
              ),
              ThemeStyles.hSpace(),
              ThemeStyles.hSpace(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ENGLISH",
                    style: ThemeStyles.boldStyle().copyWith(
                      color: ThemeStyles.red,
                      fontSize: ThemeStyles.setWidth(18),
                      letterSpacing: 2.0,
                    ),
                  ),
                  Text(
                    "INDUSTRY",
                    style: ThemeStyles.regularStyle().copyWith(
                      color: ThemeStyles.red,
                      fontSize: ThemeStyles.setWidth(18),
                      letterSpacing: 1.1,
                    ),
                  ),
                  ThemeStyles.quartSpace(),
                  Text(
                    AppLocalizations.of(context).translate("grow"),
                    style: ThemeStyles.regularStyle().copyWith(
                      //letterSpacing: -0.3,
                      color: ThemeStyles.black,
                      fontSize: ThemeStyles.setWidth(10),
                    ),
                  ),
                ],
              )
            ],
          ),
          ThemeStyles.space(),
          ThemeStyles.space(),
        ],
      ),
    );
  }
}
