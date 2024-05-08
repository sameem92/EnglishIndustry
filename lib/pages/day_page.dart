import 'dart:async';

import 'package:englishindustry/utility/double_shadow_container.dart';
import 'package:englishindustry/components/exercise_component.dart';
import 'package:englishindustry/components/listen_component.dart';
import 'package:englishindustry/components/task_component.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/constants.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:englishindustry/components/video_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Day extends StatefulWidget {
  final Map<String, dynamic> data;
  final int dayType;

  const Day({
    Key key,
    @required this.dayType,
    @required this.data,
  }) : super(key: key);

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  List<dynamic> tasks, lesson;
  int score, ansStatus;
  bool isExercise, isFinished;
  int currentNavIndex, qCount, currentQindex;
  String chosenAnswer, correctAnswer;

  Timer timer;
  int _start;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            try {
              timer.cancel();
            } catch (e) {
              null;
            }
            isExercise = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    try {
      timer.cancel();
    } catch (e) {
      null;
    }
    super.dispose();
  }

  @override
  void initState() {
    _start = 5;
    ansStatus = 0;
    if (widget.dayType != 3) {
      tasks = widget.data["tasks"];
      qCount = tasks.length;
    }

    lesson = widget.data["lesson"];
    isExercise = false;
    isFinished = false;
    currentNavIndex = 0;

    currentQindex = 0;
    score = 0;
    super.initState();
  }

  Future<bool> navigateToHome() async {
    try {
      timer.cancel();
    } catch (e) {
      null;
    }

    if (isFinished) {
      AppFuture.getDataForUserHome(context, 0);
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: navigateToHome,
      child: SafeArea(
top: false,
        bottom: false,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: ThemeStyles.red,
              toolbarHeight: ThemeStyles.setHeight(60),
              centerTitle: true,
              elevation: 0.0,
              leadingWidth: ThemeStyles.setWidth(80),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: ThemeStyles.offWhite,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                widget
                    .data[AppLocalizations.of(context).translate("dayName")],
                style: ThemeStyles.regularStyle().copyWith(
                    color: ThemeStyles.offWhite, fontSize: ThemeStyles.setWidth(18)),
              ),
            ),
            backgroundColor: ThemeStyles.offWhite,
            body: Column(
              children: [
                // header

                // DayHeader(
                //   dayName: widget
                //       .data[AppLocalizations.of(context).translate("dayName")],
                //   willReturnData: isFinished,
                // ),
                // ThemeStyles.halfSpace(),
                // Nav bar task listen vidoe videoonly options
                ThemeStyles.halfSpace(),       ThemeStyles.halfSpace(),
                Container(
                  width: ThemeStyles.setFullWidth(),
                  margin: EdgeInsets.symmetric(
                      horizontal: ThemeStyles.setWidth(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // task Listen and vedio
                      widget.dayType == 0 || widget.dayType == 1
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      currentNavIndex = 0;
                                    });
                                  },
                                  child: tvlContainer(
                                      AppLocalizations.of(context)
                                          .translate("tasks"),
                                      "assets/images/day_home_icon.svg",
                                      0),
                                ),
                                ThemeStyles.hSpace(),
                                ThemeStyles.hSpace(),
                                ThemeStyles.hSpace(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      currentNavIndex = 1;
                                    });
                                  },
                                  child: tvlContainer(
                                      widget.dayType == 0
                                          ? AppLocalizations.of(context)
                                              .translate("listen")
                                          : AppLocalizations.of(context)
                                              .translate("video"),
                                      "assets/images/day_play_icon.svg",
                                      1),
                                ),
                              ],
                            )
                          :
                          // task only
                          widget.dayType == 2
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // task only
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          currentNavIndex = 0;
                                        });
                                      },
                                      child: tvlContainer(
                                          AppLocalizations.of(context)
                                              .translate("tasks"),
                                          "assets/images/day_home_icon.svg",
                                          0),
                                    ),
                                  ],
                                )
                              :
                              // video Only
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // task only
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          currentNavIndex = 0;
                                        });
                                      },
                                      child: tvlContainer(
                                          AppLocalizations.of(context)
                                              .translate("video"),
                                          "assets/images/day_play_icon.svg",
                                          0),
                                    ),
                                  ],
                                ),
                    ],
                  ),
                ),
                ThemeStyles.space(),
                Expanded(
                  child: SingleChildScrollView(
                    child: currentNavIndex == 0 && widget.dayType != 3
                        ? Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: ThemeStyles.setWidth(30),
                                ),
                                child:
                                    //// task
                                    !isExercise
                                        ? Task(
                                            ansStatus: ansStatus,
                                            ques: tasks[currentQindex]
                                                ["questions"][0]["question"],
                                            choice1: tasks[currentQindex]
                                                ["questions"][0]["answer1"],
                                            choice2: tasks[currentQindex]
                                                ["questions"][0]["answer2"],
                                            choice3: tasks[currentQindex]
                                                ["questions"][0]["answer3"],
                                            correctAnswer: tasks[currentQindex]
                                                ["questions"][0]["correct"],
                                            dayName: widget.data[
                                                AppLocalizations.of(context)
                                                    .translate("dayName")],
                                            lessonTitle: widget.data["title"],
                                            lessonSubtitle:
                                                widget.data["subtitle"],
                                            lessonId:
                                                widget.data["id"].toString(),
                                            description:
                                                widget.data["description"],
                                            callback: (chosen, correct) {
                                              setState(() {
                                                chosenAnswer = chosen;
                                                correctAnswer = correct;
                                              });
                                            },
                                          )
                                        : Exercise(
                                            definition: tasks[currentQindex]
                                                ["definition"],
                                            sampleImg: tasks[currentQindex]
                                                ["example_image"],
                                            sampleText: tasks[currentQindex]
                                                ["example_text"],
                                            word: tasks[currentQindex]["word"],
                                            lessonTitle: widget.data["title"],
                                            description:
                                                widget.data["description"],
                                          ),
                              ),
                              ThemeStyles.space(),
                              Container(
                                width: ThemeStyles.setWidth(300),
                                height: ThemeStyles.setWidth(15),
                                decoration: BoxDecoration(
                                  color: ThemeStyles.paleLightRed,
                                  borderRadius: BorderRadius.circular(
                                    ThemeStyles.setWidth(15),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Container(
                                        width: (ThemeStyles.setWidth(300) /
                                                qCount) *
                                            (currentQindex + 1),
                                        height: ThemeStyles.setWidth(10),
                                        decoration: BoxDecoration(
                                          color: ThemeStyles.red,
                                          borderRadius: BorderRadius.circular(
                                            ThemeStyles.setWidth(15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ), ThemeStyles.halfSpace(),
                              Text(
                                "${currentQindex + 1}/$qCount",
                                style: ThemeStyles.regularStyle().copyWith(
                                  color: ThemeStyles.lightRed,
                                ),
                              ),
                              ThemeStyles.halfSpace(),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    if (isExercise) {
                                      setState(() {
                                        if (currentQindex != (qCount - 1)) {
                                          currentQindex++;
                                          isExercise = false;
                                          ansStatus = 0;
                                        } else {
                                          // isfinihed = true;
                                          finishTask();
                                        }
                                      });
                                    } else if (chosenAnswer != null) {
                                      setState(() {
                                        String currentChoosingAnswer =
                                            chosenAnswer;
                                        String currentCorrectAnswer =
                                            correctAnswer;

                                        ansStatus = currentChoosingAnswer ==
                                                currentCorrectAnswer
                                            ? 1
                                            : 2;

                                        score = currentChoosingAnswer ==
                                                currentCorrectAnswer
                                            ? score + 1
                                            : score;

                                        _start = 5;

                                        startTimer();

                                        chosenAnswer = null;
                                        correctAnswer = null;
                                      });
                                    } else {
                                      ansStatus == 0
                                          ?AppFuture.customToast(
                                          AppLocalizations.of(context)
                                              .translate("chooseAns"))
                                          : null;
                                    }
                                    debugPrint("score " + score.toString());
                                  },
                                  child: DoubleShadowContainer(
                                    width: ThemeStyles.setWidth(130),
                                    height: ThemeStyles.setWidth(50),
                                    padding: 12,
                                    shadWidth: 15,
                                    shadOpacity: 0.3,
                                    borderRadius: ThemeStyles.setWidth(120),
                                    borderColor:
                                        ThemeStyles.white.withOpacity(0.5),
                                    child: Center(
                                      child: Text(
                                        isExercise &&
                                                (currentQindex != qCount - 1)
                                            ? AppLocalizations.of(context)
                                                .translate("exercise")
                                                .toUpperCase()
                                            : (currentQindex == qCount - 1 &&
                                                    isExercise)
                                                ? AppLocalizations.of(context)
                                                    .translate("finish")
                                                    .toUpperCase()
                                                : AppLocalizations.of(context)
                                                    .translate("next")
                                                    .toUpperCase(),
                                        style: ThemeStyles.boldStyle().copyWith(
                                          color: ThemeStyles.red,
                                          fontSize: ThemeStyles.setWidth(14),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ThemeStyles.halfSpace(),
                              !isExercise
                                  ? Column(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate("or"),
                                          style: ThemeStyles.regularStyle()
                                              .copyWith(
                                            fontSize: ThemeStyles.setWidth(12),
                                            fontWeight: FontWeight.normal,
                                            height:
                                                AppConstants.langCode == "ar"
                                                    ? 1.7
                                                    : 2.2,
                                          ),
                                        ),
                                        ThemeStyles.quartSpace(),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              isExercise = true;
                                              chosenAnswer = null;
                                              correctAnswer = null;
                                            });
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate("skip"),
                                            textAlign: TextAlign.center,
                                            style: ThemeStyles.regularStyle()
                                                .copyWith(
                                                    color: ThemeStyles.red,
                                                    fontSize:
                                                        ThemeStyles.setWidth(
                                                            15),
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    height:
                                                        AppConstants.langCode ==
                                                                "ar"
                                                            ? 1.7
                                                            : 1.8),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(
                                      height: 0.0,
                                    ),
                            ],
                          )
                        : widget.dayType == 0
                            ? Listen(
                                listenStr: lesson[0]["description"],
                                imgPath: lesson[0]["file"],
                                title: lesson[0]["title"],
                              )
                            : Video(
                                dayName: widget.data["enname"],
                                lesson: lesson[0],
                              ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void finishTask() {
    AppFuture.checkConnection(context).then((value) {
      if (value) {
        AppFuture.finishTask(context, "0", widget.data["id"].toString(),
                score.toString(), (qCount - score).toString(), null)
            .then(
          (message) {
            if (message != null || message != "") {
              AppFuture.getDataForUserHome(context, 0);
            }
          },
        );
      } else {
        AppFuture.customToast(
            AppLocalizations.of(context).translate("checkInternet"));
      }
    });
  }

  Container tvlContainer(String title, String svgPath, int index) {
    return Container(
      width: ThemeStyles.setWidth(120),
      height: ThemeStyles.setHeight(40),
      decoration: ThemeStyles.innerDoubleShadowDecoration(
          ThemeStyles.setWidth(30), false),
      padding: EdgeInsets.symmetric(
          horizontal: ThemeStyles.setWidth(20),
          vertical: ThemeStyles.setWidth(5)),
      child: Row(
        children: [
          SvgPicture.asset(
            svgPath,
            color: index == currentNavIndex
                ? ThemeStyles.red
                : ThemeStyles.lightRed,
          ),
          ThemeStyles.hSpace(),
          Text(
            title,
            style: index == currentNavIndex
                ? ThemeStyles.boldStyle().copyWith(color: ThemeStyles.red)
                : ThemeStyles.regularStyle()
                    .copyWith(color: ThemeStyles.lightRed),
          )
        ],
      ),
    );
  }
}
