import 'package:englishindustry/pages/search_result_page.dart';
import 'package:englishindustry/pages/splash_page.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:flutter/material.dart';

class Words extends StatefulWidget {
  final bool isUserHome;
  const Words({Key key, @required this.isUserHome}) : super(key: key);

  @override
  State<Words> createState() => _WordsState();
}

class _WordsState extends State<Words> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String letters = "a b c d e f g h i j k l m n o p q r s t u v w x y z",
      keyword;

  void validateAndSave(BuildContext context) {
    final FormState form = _formKey.currentState;
    _formKey.currentState.save();
    if (form.validate()) {
      AppFuture.checkConnection(context).then(
        (value) {
          if (value) {
            AppFuture.searchKeyword(context, keyword).then((searchResult) {
              if (searchResult != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchResult(
                      data: searchResult,
                      title: keyword,
                    ),
                  ),
                );
              }
            });
          } else {
            AppFuture.customToast(AppLocalizations.of(context).translate("checkInternet"));
          }
        },
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: ThemeStyles.setWidth(20)),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  style: ThemeStyles.regularStyle().copyWith(
                    color: ThemeStyles.red,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  validator: (value) {
                    return value.isEmpty
                        ? "Please write a word to search about"
                        : null;
                  },
                  cursorColor:  ThemeStyles.red,
                  onSaved: (value) {
                    setState(() {
                      keyword = value;
                    });
                  },
                  onFieldSubmitted: (value) {
                    setState(() {
                      keyword = value;
                      widget.isUserHome
                          ? validateAndSave(context)
                          : Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const MainProvider(),
                              ),
                              (route) => false,
                            );
                    });
                  },
                  textInputAction: TextInputAction.search,
                  textAlign: TextAlign.start,
                  obscureText: false,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).translate("search"),
                      hintStyle: ThemeStyles.regularStyle().copyWith(
                        color: ThemeStyles.lightRed,
                        fontSize: ThemeStyles.setWidth(11),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ThemeStyles.lightGrey,
                          width: 1.0,
                        ),
                        borderRadius:
                            BorderRadius.circular(ThemeStyles.setWidth(8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: ThemeStyles.red, width: .5),
                        borderRadius:
                            BorderRadius.circular(ThemeStyles.setWidth(8)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(ThemeStyles.setWidth(5)),
                        borderSide: const BorderSide(
                            color: ThemeStyles.lightGrey, width: 1.0),
                      ),
                      contentPadding: EdgeInsets.all(ThemeStyles.setWidth(10)),
                      filled: true,
                      fillColor: ThemeStyles.white.withOpacity(0.5)),
                ),
              ),
              ThemeStyles.space(),
              Wrap(
                runSpacing: ThemeStyles.setWidth(10),
                spacing: ThemeStyles.setWidth(15),
                children: [
                  for (var i = 0; i < 26; i++)
                    InkWell(
                      onTap: () {
                        widget.isUserHome
                            ? AppFuture.checkConnection(context).then((value) {
                                if (value) {
                                  AppFuture.getWordsById(
                                          context, (i + 1).toString())
                                      .then(
                                    (wordData) {
                                      if (wordData != null) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => SearchResult(
                                              title: letters
                                                  .split(" ")[i]
                                                  .toUpperCase(),
                                              data: wordData,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                } else {
                                  AppFuture.customToast(
                                      AppLocalizations.of(context).translate("checkInternet"));
                                }
                              })
                            : AppFuture.goLogin(context);
                      },
                      child: Container(
                        width: ThemeStyles.setWidth(85),
                        padding: EdgeInsets.symmetric(
                          vertical: ThemeStyles.setHeight(8),
                          horizontal: ThemeStyles.setWidth(20),
                        ),
                        decoration: BoxDecoration(
                            color: ThemeStyles.lightRed,
                            borderRadius:
                                BorderRadius.circular(ThemeStyles.setWidth(5))),
                        child: Center(
                          child: Text(
                            letters.split(" ")[i].toUpperCase(),
                            style: ThemeStyles.boldStyle().copyWith(
                              color: ThemeStyles.white,
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
