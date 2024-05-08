import 'package:englishindustry/utility/theme_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:text_to_speech/text_to_speech.dart';

typedef BoolCallback = void Function(bool val);

class Exercise extends StatefulWidget {
  final String lessonTitle,
      description,
      word,
      definition,
      sampleImg,
      sampleText;
  const Exercise({
    Key key,
    @required this.lessonTitle,
    @required this.description,
    @required this.word,
    @required this.definition,
    @required this.sampleImg,
    @required this.sampleText,
  }) : super(key: key);

  @override
  State<Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  TextToSpeech tts = TextToSpeech();

  @override
  void initState() {
    tts.setLanguage('en-US');  
    tts.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    tts.stop();
    super.dispose();
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
            widget.description ?? "title",
            textAlign: TextAlign.center,
            style: ThemeStyles.boldStyle().copyWith(
              color: ThemeStyles.white,fontSize: ThemeStyles.setWidth(17),
            ),
          ),
        ),
        ThemeStyles.space(),


        ThemeStyles.halfSpace(),
        Container(
          padding: EdgeInsets.all(ThemeStyles.setWidth(15)),
          width: ThemeStyles.setFullWidth(),
          decoration: ThemeStyles.innerDoubleShadowDecoration(
            ThemeStyles.setWidth(15),
            false,
          ),
          child: Column(children: [
            // widget.sampleImg != null
            //     ? Image.network(
            //         DataApiService.imagebaseUrl + widget.sampleImg,
            //         height: ThemeStyles.setHeight(80),
            //       )
            //     : Container(
            //         width: ThemeStyles.setWidth(80),
            //         height: ThemeStyles.setWidth(80),
            //         padding: EdgeInsets.all(ThemeStyles.setWidth(20)),
            //         decoration: BoxDecoration(
            //             border: Border.all(color: ThemeStyles.offWhite),
            //             color: ThemeStyles.white,
            //             borderRadius:
            //                 BorderRadius.circular(ThemeStyles.setWidth(80))),
            //         child: Center(
            //           child: Image.asset(
            //             "assets/images/logo.png",
            //             height: ThemeStyles.setHeight(80),
            //           ),
            //         ),
            //       ),
            Row(
              children: [
                Text(
                  widget.word,
                  style: ThemeStyles.boldStyle().copyWith(
                    color: ThemeStyles.red,
                    fontSize: ThemeStyles.setWidth(15),
                  ),
                ),
                ThemeStyles.hSpace(),
                // Text(
                //   "(${widget.description})",
                //   style: ThemeStyles.boldStyle().copyWith(
                //     color: ThemeStyles.lightRed,
                //     fontSize: ThemeStyles.setWidth(12),
                //   ),
                // ),
                ThemeStyles.hSpace(),
                ThemeStyles.hSpace(),
                ThemeStyles.hSpace(),
                InkWell(
                  onTap: () {
                    tts.speak(widget.word);
                  },
                  child: SvgPicture.asset(
                    "assets/images/day_play_icon.svg",
                    height: ThemeStyles.setHeight(20),
                  ),
                )
              ],
            ),
            ThemeStyles.space(),
            Text(
              widget.definition,
              style: ThemeStyles.boldStyle().copyWith(
                color: ThemeStyles.red,
              ),
            ),
            ThemeStyles.halfSpace(),


            // Text(
            //   "Example",
            //   style: ThemeStyles.boldStyle().copyWith(
            //       color: ThemeStyles.red, fontSize: ThemeStyles.setWidth(15)),
            // ),
            ThemeStyles.quartSpace(),
            Text(
              widget.sampleText,
              style: ThemeStyles.regularStyle().copyWith(
                  color: ThemeStyles.red, fontSize: ThemeStyles.setWidth(12)),
            ),
            ThemeStyles.quartSpace(),
            InkWell(
              onTap: () {
                tts.speak(widget.sampleText);
              },
              child: SvgPicture.asset(
                "assets/images/day_play_icon.svg",
                height: ThemeStyles.setHeight(20),
              ),
            )
          ]),
        ),
        ThemeStyles.space(),
      ],
    );
  }
}
