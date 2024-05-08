import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/constants.dart';
import 'package:flutter/material.dart';

typedef StringCallback = void Function(
    String chosenAnswer, String correcAnswer);

class Task extends StatefulWidget {
  final StringCallback callback;
  final int ansStatus;
  final String dayName,
      lessonId,
      lessonSubtitle,
      lessonTitle,
      description,
      ques,
      choice1,
      choice2,
      choice3,
      correctAnswer;
  const Task({
    Key key,
    @required this.dayName,
    @required this.lessonId,
    @required this.lessonSubtitle,
    @required this.lessonTitle,
    @required this.description,
    @required this.callback,
    @required this.ques,
    @required this.choice1,
    @required this.choice2,
    @required this.choice3,
    @required this.correctAnswer,
    @required this.ansStatus,
  }) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  String chosenAnswer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThemeStyles.quartSpace(),
        Container(
          padding: EdgeInsets.all(
            ThemeStyles.setWidth(8),
          ),
          width: ThemeStyles.setFullWidth(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              ThemeStyles.setWidth(30),
            ),
            color: ThemeStyles.red,
          ),
          child: Text(
            widget.description,
            textAlign: TextAlign.center,
            style: ThemeStyles.boldStyle().copyWith(
              color: ThemeStyles.white,
              fontSize: ThemeStyles.setWidth(17),
            ),
          ),
        ),
        ThemeStyles.space(),


        ThemeStyles.halfSpace(),
        Center(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              widget.ques,
              style: ThemeStyles.boldStyle().copyWith(
                  // shadows: <Shadow>[
                  //   Shadow(
                  //     offset: Offset(
                  //       ThemeStyles.setWidth(1),
                  //       ThemeStyles.setWidth(1),
                  //     ),
                  //     blurRadius: 2,
                  //     color: ThemeStyles.black.withOpacity(0.15),
                  //   ),
                  // ],
                  color: ThemeStyles.red,
                  fontSize: ThemeStyles.setWidth(20),
                  height: AppConstants.langCode == "ar" ? 1.3 : 1.6),
            ),
          ),
        ),
        ThemeStyles.quartSpace(),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     widget.ansStatus != 0
        //         ? Row(
        //             children: [
        //               widget.ansStatus == 1
        //                   ? answerResult(Icons.check, ThemeStyles.green,
        //                       AppLocalizations.of(context).translate("correct"))
        //                   : answerResult(Icons.close, ThemeStyles.error,
        //                       AppLocalizations.of(context).translate("wrong"))
        //             ],
        //           )
        //         : Text(
        //             AppLocalizations.of(context).translate("chooseAns"),
        //             textAlign: TextAlign.center,
        //             style: ThemeStyles.regularStyle().copyWith(
        //               color: ThemeStyles.black,
        //               fontSize: ThemeStyles.setWidth(13),
        //             ),
        //           ),
        //   ],
        // ),
        ThemeStyles.halfSpace(),
        Container(
          width: ThemeStyles.setFullWidth(),
          padding: EdgeInsets.all(ThemeStyles.setWidth(5)),
          decoration: BoxDecoration(
              color: ThemeStyles.white,
              borderRadius: BorderRadius.circular(ThemeStyles.setWidth(15))),
          child: Column(
            children: [
              RadioListTile<String>(
                dense: true,

                contentPadding: const EdgeInsets.all(0.0),
                activeColor: ThemeStyles.red,

                title: Center(
                  child: Text(
                    widget.choice1,
                    style: ThemeStyles.boldStyle().copyWith(
                      color: checkRadioBtnColor(widget.choice1),
                      fontSize: ThemeStyles.setWidth(13),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                value: widget.choice1,
                groupValue: chosenAnswer,
                onChanged: (value) {
                  widget.ansStatus == 0
                      ? setState(() {
                          chosenAnswer = value;
                          widget.callback(chosenAnswer, widget.correctAnswer);
                        })
                      : null;
                },
              ),
              RadioListTile<String>(
                dense: true,
                contentPadding: const EdgeInsets.all(0.0),
                activeColor: ThemeStyles.red,
                title: Center(
                  child: Text(
                    widget.choice2,
                    style: ThemeStyles.boldStyle().copyWith(
                      color: checkRadioBtnColor(widget.choice2),
                      fontSize: ThemeStyles.setWidth(13),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                value: widget.choice2,
                groupValue: chosenAnswer,
                onChanged: (value) {
                  widget.ansStatus == 0
                      ? setState(() {
                          chosenAnswer = value;
                          widget.callback(chosenAnswer, widget.correctAnswer);
                        })
                      : null;
                },
              ),
              RadioListTile<String>(
                dense: true,
                contentPadding: const EdgeInsets.all(0.0),
                activeColor: ThemeStyles.red,
                title: Center(
                  child: Text(
                    widget.choice3,
                    style: ThemeStyles.boldStyle().copyWith(
                      color: checkRadioBtnColor(widget.choice3),
                      fontSize: ThemeStyles.setWidth(13),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                value: widget.choice3,
                groupValue: chosenAnswer,
                onChanged: (value) {
                  widget.ansStatus == 0
                      ? setState(() {
                          chosenAnswer = value;
                          widget.callback(chosenAnswer, widget.correctAnswer);
                        })
                      : null;
                },
              ),
            ],
          ),
        ),
        ThemeStyles.space(),
      ],
    );
  }

  Color checkRadioBtnColor(String rbtitle) {
    return chosenAnswer != null &&
            widget.ansStatus != 0 &&
            rbtitle == widget.correctAnswer
        ? ThemeStyles.green
        : chosenAnswer != null &&
                widget.ansStatus != 0 &&
                rbtitle != widget.correctAnswer
            ? ThemeStyles.error
            : chosenAnswer == null &&
                    widget.ansStatus != 0 &&
                    rbtitle == widget.correctAnswer
                ? ThemeStyles.green
                : chosenAnswer == null &&
                        widget.ansStatus != 0 &&
                        rbtitle != widget.correctAnswer
                    ? ThemeStyles.error
                    : ThemeStyles.black;
  }

  // Row answerResult(IconData icon, Color iconColor, String answerResult) {
  //   return Row(
  //     children: [
  //       Container(
  //         padding: EdgeInsets.all(
  //           ThemeStyles.setWidth(3),
  //         ),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(ThemeStyles.setWidth(30)),
  //           color: iconColor,
  //         ),
  //         child: Icon(
  //           icon,
  //           color: ThemeStyles.white,
  //           size: ThemeStyles.setWidth(20),
  //         ),
  //       ),
  //       ThemeStyles.hSpace(),
  //       Text(
  //         answerResult,
  //         style: ThemeStyles.regularStyle()
  //             .copyWith(fontSize: ThemeStyles.setWidth(13), color: iconColor),
  //       )
  //     ],
  //   );
  // }
}
