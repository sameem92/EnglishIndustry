import 'dart:async';

import 'package:englishindustry/utility/double_shadow_container.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Verify extends StatefulWidget {
  final String activeCode, phone;
  const Verify({Key key, this.activeCode, @required this.phone})
      : super(key: key);

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  bool isVerifyTapped, canTap;
  String activeCode, currentcode;
  String errorStr;
  Map<String, dynamic> userProfileData, userHomeData, kidsHomeData;
  List<dynamic> kidsHomeDataList, userWeeks, kidsUserWeeks;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    isVerifyTapped = false;
    canTap = false;

    activeCode = widget.activeCode;
    super.initState();
    startTimer();
  }
@override
  void dispose() {
    // TODO: implement dispose
  timer.cancel();
//
//     startTimer();
//     startTimerAgain();
    super.dispose();
  }
  static const maxSeconds = 10;
  int seconds = maxSeconds;
  Timer timer;
//
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          seconds--;
        });
        if (seconds == 0) timer.cancel();
      }
    });
  }

  void startTimerAgain() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          seconds--;
        });
        if (seconds == 0) timer.cancel();
      }
    });
  }
  void validateAndSave(BuildContext context) {
    //final FormState form = _formKey.currentState;
    _formKey.currentState.save();
    //form.validate();
    if (currentcode.isEmpty) {
      setState(() {
        errorStr = AppLocalizations.of(context).translate("codeRequired");
      });
    }
    // else if (currentcode.length != 6) {
    //   errorStr = AppLocalizations.of(context).translate("code6");
    // }
    else {
      if (currentcode == activeCode) {
        // check data
        // then
        AppFuture.checkConnection(context).then((value) {
          canTap = false;
          if (value) {
            AppFuture.autherize(context, widget.phone, currentcode)
                .then((value) {
              if (value != null) {
                AppFuture.getDataForUserHome(context, 0);
              }
            });
          } else {
            canTap = true;
            AppFuture.customToast(
                AppLocalizations.of(context).translate("checkInternet"));
          }
        });
      } else {
        canTap = true;
        AppFuture.customToast(
            AppLocalizations.of(context).translate("wrongVerify"));
      }
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
            AppLocalizations.of(context).translate("verification"),
            style: ThemeStyles.boldStyle().copyWith(
              fontSize: ThemeStyles.setWidth(27),
              color: ThemeStyles.red,
            ),
          ),
          ThemeStyles.quartSpace(),
          Text(
            AppLocalizations.of(context).translate("pleaseWait"),
            style: ThemeStyles.boldStyle().copyWith(
              fontSize: ThemeStyles.setWidth(11),
              color: ThemeStyles.red,
            ),
          ),
          ThemeStyles.space(),
          Container(
            width: ThemeStyles.setFullWidth(),
            padding: EdgeInsets.symmetric(
                horizontal: ThemeStyles.setWidth(30),
                vertical: ThemeStyles.setWidth(11)),
            decoration: ThemeStyles.innerShadowDecoration(100.0, false),
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
                LengthLimitingTextInputFormatter(6),
              ],
              // validator: (value) {
              //   return null;
              // },
              onSaved: (value) {
                setState(() {
                  currentcode = value;
                });
              },
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.center,
              obscureText: false,
              decoration: InputDecoration(
                // hintText: "- - - - - -",
                hintStyle: ThemeStyles.regularStyle().copyWith(
                  color: ThemeStyles.red,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: ThemeStyles.offWhite, width: 0.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ThemeStyles.setWidth(5)),
                  borderSide:
                      const BorderSide(color: ThemeStyles.offWhite, width: 0.0),
                ),
                contentPadding: EdgeInsets.all(ThemeStyles.setWidth(0)),
                filled: false,
              ),
            ),
          ), ThemeStyles.space(),
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
          // ThemeStyles.halfSpace(),
          seconds == 0?
          Center(
            child: InkWell(
                onTap: () {
                  AppFuture.getActiveCode(context, widget.phone).then((value) {
                    if (value != null) {
                      setState(() {
                        activeCode = value;
                        seconds = 100;

                      });
                      startTimerAgain();
                    }
                  });
                },
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).translate("resend"),
                    style: ThemeStyles.regularStyle().copyWith(color: ThemeStyles.red),
                  ),
                ),
              ),
          ):
    Center(
      child: Text(
                        "    ( $seconds:0 )"
        ,
        style: ThemeStyles.regularStyle().copyWith(color: ThemeStyles.red),
                        maxLines: 2,
                      ),
    ),

          ThemeStyles.space(),
          ThemeStyles.space(),
          Center(
            child: GestureDetector(
              onTap: () {},
              onTapDown: (TapDownDetails details) {
                setState(() {
                  isVerifyTapped = true;
                });
              },
              onTapUp: (TapUpDetails details) {
                setState(() {
                  isVerifyTapped = false;
                });

                validateAndSave(context);
              },
              child: DoubleShadowContainer(
                width: ThemeStyles.setWidth(150),
                height: ThemeStyles.setWidth(55),
                padding: 12,
                shadWidth: isVerifyTapped ? 0 : 15,
                shadOpacity: 0.1,
                borderRadius: ThemeStyles.setWidth(120),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).translate("verify"),
                    style: ThemeStyles.boldStyle().copyWith(
                      color: ThemeStyles.red,
                      fontSize: ThemeStyles.setWidth(14),
                    ),
                  ),
                ),
                borderColor: isVerifyTapped
                    ? ThemeStyles.lightGrey
                    : ThemeStyles.white.withOpacity(0.2),
              ),
            ),
          ),
          ThemeStyles.space(),

        ],
      ),
    );
  }
}


//.a,sd,aspd,asdas,dpaos,dp[aso,daops,d-asdop,=as-dop,q=wdp,qw=dpqo,w=dqopw,d=q


//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                         onTap: () async {
//                           String? firebaseToken =
//                           await FirebaseMessaging.instance.getToken();
//
//                           if (seconds == 0) {
//                             bool sendAgain = await LoginAndProfileController()
//                                 .userRegisterController(
//                               context,
//                               firebaseToken: firebaseToken!,
//                               phone: widget.phone,
//                               language: Localizations.localeOf(context)
//                                   .languageCode ==
//                                   "ar"
//                                   ? "ar"
//                                   : "en",
//                             );
//
//                             if (sendAgain) {
//                               if (mounted) {
//                                 setState(() {
//                                   seconds = 100;
//                                 });
//                                 startTimerAgain();
//                               }
//                             }
//                           } else {
//                             null;
//                           }
//                         },
//                         child: StyleText(
//                           AppLocalizations.of(context)!
//                               .sendTheVerificationCodeAgain,
//                           textColor: seconds == 0 ? kConfirm : kSpecialColor,
//                         )),
//                     StyleText(
//                       "    ( $seconds:0 )",
//                       textColor: kSpecialColor,
//                       maxLines: 2,
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: SizeConfig.scaleHeight(100),
//                 ),
//                 StyleButton(
//                   AppLocalizations.of(context)!.verifyfromaccount,
//                   width: SizeConfig.scaleWidth(230),
//                   onPressed: () async {
//                     await performCode();
//                     FocusScope.of(context).unfocus();
//                     timer!.cancel();
//                   },
//                 ),
//