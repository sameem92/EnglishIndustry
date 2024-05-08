import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:text_to_speech/text_to_speech.dart';

class SearchResult extends StatefulWidget {
  final String title;
  final Map<String, dynamic> data;
  const SearchResult({Key key, @required this.title, @required this.data})
      : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<dynamic> words;
  TextToSpeech tts = TextToSpeech();

  @override
  void dispose() {
    tts.stop();
    super.dispose();
  }

  @override
  void initState() {
    tts.setLanguage('en-US');  
    tts.setVolume(1.0);
    words = widget.data["data"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(bottom: false,top: false,
      child:
      Scaffold(
        appBar: AppBar(automaticallyImplyLeading: true,backgroundColor: ThemeStyles.offWhite,elevation: 0,
            title: Text( widget.title,style: const TextStyle(color:ThemeStyles.red ),),
          leading: IconButton(onPressed: (){
            Navigator.pop(context);


          },icon:const Icon(Icons.arrow_back_ios),color: ThemeStyles.red,),



        ),

        backgroundColor: ThemeStyles.offWhite,
        body: SizedBox(
          width: ThemeStyles.setFullWidth(),
          height: ThemeStyles.setFullHeight(),
          child: Column(
            children: [
              // BackPressHeader(
              //   title: widget.title,
              // ),
              // ThemeStyles.space(),
              words.isNotEmpty
                  ? Expanded(
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return FittedBox(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: ThemeStyles.setWidth(30)),
                              padding: EdgeInsets.all(
                                ThemeStyles.setWidth(10),
                              ),
                              width: ThemeStyles.setFullWidth(),
                              decoration: BoxDecoration(
                                color: ThemeStyles.lightRed,
                                borderRadius: BorderRadius.circular(
                                  ThemeStyles.setWidth(8),
                                ),
                              ),
                              child: Column(
                                children: [
                                  // ThemeStyles.halfSpace(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            words[index]["word"],
                                            style: ThemeStyles.boldStyle()
                                                .copyWith(
                                              color: ThemeStyles.white,
                                              fontSize:
                                                  ThemeStyles.setWidth(22),
                                            ),
                                          ),
                                          ThemeStyles.hSpace(),
                                          ThemeStyles.hSpace(),
                                          ThemeStyles.hSpace(),
                                          Text(
                                            words[index]["type"],
                                            style: ThemeStyles.regularStyle()
                                                .copyWith(
                                              color: ThemeStyles.white,
                                              fontSize:
                                                  ThemeStyles.setWidth(15),
                                            ),
                                          ),
                                          ThemeStyles.hSpace(),
                                          ThemeStyles.hSpace(),
                                          ThemeStyles.hSpace(),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          tts.speak(words[index]["word"] +
                                              "." +
                                              words[index]["example_text"]);
                                        },
                                        child: SvgPicture.asset(
                                            "assets/images/day_play_icon.svg",
                                            width: ThemeStyles.setWidth(30)),
                                      )
                                    ],
                                  ),
                                  // ThemeStyles.quartSpace(),
                                  Container(
                                    width: ThemeStyles.setFullWidth(),
                                    padding: EdgeInsets.all(
                                      ThemeStyles.setWidth(10),
                                    ),
                                    margin: EdgeInsets.all(
                                      ThemeStyles.setWidth(10),
                                    ),
                                    decoration: BoxDecoration(
                                      color: ThemeStyles.white,
                                      borderRadius: BorderRadius.circular(
                                        ThemeStyles.setWidth(10),
                                      ),
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            words[index]["definition"],
                                            style: ThemeStyles.regularStyle()
                                                .copyWith(
                                              color: ThemeStyles.grey,
                                              fontSize:
                                                  ThemeStyles.setWidth(18),
                                            ),
                                          ),
                                          ThemeStyles.quartSpace(),
                                          Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Text(
                                              words[index]["example_text"],
                                              textAlign: TextAlign.center,
                                              style: ThemeStyles.regularStyle()
                                                  .copyWith(
                                                color: ThemeStyles.grey,
                                                fontSize:
                                                    ThemeStyles.setWidth(17),
                                              ),
                                            ),
                                          )
                                        ]),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: words.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: Text(
                          AppConstants.langCode == "en"
                              ? "No Content Available"
                              : "لا يوجد محتوى",
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
