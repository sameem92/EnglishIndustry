import 'package:englishindustry/data/data_api_service.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';

class Listen extends StatefulWidget {
  final String listenStr, imgPath, title;

  const Listen(
      {Key key,
      @required this.listenStr,
      @required this.imgPath,
      @required this.title})
      : super(key: key);

  @override
  State<Listen> createState() => _ListenState();
}

class _ListenState extends State<Listen> {
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
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ThemeStyles.setWidth(20),
      ),
      child: Column(
        children: [
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
              widget.title,
              textAlign: TextAlign.center,
              style: ThemeStyles.regularStyle().copyWith(
                color: ThemeStyles.white,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          ThemeStyles.halfSpace(),
          Container(
            width: ThemeStyles.setFullWidth(),
            padding: EdgeInsets.all(ThemeStyles.setWidth(15)),
            decoration: BoxDecoration(
                color: ThemeStyles.white,
                borderRadius: BorderRadius.circular(ThemeStyles.setWidth(15))),
            child: Column(
              children: [
                Image.network(
                  DataApiService.imagebaseUrl + widget.imgPath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      width: ThemeStyles.setWidth(130),
                      height: ThemeStyles.setWidth(130),
                      padding: EdgeInsets.all(ThemeStyles.setWidth(20)),
                      decoration: BoxDecoration(
                          border: Border.all(color: ThemeStyles.offWhite),
                          color: ThemeStyles.white,
                          borderRadius:
                              BorderRadius.circular(ThemeStyles.setWidth(80))),
                      child: Center(
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: ThemeStyles.setHeight(80),
                        ),
                      ),
                    );
                  },
                ),
                ThemeStyles.halfSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          tts.speak(widget.listenStr);
                        },
                        child: const Icon(
                          Icons.play_arrow_outlined,
                          color: ThemeStyles.red,
                        )),
                    const SizedBox(
                      width: 30,
                    ),
                    InkWell(
                        onTap: () {
                          tts.stop();
                        },
                        child: const Icon(
                          Icons.pause,
                          color: ThemeStyles.red,
                        )),
                  ],
                ),
                ThemeStyles.halfSpace(),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    widget.listenStr,
                    textAlign: TextAlign.center,
                    style: ThemeStyles.regularStyle().copyWith(
                      color: ThemeStyles.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ThemeStyles.space(),
        ],
      ),
    );
  }
}
