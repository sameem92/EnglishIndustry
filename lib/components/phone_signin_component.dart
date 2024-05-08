import 'package:englishindustry/utility/double_shadow_container.dart';
import 'package:englishindustry/pages/terms_page.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:englishindustry/pages/verify_phone_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneSignIn extends StatefulWidget {
  const PhoneSignIn({Key key}) : super(key: key);

  @override
  State<PhoneSignIn> createState() => _PhoneSignInState();
}

class _PhoneSignInState extends State<PhoneSignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isNextTapped, canTap;
  String errorStr;
  String phone;
  @override
  void initState() {
    isNextTapped = false;
    canTap = true;
    super.initState();
  }

  void validateAndSave(BuildContext context) {
    _formKey.currentState.save();
    if (phone.isEmpty) {
      setState(() {
        errorStr = AppLocalizations.of(context).translate("phoneRequired");
      });
    } else if (phone.length != 10) {
      errorStr = AppLocalizations.of(context).translate("phone10");
    } else {
      canTap = false;
      AppFuture.checkConnection(context).then(
        (value) {
          if (value) {
            AppFuture.getActiveCode(context, phone).then(
              (value) => {
                if (value != null)
                  {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => VerifyPhone(
                                phone: phone,
                                activeCode: value,
                              )),
                      (route) => false,
                    )
                  }
              },
            );
          } else {
            canTap = true;
            AppFuture.customToast(
                AppLocalizations.of(context).translate("checkInternet"));
          }
        },
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ThemeStyles.space(),
          Text(
            AppLocalizations.of(context).translate("welcome"),
            style: ThemeStyles.boldStyle().copyWith(
              fontSize: ThemeStyles.setWidth(25),
              color: ThemeStyles.red,
            ),
          ),
          ThemeStyles.quartSpace(),
          Text(
            AppLocalizations.of(context).translate("letsStart"),
            style: ThemeStyles.boldStyle().copyWith(
              fontSize: ThemeStyles.setWidth(11),
              color: ThemeStyles.red,
            ),
          ),
          ThemeStyles.halfSpace(),
          ThemeStyles.quartSpace(),
          Container(
            width: ThemeStyles.setFullWidth(),
            padding: EdgeInsets.symmetric(
                horizontal: ThemeStyles.setWidth(30),
                vertical: ThemeStyles.setWidth(5)),
            decoration: ThemeStyles.innerShadowDecoration(100.0, false),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    cursorColor: ThemeStyles.red,
                    style: ThemeStyles.regularStyle().copyWith(
                      color: ThemeStyles.red,
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      // for below version 2 use this
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]'),
                      ),
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(14),
                    ],
                    validator: (value) {
                      return null;
                  // return    AppFuture.customToast(AppLocalizations.of(context)
                  //         .translate("checkInternet"));
                    },
                    onSaved: (value) {
                      setState(() {
                        phone = value;
                      });
                    },
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.start,
                    obscureText: false,
                    decoration: InputDecoration(
                      // hintText:
                      //     AppLocalizations.of(context).translate("phoneHint"),
                      hintStyle: ThemeStyles.regularStyle().copyWith(
                        color: ThemeStyles.lightRed,
                        fontSize: ThemeStyles.setWidth(11),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ThemeStyles.offWhite, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(ThemeStyles.setWidth(5)),
                        borderSide: const BorderSide(
                            color: ThemeStyles.offWhite, width: 0.0),
                      ),
                      contentPadding: EdgeInsets.all(ThemeStyles.setWidth(0)),
                      filled: false,
                    ),
                  ),
                ),

              ],
            ),
          ),
          ThemeStyles.halfSpace(),

          Center(
            child: SizedBox(
              height: errorStr == null || errorStr.isEmpty
                  ? 0.0
                  : ThemeStyles.setHeight(20),
              child: Text(
                errorStr ?? "",
                style:
                ThemeStyles.regularStyle().copyWith(color: ThemeStyles.red),
              ),
            ),
          ),
          ThemeStyles.space(),

          InkWell(
            onTap: () {
              AppFuture.checkConnection(context).then(
                (value) {
                  if (value) {
                    AppFuture.getTerms(context).then((uterms) {
                      if (uterms != null) {                        
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Terms(
                              data: uterms,
                            ),
                          ),
                        );
                      }
                    });
                  } else {
                    AppFuture.customToast(AppLocalizations.of(context)
                        .translate("checkInternet"));
                  }
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(ThemeStyles.setWidth(8)),
                  width: ThemeStyles.setWidth(18),
                  height: ThemeStyles.setWidth(18),
                  decoration: BoxDecoration(
                    color: ThemeStyles.red,
                    borderRadius: BorderRadius.circular(
                      ThemeStyles.setWidth(25),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check,
                      color: ThemeStyles.white,
                      size: ThemeStyles.setWidth(13),
                    ),
                  ),
                ),
                Text(
                  AppLocalizations.of(context).translate("accept"),
                  style: ThemeStyles.regularStyle().copyWith(
                    fontSize: ThemeStyles.setWidth(11),
                    color: ThemeStyles.red,
                  ),
                ),
                ThemeStyles.hSmSpace(),
                Text(
                  AppLocalizations.of(context).translate("termCondition"),
                  style: ThemeStyles.regularStyle().copyWith(
                    decoration: TextDecoration.underline,
                    fontSize: ThemeStyles.setWidth(11),
                    color: ThemeStyles.red,
                  ),
                )
              ],
            ),
          ),
          ThemeStyles.space(),
          Center(
            child: GestureDetector(
              onTap: () {},
              onTapDown: (TapDownDetails details) {
                setState(() {
                  isNextTapped = true;
                });
              },
              onTapUp: (TapUpDetails details) {
                setState(() {
                  isNextTapped = false;
                });
                canTap ? validateAndSave(context) : null;
              },
              child: DoubleShadowContainer(
                width: ThemeStyles.setWidth(150),
                height: ThemeStyles.setWidth(55),
                padding: 12,
                shadWidth: isNextTapped ? 0 : 15,
                shadOpacity: 0.3,
                borderRadius: ThemeStyles.setWidth(120),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).translate("next"),
                    style: ThemeStyles.boldStyle().copyWith(
                      color: ThemeStyles.red,
                      fontSize: ThemeStyles.setWidth(14),
                    ),
                  ),
                ),
                borderColor: isNextTapped
                    ? ThemeStyles.lightGrey
                    : ThemeStyles.white.withOpacity(0.5),
              ),
            ),
          ),
          ThemeStyles.space(),

        ],
      ),
    );
  }
}
