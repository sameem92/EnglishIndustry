import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/constants.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:englishindustry/pages/videoplayer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import '../data/data_api_service.dart';

class MyFavourites extends StatefulWidget {
  const MyFavourites({Key key}) : super(key: key);

  @override
  State<MyFavourites> createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {
  List<dynamic> myFavs;
  String contentStr;

  @override
  void initState() {
    contentStr = "";
    myFavs = [];
    AppFuture.getMyFavourites(context).then((myFavsList) {
      if (myFavsList != null) {
        setState(() {
          myFavs = myFavsList;

          if (myFavs.isEmpty) {
            contentStr = AppConstants.langCode == "en"
                ? "No Content Available"
                : "لا يوجد محتوى";
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(  bottom: false,
      top: false,
      child: Scaffold(
        backgroundColor: ThemeStyles.offWhite,
        appBar: AppBar(
          backgroundColor: ThemeStyles.offWhite,
          toolbarHeight: ThemeStyles.setHeight(60),
          centerTitle: true,
          elevation: 0.0,
          leadingWidth: ThemeStyles.setWidth(80),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: ThemeStyles.red,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            AppLocalizations.of(context).translate("favVideos"),
            style: ThemeStyles.regularStyle().copyWith(
                color: ThemeStyles.red, fontSize: ThemeStyles.setWidth(18)),
          ),
        ),
        body: SizedBox(
          width: ThemeStyles.setFullWidth(),
          height: ThemeStyles.setFullHeight(),
          child: Column(
            children: [
              ThemeStyles.space(),
              myFavs.isNotEmpty
                  ? Expanded(
                      child: Container(
                        width: ThemeStyles.setFullWidth(),
                        height: ThemeStyles.setFullHeight(),
                        margin: EdgeInsets.symmetric(
                            horizontal: ThemeStyles.setWidth(30)),
                        padding: EdgeInsets.all(
                          ThemeStyles.setWidth(12),
                        ),
                        decoration: BoxDecoration(
                          color: ThemeStyles.lightRed,
                          borderRadius: BorderRadius.circular(
                            ThemeStyles.setWidth(8),
                          ),
                        ),
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            bool imgHasError = false;

                            return FittedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: ThemeStyles.red,
                                        size: ThemeStyles.setWidth(15),
                                      ),
                                      ThemeStyles.hSpace(),
                                      Text(
                                        myFavs[index]["title"],
                                        style: ThemeStyles.boldStyle().copyWith(
                                            color: ThemeStyles.red,
                                            fontSize: ThemeStyles.setWidth(17)),
                                      ),
                                    ],
                                  ),
                                  ThemeStyles.space(),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => MyVideoPlayer(
                                            title: myFavs[index]["title"],
                                            videoUrl:
                                                DataApiService.videobaseUrl +
                                                    myFavs[index]["file"],
                                            skipType: 0,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: ThemeStyles.setFullWidth(),
                                      height: ThemeStyles.setHeight(200),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: ThemeStyles.setWidth(20)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            ThemeStyles.setWidth(20)),
                                        image: !imgHasError
                                            ? DecorationImage(
                                                image: NetworkImage(
                                                    DataApiService
                                                            .imagebaseUrl +
                                                        myFavs[index]["image"]),
                                                onError: (Object e,
                                                    StackTrace stackTrace) {
                                                  setState(() {
                                                    imgHasError = true;
                                                  });
                                                },
                                                fit: BoxFit.cover,
                                              )
                                            : const DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/video_player.png"),
                                                fit: BoxFit.contain,
                                              ),
                                      ),
                                      child: Center(
                                        child: 
                                        
                                        SvgPicture.asset(
                                          "assets/images/day_play_icon.svg",
                                          width: ThemeStyles.setWidth(40),
                                          color: ThemeStyles.white
                                              .withOpacity(0.8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: myFavs.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                ThemeStyles.space(),
                                ThemeStyles.halfSpace(),
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  : Expanded(
                      child: Center(
                      child: Text(
                        contentStr,
                        style: ThemeStyles.regularStyle().copyWith(
                          color: ThemeStyles.red,
                          fontSize: ThemeStyles.setWidth(16),
                        ),
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
