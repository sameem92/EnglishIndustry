import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:englishindustry/data/data_api_service.dart';
import 'package:englishindustry/data/header_interceptor.dart';
import 'package:englishindustry/utility/double_shadow_container.dart';
import 'package:englishindustry/pages/login_page.dart';
import 'package:englishindustry/utility/future.dart';
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

class MainProvider extends StatefulWidget {
  final bool isPaymentProvider;

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MainProviderState state =
        context.findAncestorStateOfType<_MainProviderState>();
    state.setLanguage(newLocale);
  }

  const MainProvider({Key key, this.isPaymentProvider = false})
      : super(key: key);

  @override
  _MainProviderState createState() => _MainProviderState();
}

class _MainProviderState extends State<MainProvider> {
  SharedPreferences _pref;
  Locale _locale;
  Future setLanguage(Locale locale) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setString("langcode", locale.languageCode);
    _pref.setString("countrycode", locale.countryCode);
    AppConstants.langCode = _pref.getString("langcode");
    setState(() {
      _locale = locale;
    });
  }

  Future setLocaleFromPref() async {
    _pref = await SharedPreferences.getInstance();

    if (_pref.getString("langcode") != null) {
      setLanguage(
          Locale(_pref.getString("langcode"), _pref.getString("countrycode")));
    }
  }

  @override
  void initState() {
    setLocaleFromPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      // The initialized PostApiService is now available down the widget tree
      create: (_) => DataApiService.create(),
      // Always call dispose on the ChopperClient to release resources

      dispose: (_, DataApiService service) => service.client.dispose(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: const [
          Locale('en', "US"),
          Locale('ar', "AE"),
        ],
        locale:
            _locale, // temporarly _locale please get langcode from shared Prefences Locale(langcode, "US") or Locale(langcode, "AE")
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        title: "English Industry",
        home:
            widget.isPaymentProvider ? const PayScreen() : const SplashScreen(),
      ),
    );
  }
}

class PayScreen extends StatefulWidget {
  const PayScreen({Key key}) : super(key: key);

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  Future<SharedPreferences> getSharedprefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    AppFuture.checkConnection(context).then((value) {
      if (value) {
        getSharedprefs().then((prefs) {
          AppFuture.refreshToken(context, prefs.getString("user_id"))
              .then((tokenValue) {
            if (tokenValue != null) {
              HeaderInterceptor.V4_AUTH_HEADER = tokenValue;
              AppFuture.getDataForUserHome(context, 0);
            }
          });
        });
      } else {
        AppFuture.customToast(
            AppLocalizations.of(context).translate("checkInternet"));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      upgrader: Upgrader(
        canDismissDialog: true,
        shouldPopScope: ()=>true,
          durationUntilAlertAgain: const Duration(days: 1),
        dialogStyle:  Platform.isIOS?UpgradeDialogStyle.cupertino:UpgradeDialogStyle.material
      ),
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: ThemeStyles.darkred,
          ),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  Future checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int logStatus = prefs.getInt('loginStatus');

    if (logStatus != null) {
      AppFuture.checkConnection(context).then((value) {
        AppFuture.refreshToken(context, prefs.getString("user_id"))
            .then((tokenValue) {
          if (tokenValue != null) {
            HeaderInterceptor.V4_AUTH_HEADER = tokenValue;
            AppFuture.getDataForUserHome(context, 0);
          }
        });
      });
    } else {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Login()),
          (route) => false,
        );
      });
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkLogin();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        backgroundColor: ThemeStyles.offWhite,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: -ThemeStyles.setFullWidth() * 0.3,
              top: -ThemeStyles.setFullWidth() * 0.2,
              child: DoubleShadowContainer(
                width: ThemeStyles.setFullWidth() * 0.72,
                height: ThemeStyles.setFullWidth() * 0.72,
                padding: 0,
                shadWidth: 100,
                shadOpacity: 0.15,
                borderRadius: ThemeStyles.setFullWidth() * 0.65,
                child: null,
                borderColor: ThemeStyles.white.withOpacity(0.5),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(
                  child: Column(
                    children: [
                      DoubleShadowContainer(
                        width: ThemeStyles.setWidth(120),
                        height: ThemeStyles.setWidth(120),
                        padding: 25,
                        shadWidth: 25,
                        shadOpacity: 0.3,
                        borderRadius: ThemeStyles.setWidth(120),
                        child: Image.asset("assets/images/logo.png"),
                        borderColor: ThemeStyles.white.withOpacity(0.5),
                      ),
                      ThemeStyles.space(),
                      ThemeStyles.quartSpace(),
                      Text(
                        AppLocalizations.of(context).translate("english") +
                            AppLocalizations.of(context).translate("indust"),
                        style: ThemeStyles.regularStyle().copyWith(
                          color: ThemeStyles.grey,
                          fontSize: ThemeStyles.setWidth(17),
                        ),
                      ),
                      ThemeStyles.space(),
                      Text(
                        AppLocalizations.of(context).translate("grow"),
                        style: ThemeStyles.regularStyle().copyWith(
                          color: ThemeStyles.red,
                          fontSize: ThemeStyles.setWidth(11),
                        ),
                      ),
                      ThemeStyles.halfSpace(),
                      Text(
                        "LEARN ENGLISH",
                        style: ThemeStyles.regularStyle().copyWith(
                            color: ThemeStyles.red,
                            fontSize: ThemeStyles.setWidth(17)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: -ThemeStyles.setFullWidth() * 0.5,
              bottom: ThemeStyles.setHeight(20),
              child: DoubleShadowContainer(
                width: ThemeStyles.setFullWidth() * 0.7,
                height: ThemeStyles.setFullWidth() * 0.7,
                padding: 0,
                shadWidth: 100,
                shadOpacity: 0.15,
                borderRadius: ThemeStyles.setFullWidth() * 0.65,
                child: null,
                borderColor: ThemeStyles.white.withOpacity(0.5),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.all(ThemeStyles.setWidth(20)),
                  decoration: ThemeStyles.doubleShadowDecoration(
                          0, 0.3, ThemeStyles.setFullWidth() * 0.65)
                      .copyWith(
                    border: Border.all(
                      color: ThemeStyles.lightRed.withOpacity(0.15),
                      width: ThemeStyles.setWidth(6),
                    ),
                  ),
                  child: DoubleShadowContainer(
                    width: ThemeStyles.setWidth(100),
                    height: ThemeStyles.setWidth(100),
                    padding: 0,
                    shadWidth: 25,
                    shadOpacity: 0.3,
                    borderRadius: ThemeStyles.setFullWidth() * 0.65,
                    borderColor: ThemeStyles.white.withOpacity(0.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context).translate("english"),
                          style: ThemeStyles.regularStyle().copyWith(
                            color: ThemeStyles.red,
                            height: 1.4,
                            fontSize: ThemeStyles.setWidth(13),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context).translate("courses"),
                          style: ThemeStyles.regularStyle().copyWith(
                            color: ThemeStyles.red,
                            height: 1.4,
                            fontSize: ThemeStyles.setWidth(13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Navigator.of(context).pop();

// Navigator.of(context, rootNavigator: true).pop();

// Navigator.of(context).push(
//   MaterialPageRoute(
//     builder: (context) => UserStartPage(),
//   ),
// );

// Navigator.of(context).push(
//                       CupertinoPageRoute(
//                         builder: (context) => SlidePageTwo(),
//                       ),
//        );

// Navigator.pushAndRemoveUntil(
//   context,
//   MaterialPageRoute(
//     builder: (BuildContext context) => ChefKitchen(),
//   ),
//       (route) => false,
// );

// Navigator.of(context).push(PageRouteBuilder(
//     pageBuilder: (context, animation, _) {
//       return UserHome();
//     },
//     opaque: true));


// Navigator.push(
//                                             context,
//                                             PageRouteBuilder(
//                                                 opaque: false,
//                                                 transitionsBuilder: (context,
//                                                     animation,
//                                                     animationTime,
//                                                     child) {
//                                                   animation = CurvedAnimation(
//                                                       parent: animation,
//                                                       curve: Curves.easeIn);
//                                                   // return SlideTransition(
//                                                   //   position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(animation),
//                                                   //   child: child,
//                                                   // );

//                                                   //return ScaleTransition(scale: animation,child: child,alignment: Alignment.center,);
//                                                   return FadeTransition(
//                                                     child: child,
//                                                     opacity: animation,
//                                                   );
//                                                 },
//                                                 transitionDuration:
//                                                     Duration(milliseconds: 300),
//                                                 pageBuilder: (context,
//                                                     animation, animationTime) {
//                                                   return UserSignin();
//                                                 }));



// Navigator.push(context,
//   PageRouteBuilder(
//       transitionsBuilder: (context, animation, animationTime, child){
//         animation = CurvedAnimation(parent: animation, curve: Curves.elasticOut);
//         // return ScaleTransition(scale: animation,child: child,alignment: Alignment.center,);
//         return FadeTransition(child: child,opacity: animation,);
//            // return SlideTransition(
//            //       position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(animation),
//              //       child: child,
//              //     );
//        },
//       transitionDuration:Duration(seconds: 4) ,
//       pageBuilder: (context , animation, animationTime){
//         return UserHome();
//       }
//   )
// );

 




// Navigator.of(context).push(
//   MaterialPageRoute(
//     builder: (context) => UserData(),
//   ),
// );

// if (Navigator.canPop(context)) {
//   Navigator.pop(context);
// } else {
//   SystemNavigator.pop();
// }

