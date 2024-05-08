import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllComments extends StatelessWidget {
  final List<dynamic> allComments;
  const AllComments({Key key, @required this.allComments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
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
            AppLocalizations.of(context).translate("comments"),
            style: ThemeStyles.regularStyle().copyWith(
                color: ThemeStyles.red, fontSize: ThemeStyles.setWidth(18)),
          ),
        ),
        backgroundColor: ThemeStyles.offWhite,
        body: SizedBox(
          width: ThemeStyles.setFullWidth(),
          height: ThemeStyles.setFullHeight(),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      Container(
                        margin: EdgeInsets.all(ThemeStyles.setWidth(10)),
                        padding: EdgeInsets.all(
                          ThemeStyles.setWidth(10),
                        ),
                        decoration: ThemeStyles.innerDoubleShadowDecoration(
                            ThemeStyles.setWidth(20), false),
                        height: ThemeStyles.setHeight(500),
                        width: ThemeStyles.setFullWidth(),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: ThemeStyles.setWidth(5),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/account_circle_icon.svg",
                                              width: ThemeStyles.setWidth(30),
                                            ),
                                            ThemeStyles.hSpace(),
                                            Text(
                                              allComments[index]["username"],
                                              style: ThemeStyles.regularStyle()
                                                  .copyWith(
                                                color: ThemeStyles.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ThemeStyles.quartSpace(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: ThemeStyles.setWidth(10),
                                          vertical: ThemeStyles.setHeight(10),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            ThemeStyles.setWidth(10),
                                          ),
                                          color: ThemeStyles.white
                                              .withOpacity(0.5),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(allComments[index]["comment"]),
                                          ],
                                        ),
                                      ),
                                      ThemeStyles.quartSpace(),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: ThemeStyles.setWidth(15),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: ThemeStyles.red,
                                              size: ThemeStyles.setWidth(15),
                                            ),
                                            Text(
                                              allComments[index]["humantime"],
                                              style: ThemeStyles.regularStyle()
                                                  .copyWith(
                                                color: ThemeStyles.red,
                                                fontSize:
                                                    ThemeStyles.setWidth(10),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Column(
                                    children: const [
                                      // ThemeStyles.space(),
                                      Divider(),
                                      // ThemeStyles.space(),
                                    ],
                                  );
                                },
                                itemCount: allComments.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
