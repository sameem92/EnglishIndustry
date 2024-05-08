import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:englishindustry/data/data_api_service.dart';
import 'package:englishindustry/data/header_interceptor.dart';
import 'package:englishindustry/model/addcomment.dart';
import 'package:englishindustry/model/addrate.dart';
import 'package:englishindustry/model/autherizetoken.dart';
import 'package:englishindustry/model/deleteaccount.dart';
import 'package:englishindustry/model/faq.dart';
import 'package:englishindustry/model/favourite.dart';
import 'package:englishindustry/model/finishtask.dart';
import 'package:englishindustry/model/getactivecode.dart';
import 'package:englishindustry/model/getallcomment.dart';
import 'package:englishindustry/model/gethome.dart';
import 'package:englishindustry/model/getkidshome.dart';
import 'package:englishindustry/model/getuserhome.dart';
import 'package:englishindustry/model/googlesignin.dart';
import 'package:englishindustry/model/kidsmyweeks.dart';
import 'package:englishindustry/model/getkidsuserhome.dart';
import 'package:englishindustry/model/kidsweekdaycontent.dart';
import 'package:englishindustry/model/like.dart';
import 'package:englishindustry/model/logout.dart';
import 'package:englishindustry/model/myfavourites.dart';
import 'package:englishindustry/model/myweeks.dart';
import 'package:englishindustry/model/profile.dart';
import 'package:englishindustry/model/refreshtoken.dart';
import 'package:englishindustry/model/search.dart';
import 'package:englishindustry/model/setting.dart';
import 'package:englishindustry/model/subscripe.dart';
import 'package:englishindustry/model/terms.dart';
import 'package:englishindustry/model/weekdaycontent.dart';
import 'package:englishindustry/model/words.dart';
import 'package:englishindustry/pages/splash_page.dart';
import 'package:englishindustry/pages/user_home_page.dart';
import 'package:englishindustry/utility/app_localizations.dart';
import 'package:englishindustry/utility/constants.dart';
import 'package:http/http.dart' as http;
import 'package:englishindustry/utility/theme_styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/login_page.dart';

abstract class AppFuture {
  static customToast(String title) {
    Fluttertoast.showToast(
      backgroundColor: ThemeStyles.red,
      textColor: ThemeStyles.offWhite,
      msg: title,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }

  static Future<String> getActiveCode(
      BuildContext context, String phone) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    final Response<ActiveCodeModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .getActiveCode(phone);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      if (statusCode == "200") {
        debugPrint(map["data"]["activationcode"].toString());
        return map["data"]["activationcode"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> autherize(
      BuildContext context, String phone, String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final Response<AutherizeTokenModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .authorizeAndGetToken(phone, code);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      if (statusCode == "200") {
        HeaderInterceptor.V4_AUTH_HEADER = map["access_token"];
        prefs.setString("token", map["access_token"].toString());
        prefs.setString("phone", phone.toString());
        prefs.setInt("loginStatus", 0);
        prefs.setString("user_id", map["data"]["user_id"].toString());

        debugPrint(map["access_token"].toString());

        return map["access_token"].toString();
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> refreshToken(
      BuildContext context, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final Response<RefreshTokenModel> response =
          await Provider.of<DataApiService>(context, listen: false)
              .refreshToken(userId);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.bodyString);
        String statusCode = map["code"];
        if (statusCode == "200") {
          HeaderInterceptor.V4_AUTH_HEADER = map["access_token"];
          prefs.setString("token", map["access_token"].toString());
          debugPrint(map["access_token"].toString());
          return map["access_token"].toString();
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      prefs.clear().then((value) {
        if (value) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false,
          );
        }
      });
    }
  }

  static Future<dynamic> getProfile(BuildContext context) async {
    final Response<ProfileModel> response =
        await Provider.of<DataApiService>(context, listen: false).getProfile();
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["data"].toString());
      if (statusCode == "200") {
        return map["data"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<bool> deleteAccount(BuildContext context) async {
    final Response<DeleteAccountModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .deleteAccount();
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["data"].toString());
      if (statusCode == "200") {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<dynamic> getMyweeks(BuildContext context) async {
    final Response<MyWeeksModel> response =
        await Provider.of<DataApiService>(context, listen: false).getMyWeeks();
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["data"].toString());
      if (statusCode == "200") {
        return map["data"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> getKidsMyWeeks(BuildContext context) async {
    final Response<KidsMyWeeks> response =
        await Provider.of<DataApiService>(context, listen: false)
            .getKidsMyWeeks();
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["data"].toString());
      if (statusCode == "200") {
        return map["data"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> getUserHomeData(
      BuildContext context, String currentWeek) async {
    final Response<UserHomeModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .getUserHomeData(currentWeek);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["data"].toString());
      if (statusCode == "200") {
        return map["data"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> getHomeData(BuildContext context) async {
    final Response<HomeModel> response =
        await Provider.of<DataApiService>(context, listen: false).getHomeData();
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["data"].toString());
      if (statusCode == "200") {
        return map["data"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> getKidsUserHomeData(
      BuildContext context, String currentWeek) async {
    final Response<KidsUserHomeModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .getKidsUserHomeData(currentWeek);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["data"].toString());
      if (statusCode == "200") {
        return map["data"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> getKidsHomeData(BuildContext context) async {
    final Response<KidsHomeModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .getKidsHomeData();
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["data"].toString());
      if (statusCode == "200") {
        return map["data"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static void goLogin(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const MainProvider(),
      ),
      (route) => false,
    );
  }

  static Future<dynamic> getWeekDayData(
      BuildContext context, String weekDayId) async {
    final Response<WeekDayContentModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .getWeekDayData(weekDayId);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["data"].toString());
      if (statusCode == "200") {
        return map["data"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> getKidsWeekDayData(
      BuildContext context, String weekDayId) async {
    final Response<KidsWeekDayContentModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .getKidsWeekDayData(weekDayId);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["data"].toString());
      if (statusCode == "200") {
        return map["data"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> finishTask(
      BuildContext context,
      String type,
      String weekDayId,
      String correctAnswers,
      String wrongAnswers,
      String ratio) async {
    final Response<FinishTaskModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .finishTask(type, weekDayId, correctAnswers, wrongAnswers, ratio);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["message"].toString());
      if (statusCode == "200") {
        return map["message"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> addRate(
    BuildContext context,
    String lessonId,
    String rate,
  ) async {
    final Response<AddRateModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .addRate(lessonId, rate);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["message"].toString());
      if (statusCode == "200") {
        return map["message"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> addComment(
    BuildContext context,
    String lessonId,
    String comment,
  ) async {
    final Response<AddCommentModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .addComment(lessonId, comment);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["message"].toString());
      if (statusCode == "200") {
        return map["message"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> likeVideo(
    BuildContext context,
    String lessonId,
  ) async {
    final Response<LikeModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .likeVideo(lessonId);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["message"].toString());
      if (statusCode == "200") {
        return map;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

   static Future<dynamic> subscripe(
    BuildContext context,
    String subscriptionPlanId,
  ) async {
    final Response<SubscribeModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .subscripe(subscriptionPlanId);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["message"].toString());
      if (statusCode == "200") {
        return map;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> searchKeyword(
    BuildContext context,
    String keyword,
  ) async {
    final Response<SearchModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .searchKeyword(keyword);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["data"].toString());
      if (statusCode == "200") {
        return map["data"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> getAllComments(
    BuildContext context,
    String lessonId,
  ) async {
    final Response<AllCommentsModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .getAllComments(lessonId);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["data"].toString());
      if (statusCode == "200") {
        return map["data"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> addFavourite(
    BuildContext context,
    String lessonId,
  ) async {
    final Response<FavouriteModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .addFavourite(lessonId);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["message"].toString());
      if (statusCode == "200") {
        return map;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> signInWthEmail(
    BuildContext context,
    String email,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Response<GoogleSignInModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .signInWthGoogle(email);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      if (statusCode == "200") {
        HeaderInterceptor.V4_AUTH_HEADER = map["access_token"];
        prefs.setString("token", map["access_token"].toString());
        prefs.setString("user_id", map["data"]["user_id"].toString());
        prefs.setInt("loginStatus", 1);
        prefs.setString("email", email);
        debugPrint(map["access_token"].toString());
        return map["access_token"].toString();


      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> getMyFavourites(
    BuildContext context,
  ) async {
    final Response<MyFavouritesModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .getMyFavourites();
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["data"].toString());
      if (statusCode == "200") {
        return map["data"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> getFAQS(
    BuildContext context,
  ) async {
    final Response<FAQModel> response =
        await Provider.of<DataApiService>(context, listen: false).getFAQs();
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["data"].toString());
      if (statusCode == "200") {
        return map["data"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> getTerms(
    BuildContext context,
  ) async {
    HeaderInterceptor.LANG = AppConstants.langCode;
    final Response<TermsModel> response =
        await Provider.of<DataApiService>(context, listen: false).getTerms();
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["data"].toString());
      if (statusCode == "200") {
        return map["data"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> getWordsById(
    BuildContext context,
    String id,
  ) async {
    final Response<WordsModel> response =
        await Provider.of<DataApiService>(context, listen: false)
            .getWordsById(id);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["data"].toString());
      if (statusCode == "200") {
        return map["data"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> getSetting(
    BuildContext context,
  ) async {
    final Response<SettingModel> response =
        await Provider.of<DataApiService>(context, listen: false).getSetting();
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.bodyString);
      String statusCode = map["code"];
      debugPrint(map["data"].toString());
      if (statusCode == "200") {
        return map["data"];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static getDataForUserHome(BuildContext context, int strtPageIndex) {
    AppFuture.checkConnection(context).then((value) {
      if (value) {
        AppFuture.getProfile(context).then(
          (profileData) {
            if (profileData != null) {
              AppFuture.getUserHomeData(context,
                      profileData["settings"]["current_week"].toString())
                  .then(
                (homeData) {
                  if (homeData != null) {
                    AppFuture.getKidsMyWeeks(context).then((kMyWeeks) {
                      if (kMyWeeks != null) {
                        AppFuture.getKidsUserHomeData(
                                context, kMyWeeks.length.toString())
                            .then((kHomeData) {
                          if (kHomeData != null) {
                            AppFuture.getMyweeks(context).then((myWeeks) {
                              if (myWeeks != null) {                                
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => UserHome(
                                      myWeeks: myWeeks,
                                      userProfileData: profileData,
                                      userHomeData: homeData,
                                      kidsHomeData: kHomeData,
                                      kidsMyWeeks: kMyWeeks,
                                      strtPageIndex: strtPageIndex,
                                      isUserHome: true,
                                    ),
                                  ),
                                  (route) => false,
                                );
                              }
                            });
                          }
                        });
                      }
                    });
                  }
                },
              );
            }
          },
        );
      } else {
        AppFuture.customToast(
            AppLocalizations.of(context).translate("checkInternet"));
      }
    });
  }

  static getDataForHome(BuildContext context, int strtPageIndex) {
    AppFuture.checkConnection(context).then((value) {
      if (value) {
        AppFuture.getHomeData(context).then(
          (homeData) {
            if (homeData != null) {
              AppFuture.getKidsMyWeeks(context).then((kMyWeeks) {
                if (kMyWeeks != null) {
                  AppFuture.getKidsUserHomeData(
                          context, kMyWeeks.length.toString())
                      .then((kHomeData) {
                    if (kHomeData != null) {
                      AppFuture.getMyweeks(context).then((myWeeks) {
                        if (myWeeks != null) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => UserHome(
                                myWeeks: myWeeks,
                                userProfileData: null,
                                userHomeData: homeData,
                                kidsHomeData: kHomeData,
                                kidsMyWeeks: kMyWeeks,
                                strtPageIndex: strtPageIndex,
                                isUserHome: true,
                              ),
                            ),
                            (route) => false,
                          );
                        }
                      });
                    }
                  });
                }
              });
            }
          },
        );
      } else {
        AppFuture.customToast(
            AppLocalizations.of(context).translate("checkInternet"));
      }
    });
  }

  static Future logout(BuildContext context) async {
    final Response<LogOutModel> response =
        await Provider.of<DataApiService>(context, listen: false).logout();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateUserImageData(
    String imgPath,
    String uName,
  ) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(DataApiService.baseUrl + "/updateprofile"));

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer " + HeaderInterceptor.V4_AUTH_HEADER,
    };

    request.fields['name'] = uName;

    request.files.add(await http.MultipartFile.fromPath('image', imgPath));



    request.headers.addAll(headers);

    var res = await request.send();

    final responseJson = await http.Response.fromStream(res);
    //Map<String, dynamic> map = json.decode(responseJson.body);

    debugPrint(responseJson.body);
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateUserName(
    String uName,
  ) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(DataApiService.baseUrl + "/updateprofile"));

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer " + HeaderInterceptor.V4_AUTH_HEADER
    };

    request.fields['name'] = uName;

    request.headers.addAll(headers);

    var res = await request.send();

    final responseJson = await http.Response.fromStream(res);
    //Map<String, dynamic> map = json.decode(responseJson.body);

    debugPrint(responseJson.body);
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> checkConnection(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
