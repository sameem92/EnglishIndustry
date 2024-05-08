import 'dart:io';

import 'package:englishindustry/pages/apple_login_loading_page.dart';
import 'package:englishindustry/pages/login_loading_page.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/constants.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:englishindustry/utility/google_signin_api.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class EmailSignInComp extends StatefulWidget {
  const EmailSignInComp({Key key}) : super(key: key);

  @override
  State<EmailSignInComp> createState() => _EmailSignInCompState();
}

class _EmailSignInCompState extends State<EmailSignInComp> {
  final Future<bool> _isAvailableFuture = TheAppleSignIn.isAvailable();

  String errorMessage;
  bool isGoogleTapped = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      checkLoggedInState();
      TheAppleSignIn.onCredentialRevoked.listen((_) {
        debugPrint("Credentials revoked");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Center(
        //   child: Text(
        //     AppLocalizations.of(context).translate("signup"),
        //     textAlign: TextAlign.center,
        //     style: ThemeStyles.regularStyle().copyWith(
        //       color: ThemeStyles.lightRed,
        //       fontSize:
        //           ThemeStyles.setWidth(AppConstants.langCode == "en" ? 18 : 12),
        //     ),
        //   ),
        // ),
        ThemeStyles.halfSpace(),
        ThemeStyles.quartSpace(),
        Center(
          child: GestureDetector(
            onTap: () {},
            onTapDown: (TapDownDetails details) {
              setState(() {
                isGoogleTapped = true;
              });
            },
            onTapUp: (TapUpDetails details) {
              setState(() {
                isGoogleTapped = false;
              });
              // check internet connection
              // check data
              // then
              AppFuture.checkConnection(context).then(
                (value) {
                  if (value) {
                    signIn();
                  } else {
                    AppFuture.customToast(AppLocalizations.of(context)
                        .translate("checkInternet"));
                  }
                },
              );
            },
            child: Container(
              width: ThemeStyles.setWidth(70),
              height: ThemeStyles.setWidth(70),
              padding: EdgeInsets.all(ThemeStyles.setWidth(15)),
              decoration: ThemeStyles.innerDoubleShadowDecoration(
                  100.0, isGoogleTapped),
              child: SvgPicture.asset("assets/images/google_icon.svg"),
            ),
          ),
        ),
        ThemeStyles.space(),
        if (Platform.isIOS)
          Center(
            child: FutureBuilder<bool>(
              future: _isAvailableFuture,
              builder: (BuildContext context, isAvailableSnapshot) {
                if (!isAvailableSnapshot.hasData) {
                  return Text(
                    AppLocalizations.of(context).translate("pleaseWait"),
                    style: ThemeStyles.regularStyle().copyWith(
                      color: ThemeStyles.red,
                      fontSize: ThemeStyles.setWidth(13),
                    ),
                  );
                }
                return isAvailableSnapshot.data
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppleSignInButton(

                            onPressed: () {
                              AppFuture.checkConnection(context).then(
                                (value) {
                                  if (value) {
                                    logInApple();
                                  } else {
                                    AppFuture.customToast(
                                        AppLocalizations.of(context)
                                            .translate("checkInternet"));
                                  }
                                },
                              );
                            },
                          ),
                          ThemeStyles.quartSpace(),
                          if (errorMessage != null) Text(errorMessage),
                        ],
                      )
                    : Text(
                        AppLocalizations.of(context)
                            .translate("appleSignError13"),
                        style: ThemeStyles.regularStyle().copyWith(
                          color: ThemeStyles.error,
                          fontSize: ThemeStyles.setWidth(12),
                        ),
                      );
              },
            ),
          ),
        AppConstants.langCode == "en"
            ? ThemeStyles.space()
            : ThemeStyles.halfSpace(),
        // Center(
        //   child: InkWell(
        //     onTap: () {
        //       AppFuture.checkConnection(context).then((value) {
        //         if (value) {
        //           AppFuture.getSetting(context).then((settingData) {
        //             if (settingData != null) {
        //               Navigator.of(context).push(
        //                 MaterialPageRoute(
        //                   builder: (context) => MyVideoPlayer(
        //                     title: AppConstants.langCode == "en" ?  "Preview Video" : "فيديو",
        //                     videoUrl: DataApiService.videobaseUrl +
        //                         settingData["preview_video"],
        //                     skipType: 1,
        //                   ),
        //                 ),
        //               );
        //             }
        //           });
        //         } else {
        //           AppFuture.customToast(
        //               AppLocalizations.of(context).translate("checkInternet"));
        //         }
        //       });
        //     },
        //     child: Padding(
        //       padding: EdgeInsets.all(ThemeStyles.setWidth(5)),
        //       child: Text(
        //         AppLocalizations.of(context).translate("skipTour"),
        //         style: ThemeStyles.regularStyle().copyWith(
        //           decoration: TextDecoration.underline,
        //           fontSize: ThemeStyles.setWidth(11),
        //           color: ThemeStyles.red,
        //         ),
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }

  Future signIn() async {
    final GoogleSignInAccount user = await GoogleSignInApi.login();
    if (user == null) {
      AppFuture.customToast(
        AppLocalizations.of(context).translate("loginFail"),
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LoginLoading(
            user: user,
          ),
        ),
        (route) => false,
      );
    }
  }

  

  appleSignIn({String user,String name,String email}) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => AppleLoginLoading(
          user: user,
          email:email ,
          name: name,


        ),
      ),
      (route) => false,
    );
  }

  void logInApple() async {
    final AuthorizationResult result = await TheAppleSignIn.performRequests([
      const AppleIdRequest(requestedScopes: [Scope.email,Scope.fullName,])
    ]);

    switch (result.status) {
      case AuthorizationStatus.authorized:

        // Store user ID
        await const FlutterSecureStorage()
            .write(key: "userId", value: result.credential.user);

        await const FlutterSecureStorage()
            .write(key: "userEmail", value: result.credential.email);


        appleSignIn(user: result.credential.user,
            name: "${result.credential.fullName.givenName!=null?result.credential.fullName.givenName:""}"
                " ${result.credential.fullName.familyName!=null?result.credential.fullName.familyName:""}",
            email: result.credential.email);
        break;

      case AuthorizationStatus.error:
        debugPrint(AppLocalizations.of(context).translate("loginFail") +
            result.error.localizedDescription);
        setState(() {
          errorMessage = AppLocalizations.of(context).translate("loginFail");
        });
        break;

      case AuthorizationStatus.cancelled:
        debugPrint('User cancelled');
        break;
    }
  }

  void checkLoggedInState() async {
    final userId = await const FlutterSecureStorage().read(key: "userId");

    if (userId == null) {
      debugPrint("No stored user ID");
      return;
    }

    final credentialState = await TheAppleSignIn.getCredentialState(userId);
    switch (credentialState.status) {
      case CredentialStatus.authorized:
        debugPrint("getCredentialState returned authorized");
        break;

      case CredentialStatus.error:
        debugPrint(
            "getCredentialState returned an error: ${credentialState.error.localizedDescription}");
        break;

      case CredentialStatus.revoked:
        debugPrint("getCredentialState returned revoked");
        break;

      case CredentialStatus.notFound:
        debugPrint("getCredentialState returned not found");
        break;

      case CredentialStatus.transferred:
        debugPrint("getCredentialState returned not transferred");
        break;
    }
  }
}
