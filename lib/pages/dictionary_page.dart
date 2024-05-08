import 'package:avatar_glow/avatar_glow.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/constants.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translator/translator.dart';

class Dictionary extends StatefulWidget {
  const Dictionary({Key key}) : super(key: key);

  @override
  State<Dictionary> createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  final translator = GoogleTranslator();
  stt.SpeechToText speech;

  bool isEnListening = false;
  bool isArListening = false;
  String result;
  String translated;
  double confidence = 1.0;

  @override
  void initState() {
    try {
      result = AppLocalizations.of(context).translate("pressMic");
      translated = AppLocalizations.of(context).translate("waitrans");
    } catch (e) {
      result = AppConstants.langCode == "en"
          ? "Press the button to start speaking"
          : "اضغط على الميكروفون لبدأ التحدث";
      translated = AppConstants.langCode == "en" ? "translation" : "الترجمة";
    }

    AppFuture.checkConnection(context).then((value) {
      if (!value) {
        AppFuture.customToast(
            AppLocalizations.of(context).translate("checkInternet"));
      }
    });
    super.initState();

    speech = stt.SpeechToText();
  }

  void enListen() async {
    if (!isEnListening) {
      bool available = await speech.initialize(
        onStatus: (val) => debugPrint('onStatus: $val'),
        onError: (val) => debugPrint('onError: $val'),
      );
      if (available) {
        setState(() => isEnListening = true);
        speech.listen(
          localeId: "en_US",
          onResult: (val) => setState(() {
            result = val.recognizedWords;
            isEnListening = false;
            translate(0);
          }),
        );
      }
    } else {
      setState(() => isEnListening = false);
      speech.stop();
    }
  }

  Future<void> translate(int langIndex) async {
    try {
      var translation =
          await translator.translate(result, to: langIndex == 0 ? 'ar' : "en");
      setState(() {
        translated = translation.text;
      });
    } catch (e) {
      // AppFuture.customToast("Please Check Your Microphone");
    }
  }

  void arListen() async {
    if (!isArListening) {
      bool available = await speech.initialize(
        onStatus: (val) => debugPrint('onStatus: $val'),
        onError: (val) => debugPrint('onError: $val'),
      );
      if (available) {
        setState(() => isArListening = true);
        speech.listen(
          localeId: "ar_AU",
          onResult: (val) => setState(() {
            result = val.recognizedWords;
            isArListening = false;
            translate(1);
          }),
        );
      }
    } else {
      setState(() => isArListening = false);
      speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ThemeStyles.setWidth(30),
            vertical: ThemeStyles.setWidth(1),
          ),
          child: Column(
            children: [
              dictionaryContent(
                  AppLocalizations.of(context).translate("speechtt"), result),
              ThemeStyles.space(),
              dictionaryContent(
                  AppLocalizations.of(context).translate("tst"), translated),
              ThemeStyles.halfSpace(),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: ThemeStyles.setWidth(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    micContent(1),
                    micContent(0),
                  ],
                ),
              ),
              ThemeStyles.space(),
            ],
          ),
        ),
      ),
    );
  }

  Column micContent(int langindex) {
    return Column(
      children: [
        AvatarGlow(
          animate: langindex == 0 ? isEnListening : isArListening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 50.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: InkWell(
            onTap: langindex == 0 ? enListen : arListen,
            child: SvgPicture.asset(
              "assets/images/mic_icon.svg",
              width: ThemeStyles.setWidth(50),
              color: langindex == 0 ? ThemeStyles.red : ThemeStyles.green,
            ),
          ),
        ),
        Text(
          langindex == 0
              ? AppLocalizations.of(context).translate("strtEng")
              : AppLocalizations.of(context).translate("strtArb"),
          style: ThemeStyles.regularStyle().copyWith(
            color: langindex == 0 ? ThemeStyles.red : ThemeStyles.green,
            fontSize: ThemeStyles.setWidth(12),
          ),
        )
      ],
    );
  }

  Column dictionaryContent(String title, String result) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: ThemeStyles.regularStyle().copyWith(
                color: ThemeStyles.red,
                fontSize: ThemeStyles.setWidth(12),
              ),
            ),
          ],
        ),
        // ThemeStyles.halfSpace(),
        ThemeStyles.quartSpace(),
        Container(
          width: ThemeStyles.setFullWidth(),
          height: ThemeStyles.setHeight(150),
          padding: EdgeInsets.all(
            ThemeStyles.setWidth(20),
          ),
          decoration: ThemeStyles.innerDoubleShadowDecoration(
            ThemeStyles.setWidth(20),
            false,
          ),
          child: Center(
            child: Text(
              result,
              style: ThemeStyles.regularStyle().copyWith(
                color: ThemeStyles.red,
                fontSize: ThemeStyles.setWidth(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
