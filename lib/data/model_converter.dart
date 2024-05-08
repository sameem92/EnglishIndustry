import 'dart:convert';
import 'package:chopper/chopper.dart';
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
import 'package:englishindustry/model/getkidsuserhome.dart';
import 'package:englishindustry/model/googlesignin.dart';
import 'package:englishindustry/model/kidsmyweeks.dart';
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
import 'package:flutter/material.dart';

class ModelConverter implements Converter {
  @override
  Request convertRequest(Request request) {
    final req = applyHeader(
      request,
      contentTypeKey,
      jsonHeaders,
      override: false,
    );
    return encodeJson(req);
  }

  Request encodeJson(Request request) {
    var contentType = request.headers[contentTypeKey];
    if (contentType != null && contentType.contains(jsonHeaders)) {
      return request.copyWith(body: json.encode(request.body));
    }
    return request;
  }

  // ignore: missing_return
  Response decodeJson<BodyType, InnerType>(Response response) {
    var contentType = response.headers[contentTypeKey];
    var body = response.body;
    String url = response.base.request.url.path;
    debugPrint(url);
    if (contentType != null && contentType.contains(jsonHeaders)) {
      body = utf8.decode(response.bodyBytes);
    }
    try {
      var mapData = json.decode(body);

      if (url.contains("/words/")) {
        var data = WordsModel.fromJson(mapData);
        return response.copyWith<BodyType>(body: data as BodyType);
      }

      switch (url) {
        case '/api/v2/loginwithphone':
          var data = ActiveCodeModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/codeActivation':
          var data = AutherizeTokenModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/refreshtoken':
          var data = RefreshTokenModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/logout':
          var data = LogOutModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/profile':
          var data = ProfileModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;
        
        case '/api/v2/delete_account':
          var data = DeleteAccountModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/settings':
          var data = SettingModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/myweeks':
          var data = MyWeeksModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/kids_myweeks':
          var data = KidsMyWeeks.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/home':
          var data = UserHomeModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/home2':
          var data = HomeModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/weekdaycontent':
          var data = WeekDayContentModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/kids_weekdaycontent':
          var data = KidsWeekDayContentModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/kids_home':
          var data = KidsUserHomeModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/kids_home2':
          var data = KidsHomeModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/finishtask':
          var data = FinishTaskModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/addrate':
          var data = AddRateModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/like':
          var data = LikeModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;
        
        case '/api/v2/subscription':
          var data = SubscribeModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/favourite':
          var data = FavouriteModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/addcomment':
          var data = AddCommentModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/comments':
          var data = AllCommentsModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/myfavourites':
          var data = MyFavouritesModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/faq':
          var data = FAQModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/terms':
          var data = TermsModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/search':
          var data = SearchModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;

        case '/api/v2/loginwithgoogle':
          var data = GoogleSignInModel.fromJson(mapData);
          return response.copyWith<BodyType>(body: data as BodyType);
          break;
      }
    } catch (e) {
      chopperLogger.warning(e);
      return response.copyWith<BodyType>(body: body);
    }
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return decodeJson<BodyType, InnerType>(response);
  }
}
