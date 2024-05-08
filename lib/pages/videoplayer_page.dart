import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/pages/user_home_page.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatefulWidget {
  final int skipType;
  final String videoUrl, title;

  const MyVideoPlayer(
      {Key key,
      @required this.videoUrl,
      @required this.title,
      @required this.skipType})
      : super(key: key);

  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  VideoPlayerController controller;
  bool isHorizontal, canSkip, canLeavePage;

  @override
  void initState() {
    isHorizontal = false;
    canSkip = false;
    canLeavePage = false;
    Future.delayed(const Duration(seconds: 1), () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    });
    loadVideoPlayer();

    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        canSkip = true;
      });
    });

    super.initState();
  }

  loadVideoPlayer() {
    controller = VideoPlayerController.network(widget.videoUrl);
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      setState(() {});
    });

    // if (controller.value.isPlaying) {
    //   //video is currently playing
    // } else {
    //   //video is currently paused
    // }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<bool> resetOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MediaQuery.of(context).orientation == Orientation.portrait &&
        canSkip;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: resetOrientation,
      child: Scaffold(
        backgroundColor: ThemeStyles.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ThemeStyles.red,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: ThemeStyles.setWidth(40)),
              Text(
                widget.title,
                style: ThemeStyles.regularStyle().copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: ThemeStyles.setWidth(40),
                child: IconButton(
                  onPressed: () {
                    resetOrientation();
                    controller?.dispose();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ],
          ),
        ),
        body: SizedBox(
          width: ThemeStyles.setFullWidth(),
          child: Column(children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: Stack(
                    children: [
                      InkWell(
                          onTap: () {
                            if (controller.value.isPlaying) {
                              controller.pause();
                            } else {
                              controller.play();
                            }

                            setState(() {});
                          },
                          child: VideoPlayer(controller)),
                      Align(
                        alignment: Alignment.center,
                        child: IconButton(
                            onPressed: () {
                              if (controller.value.isPlaying) {
                                controller.pause();
                              } else {
                                controller.play();
                              }
                              setState(() {});
                            },
                            icon: Icon(
                              controller.value.isPlaying
                                  ? Icons.pause_circle
                                  : Icons.play_circle,
                              color: controller.value.isPlaying
                                  ? ThemeStyles.white.withOpacity(0.0)
                                  : ThemeStyles.white,
                            )),
                      ),
                      widget.skipType == 1 && canSkip
                          ? Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  controller.pause();
                                  resetOrientation().then((value) {
                                    if (value) {
                                      getDataForHome();
                                    }
                                  });
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.all(ThemeStyles.setWidth(8)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ThemeStyles.setWidth(15),
                                      vertical: ThemeStyles.setWidth(5)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      ThemeStyles.setWidth(20),
                                    ),
                                    border:
                                        Border.all(color: ThemeStyles.white),
                                    color: ThemeStyles.white,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate("skip")
                                        .toUpperCase(),
                                    style: ThemeStyles.boldStyle().copyWith(
                                      color: ThemeStyles.red,
                                    ),
                                  ),
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: ThemeStyles.boldStyle()
                      .copyWith(color: ThemeStyles.white),
                ),
                ThemeStyles.hSpace(),
                ThemeStyles.hSpace(),
                Text(
                  AppLocalizations.of(context).translate("totalDur") +
                      controller.value.duration.inMinutes.toString() +
                      AppLocalizations.of(context).translate("mins"),
                  style: ThemeStyles.regularStyle().copyWith(
                      color: ThemeStyles.white,
                      fontSize: ThemeStyles.setWidth(10)),
                ),
              ],
            ),
            VideoProgressIndicator(
              controller,
              allowScrubbing: true,
              colors: const VideoProgressColors(
                backgroundColor: ThemeStyles.white,
                playedColor: ThemeStyles.green,
                bufferedColor: ThemeStyles.red,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 750),
              height:
                  controller.value.isPlaying ? 0.0 : ThemeStyles.setHeight(100),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (controller.value.isPlaying) {
                              controller.pause();
                            } else {
                              controller.play();
                            }

                            setState(() {});
                          },
                          icon: Icon(
                            controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: ThemeStyles.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.seekTo(const Duration(seconds: 0));

                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.stop,
                            color: ThemeStyles.white,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        !isHorizontal
                            ? SystemChrome.setPreferredOrientations([
                                DeviceOrientation.landscapeRight,
                                DeviceOrientation.landscapeLeft,
                              ])
                            : SystemChrome.setPreferredOrientations([
                                DeviceOrientation.portraitUp,
                                DeviceOrientation.portraitDown,
                                DeviceOrientation.landscapeRight,
                                DeviceOrientation.landscapeLeft,
                              ]);
                        setState(() {
                          isHorizontal = !isHorizontal;
                        });
                      },
                      icon: const Icon(
                        Icons.rectangle_outlined,
                        color: ThemeStyles.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  void getDataForHome() {
    AppFuture.checkConnection(context).then(
      (value) {
        if (value) {
          AppFuture.getHomeData(context).then(
            (homedata) {
              if (homedata != null) {
                AppFuture.getKidsHomeData(context).then((kidsHomeData) {
                  if (kidsHomeData != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserHome(
                          userProfileData: null,
                          userHomeData: homedata,
                          strtPageIndex: 0,
                          kidsHomeData: kidsHomeData,
                          myWeeks: const [],
                          kidsMyWeeks: const [],
                          isUserHome: false,
                        ),
                      ),
                    );
                  }
                });
              }
            },
          );
        } else {
          AppFuture.customToast(
              AppLocalizations.of(context).translate("checkInternet"));
        }
      },
    );
  }
}
