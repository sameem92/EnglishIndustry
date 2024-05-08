import 'dart:async';

import 'package:englishindustry/utility/double_shadow_container.dart';
import 'package:englishindustry/components/result_component.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/constants.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:flutter/material.dart';

class ExamDay extends StatefulWidget {
  final Map<String, dynamic> data;
  final String dayName, lessonTitle, lessonSubtitle, lessonType;
  const ExamDay({
    Key key,
    @required this.dayName,
    @required this.lessonTitle,
    @required this.lessonSubtitle,
    @required this.lessonType,
    @required this.data,
  }) : super(key: key);

  @override
  State<ExamDay> createState() => _ExamDayState();
}

class _ExamDayState extends State<ExamDay> {
  List<dynamic> exams;
  int qCount, currentQindex;
  int score;
  String chosenAnswer,
      rightAnswer,
      rbTitle1,
      rbTitle2,
      rbTitle3,
      question,
      nextBtnTitle;
  bool isExamFinished;
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
            // check if there is answer
            // show the answer
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
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    exams = widget.data["exam"];
    qCount = exams.length;
    currentQindex = 0;

    isExamFinished = false;
    question = exams[0]["question"];
    rightAnswer = exams[0]["correct"];
    rbTitle1 = exams[0]["answer1"];
    rbTitle2 = exams[0]["answer2"];
    rbTitle3 = exams[0]["answer3"];
    _start = exams[0]["answertime"];
    nextBtnTitle = AppConstants.langCode == "en" ? "Next" : "التالي";
    score = 0;
    startTimer();
    super.initState();
  }

  Future<bool> _willPopCallback() async {
    try {
      timer.cancel();
    } catch (e) {
      null;
    }

    if (isExamFinished) {
      AppFuture.getDataForUserHome(context, 0);
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
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
            // widget.dayName,
               AppLocalizations.of(
                  context)
                  .translate("exams")+" "+widget.dayName,
            style: ThemeStyles.regularStyle().copyWith(
                color: ThemeStyles.offWhite, fontSize: ThemeStyles.setWidth(18)),
          ),
        ),
        backgroundColor: ThemeStyles.offWhite,
        body: Column(
          children: [

            // DayHeader(
            //   dayName: widget.dayName,
            //   willReturnData: isExamFinished,
            // ),
            ThemeStyles.space(),ThemeStyles.space(),
            Expanded(
              child: SingleChildScrollView(
                child: !isExamFinished
                    ? Column(
                        children: [
                          // Container(
                          //   width: ThemeStyles.setFullWidth(),
                          //   margin: EdgeInsets.symmetric(
                          //       horizontal: ThemeStyles.setWidth(30)),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Text(
                          //         qCount.toString() +
                          //             " " +
                          //             AppLocalizations.of(context)
                          //                 .translate("ques"),
                          //         style: ThemeStyles.regularStyle().copyWith(
                          //           color: ThemeStyles.lightRed,
                          //           fontSize: ThemeStyles.setWidth(15),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ThemeStyles.setWidth(30)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                ThemeStyles.space(),
                                Center(
                                  child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Text(
                                      question,
                                      style: ThemeStyles.boldStyle().copyWith(
                                        shadows: [
                                          Shadow(
                                            offset: Offset(
                                              ThemeStyles.setWidth(1),
                                              ThemeStyles.setWidth(1),
                                            ),
                                            blurRadius: 2,
                                            color: ThemeStyles.black
                                                .withOpacity(0.15),
                                          ),
                                        ],
                                        color: ThemeStyles.red,
                                        fontSize: ThemeStyles.setWidth(24),
                                      ),
                                    ),
                                  ),
                                ),
                                ThemeStyles.space(),
                                ThemeStyles.space(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _start == 0
                                        ? Row(
                                            children: [
                                              chosenAnswer != null &&
                                                      chosenAnswer ==
                                                          rightAnswer
                                                  ? answerResult(
                                                      Icons.check,
                                                      ThemeStyles.green,
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate("correct"))
                                                  : answerResult(
                                                      Icons.close,
                                                      ThemeStyles.error,
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate("wrong"),)
                                            ],
                                          )
                                        : Text(
                                            AppLocalizations.of(context)
                                                .translate("chooseAns"),
                                            textAlign: TextAlign.center,
                                            style: ThemeStyles.regularStyle()
                                                .copyWith(
                                              color: ThemeStyles.black,
                                              fontSize:
                                                  ThemeStyles.setWidth(10),
                                            ),
                                          ),
                                  ],
                                ),
                                ThemeStyles.space(),
                                Container(
                                  width: ThemeStyles.setFullWidth(),
                                  padding:
                                      EdgeInsets.all(ThemeStyles.setWidth(10)),
                                  decoration: BoxDecoration(
                                      color: ThemeStyles.white,
                                      borderRadius: BorderRadius.circular(
                                          ThemeStyles.setWidth(15))),
                                  child: Column(
                                    children: [
                                      RadioListTile<String>(
                                        dense: true,
                                        contentPadding:
                                            const EdgeInsets.all(0.0),
                                        activeColor: ThemeStyles.red,
                                        title: Center(
                                          child: Text(
                                            rbTitle1,
                                            style:
                                                ThemeStyles.boldStyle().copyWith(
                                              color: checkRadioBtnColor(rbTitle1),
                                              fontSize: ThemeStyles.setWidth(18),
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        value: rbTitle1,
                                        groupValue: chosenAnswer,
                                        onChanged: (value) {
                                          _start != 0
                                              ? setState(() {
                                                  chosenAnswer = value;
                                                })
                                              : null;
                                        },
                                      ),
                                      RadioListTile<String>(
                                        dense: true,
                                        contentPadding:
                                            const EdgeInsets.all(0.0),
                                        activeColor: ThemeStyles.red,
                                        title: Center(
                                          child: Text(
                                            rbTitle2,
                                            style:
                                                ThemeStyles.boldStyle().copyWith(
                                              color: checkRadioBtnColor(rbTitle2),
                                              fontSize: ThemeStyles.setWidth(18),
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        value: rbTitle2,
                                        groupValue: chosenAnswer,
                                        onChanged: (value) {
                                          _start != 0
                                              ? setState(() {
                                                  chosenAnswer = value;
                                                })
                                              : null;
                                        },
                                      ),
                                      RadioListTile<String>(
                                        dense: true,
                                        contentPadding:
                                            const EdgeInsets.all(0.0),
                                        activeColor: ThemeStyles.red,
                                        title: Center(
                                          child: Text(
                                            rbTitle3,
                                            style:
                                                ThemeStyles.boldStyle().copyWith(
                                              color: checkRadioBtnColor(rbTitle3),
                                              fontSize: ThemeStyles.setWidth(18),
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        value: rbTitle3,
                                        groupValue: chosenAnswer,
                                        onChanged: (value) {
                                          _start != 0
                                              ? setState(() {
                                                  chosenAnswer = value;
                                                })
                                              : null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                ThemeStyles.space(),
                              ],
                            ),
                          ),
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
                                    width:
                                        (ThemeStyles.setWidth(300) / qCount) *
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
                          ),
                          ThemeStyles.halfSpace(),

                          Text(
                            "${currentQindex + 1}/$qCount",
                            style: ThemeStyles.regularStyle().copyWith(
                              color: ThemeStyles.lightRed,
                            ),
                          ),
                          ThemeStyles.halfSpace(),
                          Column(
                            children: [
                              Container(
                                width: ThemeStyles.setWidth(50),
                                height: ThemeStyles.setWidth(50),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: ThemeStyles.grey),
                                    borderRadius: BorderRadius.circular(
                                      ThemeStyles.setWidth(25),
                                    )),
                                child: Center(
                                  child: Text(
                                    _start.toString(),
                                    style: ThemeStyles.regularStyle().copyWith(
                                      color: ThemeStyles.grey,
                                      fontSize: ThemeStyles.setWidth(15),
                                    ),
                                  ),
                                ),
                              ),
                              ThemeStyles.quartSpace(),
                              Text(
                                AppLocalizations.of(context).translate("sec"),
                                style: ThemeStyles.regularStyle().copyWith(
                                  color: ThemeStyles.grey,
                                ),
                              )
                            ],
                          ),
                          ThemeStyles.space(),
                          Center(
                            child: InkWell(
                                onTap: () {
                                  if (chosenAnswer == null && _start != 0) {
                                    // CustomDialogues.showNoAnswerDialog(context);
                                    AppFuture.customToast(
                                        AppLocalizations.of(context)
                                            .translate("chooseAns"));
                                  }
                                  else if (chosenAnswer != null &&
                                      _start != 0) {
                                    _start = 0;
                                    try {
                                      timer.cancel();
                                    } catch (e) {
                                      null;
                                    }
                                  } else {
                                    // set new data here and check data length
                                    if (currentQindex != (qCount - 1)) {
                                      chosenAnswer == rightAnswer
                                          ? score = score + 1
                                          : score;
                                      currentQindex++;
                                      question =
                                          exams[currentQindex]["question"];
                                      rbTitle1 =
                                          exams[currentQindex]["answer1"];
                                      rbTitle2 =
                                          exams[currentQindex]["answer2"];
                                      rbTitle3 =
                                          exams[currentQindex]["answer3"];
                                      rightAnswer =
                                          exams[currentQindex]["correct"];
                                      _start =
                                          exams[currentQindex]["answertime"];
                                      currentQindex == (qCount - 1)
                                          ? nextBtnTitle = "finish"
                                          : AppLocalizations.of(context)
                                              .translate("next");
                                    } else {
                                      try {
                                        timer.cancel();
                                      } catch (e) {
                                        null;
                                      }
                                      chosenAnswer == rightAnswer
                                          ? score = score + 1
                                          : score;
                                      finishTask();
                                    }
                                    debugPrint(score.toString());

                                    chosenAnswer = null;
                                    _start = 10;
                                    startTimer();
                                  }
                                  setState(() {});
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
                                      nextBtnTitle.toUpperCase(),
                                      style: ThemeStyles.boldStyle().copyWith(
                                        color: ThemeStyles.red,
                                        fontSize: ThemeStyles.setWidth(14),
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      )
                    : Result(score: (score / qCount) * 100),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void finishTask() {
    AppFuture.checkConnection(context).then((value) {
      if (value) {
        AppFuture.finishTask(
          context,
          "1",
          widget.data["id"].toString(),
          score.toString(),
          (qCount - score).toString(),
          (score / qCount * 100).round().toString(),
        ).then(
          (message) {
            if (message != null || message != "") {
              setState(() {
                isExamFinished = true;
              });
            }
          },
        );
      } else {
        AppFuture.customToast(
            AppLocalizations.of(context).translate("checkInternet"));
      }
    });
  }

  Row answerResult(IconData icon, Color iconColor, String answerResult) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(
            ThemeStyles.setWidth(3),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ThemeStyles.setWidth(30)),
            color: iconColor,
          ),
          child: Icon(
            icon,
            color: ThemeStyles.white,
            size: ThemeStyles.setWidth(15),
          ),
        ),
        ThemeStyles.hSpace(),
        Text(
          answerResult,
          style: ThemeStyles.regularStyle()
              .copyWith(fontSize: ThemeStyles.setWidth(15), color: iconColor),
        )
      ],
    );
  }

  Color checkRadioBtnColor(String rbtitle) {
    return chosenAnswer != null && _start == 0 && rbtitle == rightAnswer
        ? ThemeStyles.green
        : chosenAnswer != null && _start == 0 && rbtitle != rightAnswer
            ? ThemeStyles.error
            : chosenAnswer == null && _start == 0 && rbtitle == rightAnswer
                ? ThemeStyles.green
                : chosenAnswer == null && _start == 0 && rbtitle != rightAnswer
                    ? ThemeStyles.error
                    : ThemeStyles.black;
  }
}
