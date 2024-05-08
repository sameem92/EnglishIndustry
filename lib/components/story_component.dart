import 'package:cached_network_image/cached_network_image.dart';
import 'package:englishindustry/utility/double_shadow_container.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:flutter/material.dart';

import '../data/data_api_service.dart';

class Story extends StatelessWidget {
  final Map<String, dynamic> data;
  const Story({Key key,@required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).translate("story"),
                  style: ThemeStyles.boldStyle().copyWith(
                    color: ThemeStyles.red,
                    fontSize: ThemeStyles.setWidth(30),
                  ),
                ),
                ThemeStyles.quartSpace(),
                Text(
                  AppLocalizations.of(context).translate("letsStart"),
                  style: ThemeStyles.regularStyle().copyWith(
                    color: ThemeStyles.red,
                    fontSize: ThemeStyles.setWidth(14),
                  ),
                )
              ],
            ),
            ThemeStyles.hSpace(),
            DoubleShadowContainer(
              width: ThemeStyles.setWidth(65),
              height: ThemeStyles.setWidth(65),
              padding: 15,
              shadWidth: 12,
              shadOpacity: 0.3,
              borderRadius: ThemeStyles.setWidth(120),
              child: Image.asset("assets/images/logo.png"),
              borderColor: ThemeStyles.white.withOpacity(0.5),
            ),
          ],
        ),
        ThemeStyles.space(),
        // ThemeStyles.space(),

        CachedNetworkImage(
          key: UniqueKey(),
          imageUrl: DataApiService.imagebaseUrl + data["story"]["storytopimage"],
          fadeInCurve: Curves.easeIn,
          width: ThemeStyles.setWidth(250),
          height:ThemeStyles.setHeight(250),
          fadeInDuration: const Duration(microseconds: 1),
          filterQuality: FilterQuality.low,
          maxHeightDiskCache: 800,
          maxWidthDiskCache: 800,
          fit: BoxFit.fill,
          placeholder: (BuildContext context, String url) => Image.asset(
            "assets/images/day_shape.png",
            fit: BoxFit.fill,
            cacheHeight: 1,
            color: Colors.transparent,
            cacheWidth: 1,
            width:ThemeStyles.setWidth(250),
            height: ThemeStyles.setHeight(250),
          ),
          errorWidget: (BuildContext context, String url, error) {
            return Image.asset(
              "assets/images/day_shape.png",
              fit: BoxFit.fill,
              cacheHeight: 1,
              cacheWidth: 1,
              width:ThemeStyles.setWidth(250),
              height: ThemeStyles.setHeight(250),
              color: Colors.transparent,
            );
          },
        ),
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: ThemeStyles.setWidth(20)),
        //   width: ThemeStyles.setWidth(250),
        //   height: ThemeStyles.setHeight(250),
        //   decoration:  BoxDecoration(
        //     image: DecorationImage(
        //       image: NetworkImage(DataApiService.imagebaseUrl + data["story"]["storytopimage"]),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   //child: Image.asset("images/story_image.png"),
        // ),
        // ThemeStyles.space(),
        ThemeStyles.space(),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: ThemeStyles.setWidth(20),
          ),
          child: Text(
            data["story"]["topstorytext"],
            textAlign: TextAlign.center,
            style: ThemeStyles.regularStyle().copyWith(
                color: ThemeStyles.red, fontSize: ThemeStyles.setWidth(15)),
          ),
        ),
        // ThemeStyles.space(),
        ThemeStyles.space(),
        CachedNetworkImage(
          key: UniqueKey(),
          imageUrl: DataApiService.imagebaseUrl + data["story"]["storyimage"],
          fadeInCurve: Curves.easeIn,
          width: ThemeStyles.setWidth(250),
          height:ThemeStyles.setHeight(250),
          fadeInDuration: const Duration(microseconds: 1),
          filterQuality: FilterQuality.low,
          maxHeightDiskCache: 800,
          maxWidthDiskCache: 800,
          fit: BoxFit.fill,
          placeholder: (BuildContext context, String url) => Image.asset(
            "assets/images/day_shape.png",
            fit: BoxFit.fill,
            cacheHeight: 1,
            color: Colors.transparent,
            cacheWidth: 1,
            width:ThemeStyles.setWidth(250),
            height: ThemeStyles.setHeight(250),
          ),
          errorWidget: (BuildContext context, String url, error) {
            return Image.asset(
              "assets/images/day_shape.png",
              fit: BoxFit.fill,
              cacheHeight: 1,
              cacheWidth: 1,
              width:ThemeStyles.setWidth(250),
              height: ThemeStyles.setHeight(250),
              color: Colors.transparent,
            );
          },
        ),
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: ThemeStyles.setWidth(20)),
        //   width: ThemeStyles.setWidth(250),
        //   height: ThemeStyles.setHeight(250),
        //   decoration:  BoxDecoration(
        //     image: DecorationImage(
        //       image: NetworkImage(DataApiService.imagebaseUrl + data["story"]["storyimage"]),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   //child: Image.asset("images/story_image.png"),
        // ),
        // ThemeStyles.space(),
        ThemeStyles.space(),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: ThemeStyles.setWidth(20),
          ),
          child: Text(
            data["story"]["storytext"],
            textAlign: TextAlign.center,
            style: ThemeStyles.regularStyle().copyWith(
                color: ThemeStyles.red, fontSize: ThemeStyles.setWidth(15)),
          ),
        ),
        // ThemeStyles.space(),
        ThemeStyles.space(),
      ],
    );
  }
}
