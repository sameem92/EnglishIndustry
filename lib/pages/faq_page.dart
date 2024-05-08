import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/constants.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FAQs extends StatefulWidget {
  const FAQs({
    Key key,
  }) : super(key: key);

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  List<dynamic> faqs;
  String contentStr;
  @override
  void initState() {
    contentStr = "";
    faqs = [];
    AppFuture.getFAQS(context).then((allfaqs) {
      if (allfaqs != null) {
        setState(() {
          faqs = allfaqs;
          if (faqs.isEmpty) {
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
    return SafeArea( bottom: false,
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
            AppLocalizations.of(context).translate("faq"),
            style: ThemeStyles.regularStyle().copyWith(
                color: ThemeStyles.red, fontSize: ThemeStyles.setWidth(18)),
          ),
        ),
        body: SizedBox(
          width: ThemeStyles.setFullWidth(),
          height: ThemeStyles.setFullHeight(),
          child: Column(
            children: [
              faqs.isNotEmpty
                  ? Expanded(
                      child: Container(
                        width: ThemeStyles.setFullWidth(),
                        height: ThemeStyles.setFullHeight(),
                        margin: EdgeInsets.only(
                          top: ThemeStyles.setWidth(1),
                          bottom: ThemeStyles.setWidth(20),
                          left: ThemeStyles.setWidth(20),
                          right: ThemeStyles.setWidth(20),

                        ),
                        padding: EdgeInsets.all(
                          ThemeStyles.setWidth(20),
                        ),
                        decoration: BoxDecoration(
                            color: ThemeStyles.offWhite,
                            borderRadius: BorderRadius.circular(
                              ThemeStyles.setWidth(8),
                            ),
                            border: Border.all(color: ThemeStyles.lightGrey)),
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/info_icon.svg",
                                      color: ThemeStyles.red,

                                    ),
                                    ThemeStyles.hSpace(),
                                    Text(
                                      faqs[index]["question"],
                                      style: ThemeStyles.regularStyle().copyWith(
                                        color: ThemeStyles.red, fontSize:
                            ThemeStyles.setWidth(15)
                                      ),
                                    ),
                                  ],
                                ),
                                // ThemeStyles.halfSpace(),
                                ThemeStyles.quartSpace(),
                                Container(
                                  decoration:
                                      ThemeStyles.innerDoubleShadowDecoration(
                                          ThemeStyles.setWidth(20), false),
                                  padding:
                                      EdgeInsets.all(ThemeStyles.setWidth(20)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          faqs[index]["answer"],
                                          style: ThemeStyles.regularStyle()
                                              .copyWith(
                                                  color: ThemeStyles.grey,
                                                  fontSize:
                                                      ThemeStyles.setWidth(12)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                          itemCount: faqs.length,
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
                          color: ThemeStyles.black,
                          fontSize: ThemeStyles.setWidth(17),
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
