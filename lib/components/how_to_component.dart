import 'package:englishindustry/data/data_api_service.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/pages/videoplayer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HowTo extends StatelessWidget {
  final String title, svgPath, content, videoUrl;
  final Color bgColor;
  const HowTo({
    Key key,
    @required this.title,
    @required this.svgPath,
    @required this.bgColor,
    @required this.content,
    @required this.videoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: bgColor,
          height: ThemeStyles.setHeight(600),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ThemeStyles.space(),
              // ThemeStyles.space(),
              Text(
                title,
                style: ThemeStyles.boldStyle().copyWith(
                  color: ThemeStyles.red,
                  fontSize: ThemeStyles.setWidth(25),
                ),
              ),
              // ThemeStyles.space(),
              // ThemeStyles.space(),
              SvgPicture.asset(svgPath),
              // ThemeStyles.space(),
              // ThemeStyles.space(),
              Text(
                AppLocalizations.of(context).translate("letsStart"),
                style: ThemeStyles.regularStyle().copyWith(
                  color: ThemeStyles.red,
                  fontSize: ThemeStyles.setWidth(14),
                ),
              ),
              // ThemeStyles.space(),
              // ThemeStyles.space(),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MyVideoPlayer(
                          videoUrl: DataApiService.videobaseUrl + videoUrl,
                          title: title,
                          skipType: 0,

                        ),
                      ),
                    );
                  },
                  child: Image.asset("assets/images/video_player.png")),
              // ThemeStyles.space(),
              // ThemeStyles.space(),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: ThemeStyles.setWidth(20),
                ),
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: ThemeStyles.regularStyle().copyWith(
                      color: ThemeStyles.red,
                      fontSize: ThemeStyles.setWidth(15)),
                ),
              ),
              // ThemeStyles.space(),
              // ThemeStyles.space(),
            ],
          ),
        ),
      ],
    );
  }
}
