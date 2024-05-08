import 'package:englishindustry/pages/comments_page.dart';
import 'package:englishindustry/data/data_api_service.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/pages/videoplayer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:favorite_button/favorite_button.dart';

class Video extends StatefulWidget {
  final String dayName;
  final Map<String, dynamic> lesson;
  const Video({Key key, @required this.dayName, @required this.lesson})
      : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int currentUserRateIndex, lessonRate;
  Map<String, dynamic> lesson;
  List<dynamic> allComments;

  bool isLiked, isFavourite;

  String comment, likes;
  @override
  void initState() {
    lesson = widget.lesson;
    allComments = lesson["allcomments"];

    isLiked = lesson["liked"] != 0;
    isFavourite = lesson["favourited"] != 0;

    lessonRate = double.parse(lesson["rate"].toString()).round();
    currentUserRateIndex = -1;
    debugPrint(currentUserRateIndex.toString());
    super.initState();
  }

  void validateAndSave(BuildContext context) {
    final FormState form = _formKey.currentState;
    _formKey.currentState.save();

    if (form.validate()) {
      debugPrint(comment);
      AppFuture.checkConnection(context).then((value) {
        if (value) {
          AppFuture.addComment(context, widget.lesson["id"].toString(), comment)
              .then((value) {
            if (value != null) {
              AppFuture.customToast(value);
              AppFuture.getAllComments(context, widget.lesson["id"].toString())
                  .then((value) {
                if (value != null) {
                  setState(() {
                    allComments = value;
                  });
                }
              });
            }
          });
        } else {
          AppFuture.customToast(
              AppLocalizations.of(context).translate("checkInternet"));
        }
      });
      _formKey.currentState?.reset();
    } else {}
  }

  String getLikesCount() {
    String likes = AppLocalizations.of(context).translate("likes");
    if (lesson["liked"] == 1 && !isLiked) {
      return (lesson["likes"] - 1).toString() + " " + likes;
    } else if (lesson["liked"] == 0 && isLiked) {
      return (lesson["likes"] + 1).toString() + " " + likes;
    } else {
      return (lesson["likes"]).toString() + " " + likes;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ThemeStyles.setWidth(20),
      ),
      child: Column(
        children: [
          // Container(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: ThemeStyles.setWidth(15),
          //     vertical: ThemeStyles.setHeight(12),
          //   ),
          //   width: ThemeStyles.setFullWidth(),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(
          //       ThemeStyles.setWidth(30),
          //     ),
          //     color: ThemeStyles.red,
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       // Text(
          //       //   lesson["title"],
          //       //   style: ThemeStyles.boldStyle().copyWith(
          //       //     color: ThemeStyles.white,
          //       //   ),
          //       // ),
          //       Row(
          //         children: [
          //           for (var i = 0; i < 5; i++)
          //             SvgPicture.asset(
          //               "assets/images/rate_icon.svg",
          //               color: i < lessonRate
          //                   ? ThemeStyles.white
          //                   : ThemeStyles.black,
          //             ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ThemeStyles.setWidth(12),
              vertical: ThemeStyles.setHeight(12),
            ),
            width: ThemeStyles.setFullWidth(),
            decoration: BoxDecoration(
              border: Border.all(
                color: ThemeStyles.white,
                width: ThemeStyles.setWidth(2),
              ),
              borderRadius: BorderRadius.circular(
                ThemeStyles.setWidth(15),
              ),
              color: ThemeStyles.paleLightRed,
            ),
            child: Row(
              children: [
                Text(
                  lesson["description"],
                  style: ThemeStyles.regularStyle().copyWith(
                      color: ThemeStyles.red,
                      fontSize: ThemeStyles.setWidth(13)),
                ),
                const Spacer(),
                for (var i = 0; i < 5; i++)
                  SvgPicture.asset(
                    "assets/images/rate_icon.svg",
                    color:
                        i < lessonRate ? ThemeStyles.red : ThemeStyles.offWhite,
                  ),
              ],
            ),
          ),
          ThemeStyles.halfSpace(),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyVideoPlayer(
                    title: lesson["description"],
                    videoUrl: DataApiService.videobaseUrl + lesson["file"],
                    skipType: 0,
                  ),
                ),
              );
            },
            child: Container(
              width: ThemeStyles.setFullWidth(),
              height: ThemeStyles.setHeight(150),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ThemeStyles.setWidth(20)),
                  image: const DecorationImage(
                      image: AssetImage("assets/images/video_player.png"),
                      fit: BoxFit.cover)),
            ),
          ),
          ThemeStyles.halfSpace(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ThemeStyles.setWidth(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          AppFuture.checkConnection(context).then((value) {
                            if (value) {
                              AppFuture.likeVideo(
                                      context, widget.lesson["id"].toString())
                                  .then((value) {
                                if (value != null) {
                                  AppFuture.customToast(value["message"]);
                                  setState(() {
                                    isLiked = value["liked"] == 1;
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
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            isLiked
                                ? "assets/images/like_icon.svg"
                                : "assets/images/like_outline_icon.svg",
                            height: ThemeStyles.setHeight(20),
                            color: ThemeStyles.red,
                          ),
                          ThemeStyles.hSmSpace(),
                          Text(
                            AppLocalizations.of(context)
                                .translate(isLiked ? "liked" : "like"),
                            style: ThemeStyles.regularStyle().copyWith(
                                color: isLiked
                                    ? ThemeStyles.red
                                    : ThemeStyles.grey,
                                fontSize: ThemeStyles.setWidth(12)),
                          ),
                        ],
                      ),
                    ),
                    ThemeStyles.hSpace(),
                    Row(
                      children: [
                        FavoriteButton(
                          iconSize: ThemeStyles.setHeight(33),
                          iconColor: ThemeStyles.red,
                          isFavorite: isFavourite,
                          valueChanged: (value) {
                            setState(() {
                              AppFuture.checkConnection(context).then((value) {
                                if (value) {
                                  AppFuture.addFavourite(
                                    context,
                                    widget.lesson["id"].toString(),
                                  ).then(
                                    (value) {
                                      if (value != null) {
                                        AppFuture.customToast(value["message"]);
                                        setState(() {
                                          isFavourite = value["fav"] == 1;
                                        });
                                      }
                                    },
                                  );
                                } else {
                                  AppFuture.customToast(
                                      AppLocalizations.of(context)
                                          .translate("checkInternet"));
                                }
                              });
                            });
                          },
                        ),
                        ThemeStyles.hSmSpace(),
                        Text(
                          isFavourite
                              ? AppLocalizations.of(context)
                                  .translate("addedFav")
                              : AppLocalizations.of(context)
                                  .translate("addFav"),
                          style: ThemeStyles.regularStyle().copyWith(
                            color: isFavourite
                                ? ThemeStyles.red
                                : ThemeStyles.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  getLikesCount(),
                  style: ThemeStyles.boldStyle().copyWith(
                      color: ThemeStyles.grey,
                      fontSize: ThemeStyles.setWidth(12)),
                )
              ],
            ),
          ),
          ThemeStyles.space(),
          // Add comment
          Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.account_circle,
                          color: ThemeStyles.lightGrey,
                          size: ThemeStyles.setWidth(40),
                        ),
                        ThemeStyles.hSmSpace(),
                        Text(
                          AppLocalizations.of(context).translate("addComment"),
                          style: ThemeStyles.regularStyle().copyWith(
                            color: ThemeStyles.grey,
                            fontSize: ThemeStyles.setWidth(12),
                          ),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AllComments(
                              allComments: allComments,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate("viewComments"),
                          style: ThemeStyles.regularStyle().copyWith(
                            color: ThemeStyles.red,
                            fontSize: ThemeStyles.setWidth(10),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ThemeStyles.quartSpace(),
                TextFormField(
                  cursorColor: ThemeStyles.red,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  style: ThemeStyles.regularStyle().copyWith(
                    color: ThemeStyles.red,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  validator: (value) {
                    return value.isEmpty
                        ? AppLocalizations.of(context)
                            .translate("PlzAddComment")
                        : null;
                  },
                  onSaved: (value) {
                    setState(() {
                      comment = value;
                    });
                  },
                  // onTap: (){
                  //   if(comment!=null &&comment!='') {
                  //     AppFuture.customToast(
                  //       AppLocalizations.of(context)
                  //           .translate("thankYouForYourComment"));
                  //   }
                  // },
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.center,
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: ThemeStyles.grey, width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: ThemeStyles.red, width: .5),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(ThemeStyles.setWidth(5)),
                      borderSide:
                          const BorderSide(color: ThemeStyles.grey, width: 0.5),
                    ),
                    contentPadding: EdgeInsets.all(ThemeStyles.setWidth(0)),
                    filled: false,
                  ),
                ),
                ThemeStyles.halfSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        // add comment
                        validateAndSave(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ThemeStyles.setWidth(20),
                          vertical: ThemeStyles.setHeight(10),
                        ),
                        decoration: BoxDecoration(
                          color: ThemeStyles.red,
                          borderRadius: BorderRadius.circular(
                            ThemeStyles.setWidth(20),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context).translate("addComment"),
                          style: ThemeStyles.regularStyle().copyWith(
                            color: ThemeStyles.white,
                            fontSize: ThemeStyles.setWidth(10),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          // ThemeStyles.space(),
          // ThemeStyles.space(),

          // Rate
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ThemeStyles.lightGrey,
                        width: ThemeStyles.setWidth(2),
                      ),
                      borderRadius: BorderRadius.circular(
                        ThemeStyles.setWidth(30),
                      ),
                    ),
                    child: Icon(
                      Icons.star,
                      color: ThemeStyles.lightGrey,
                      size: ThemeStyles.setWidth(30),
                    ),
                  ),
                  ThemeStyles.hSmSpace(),
                  Text(
                    AppLocalizations.of(context).translate("rate"),
                    style: ThemeStyles.regularStyle().copyWith(
                      color: ThemeStyles.grey,
                      fontSize: ThemeStyles.setWidth(12),
                    ),
                  )
                ],
              ),
              // ThemeStyles.halfSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      for (var i = 0; i < 5; i++)
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  currentUserRateIndex = i;
                                  AppFuture.checkConnection(context)
                                      .then((value) {
                                    if (value) {
                                      AppFuture.addRate(
                                              context,
                                              widget.lesson["id"].toString(),
                                              (currentUserRateIndex + 1)
                                                  .toString())
                                          .then((value) {
                                        if (value != null) {
                                          AppFuture.customToast(value);
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
                              child: SvgPicture.asset(
                                i <= currentUserRateIndex
                                    ? "assets/images/rate_icon.svg"
                                    : "assets/images/rate_icon_outline.svg",
                                color: ThemeStyles.red,
                                height: ThemeStyles.setHeight(20),
                              ),
                            ),
                            ThemeStyles.hSmSpace(),
                          ],
                        )
                    ],
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     debugPrint("rate");
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: ThemeStyles.setWidth(20),
                  //       vertical: ThemeStyles.setHeight(10),
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: ThemeStyles.red,
                  //       borderRadius: BorderRadius.circular(
                  //         ThemeStyles.setWidth(20),
                  //       ),
                  //     ),
                  //     child: Text(
                  //       AppLocalizations.of(context).translate("addRate"),
                  //       style: ThemeStyles.regularStyle().copyWith(
                  //         color: ThemeStyles.white,
                  //         fontSize: ThemeStyles.setWidth(10),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              // ThemeStyles.space(),
              ThemeStyles.space(),
            ],
          ),
        ],
      ),
    );
  }
}
