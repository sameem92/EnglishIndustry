// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$DataApiService extends DataApiService {
  _$DataApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = DataApiService;

  // @override
  // Future<Response<DataModel>> getData(
  //   String pathId,
  //   String stageId,
  //   String classId,
  //   String termId,
  // ) {
  //   Map<String, String> parameters = {
  //     'path_id': pathId,
  //     'stage_id': stageId,
  //     'class_id': classId,
  //     'term_id': termId,
  //   };
  //   final $url = '/data';
  //   final $request =
  //       Request('POST', $url, client.baseUrl, parameters: parameters);
  //   return client.send<DataModel, DataModel>($request);
  // }

  @override
  Future<Response<ActiveCodeModel>> getActiveCode(
    String phone,
  ) {
    Map<String, String> parameters = {
      'phone': phone,
    };
    final $url = '/loginwithphone';
    final $request =
        Request('POST', $url, client.baseUrl, parameters: parameters);
    return client.send<ActiveCodeModel, ActiveCodeModel>($request);
  }

  @override
  Future<Response<AutherizeTokenModel>> authorizeAndGetToken(
    String phone,
    String code,
  ) {
    Map<String, String> parameters = {'phone': phone, 'code': code};
    final $url = '/codeActivation';
    final $request =
        Request('POST', $url, client.baseUrl, parameters: parameters);
    return client.send<AutherizeTokenModel, AutherizeTokenModel>($request);
  }

  @override
  Future<Response<RefreshTokenModel>> refreshToken(
    String userID,    
  ) {
    Map<String, String> parameters = {'user_id': userID, };
    final $url = '/refreshtoken';
    final $request =
        Request('POST', $url, client.baseUrl, parameters: parameters);
    return client.send<RefreshTokenModel, RefreshTokenModel>($request);
  }

  @override
  Future<Response<LogOutModel>> logout() {
    final $url = '/logout';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<LogOutModel, LogOutModel>($request);
  }

  @override
  Future<Response<ProfileModel>> getProfile() {
    final $url = '/profile';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<ProfileModel, ProfileModel>($request);
  }

    @override
  Future<Response<DeleteAccountModel>> deleteAccount() {
    final $url = '/delete_account';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<DeleteAccountModel, DeleteAccountModel>($request);
  }

  @override
  Future<Response<SettingModel>> getSetting() {
    final $url = '/settings';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<SettingModel, SettingModel>($request);
  }

  @override
  Future<Response<MyWeeksModel>> getMyWeeks() {
    final $url = '/myweeks';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<MyWeeksModel, MyWeeksModel>($request);
  }

  @override
  Future<Response<KidsMyWeeks>> getKidsMyWeeks() {
    final $url = '/kids_myweeks';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<KidsMyWeeks, KidsMyWeeks>($request);
  }

  @override
  Future<Response<MyFavouritesModel>> getMyFavourites() {
    final $url = '/myfavourites';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<MyFavouritesModel, MyFavouritesModel>($request);
  }

  @override
  Future<Response<FAQModel>> getFAQs() {
    final $url = '/faq';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<FAQModel, FAQModel>($request);
  }

  @override
  Future<Response<TermsModel>> getTerms() {
    final $url = '/terms';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<TermsModel, TermsModel>($request);
  }

  @override
  Future<Response<WordsModel>> getWordsById(String id) {
    final $url = '/words/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<WordsModel, WordsModel>($request);
  }

  @override
  Future<Response<UserHomeModel>> getUserHomeData(
    String currentWeek,
  ) {
    Map<String, String> parameters = {'week': currentWeek};
    final $url = '/home';
    final $request =
        Request('POST', $url, client.baseUrl, parameters: parameters);
    return client.send<UserHomeModel, UserHomeModel>($request);
  }

  @override
  Future<Response<HomeModel>> getHomeData() {
    final $url = '/home2';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<HomeModel, HomeModel>($request);
  }

  @override
  Future<Response<KidsUserHomeModel>> getKidsUserHomeData(
    String currentWeek,
  ) {
    Map<String, String> parameters = {'week': currentWeek};
    final $url = '/kids_home';
    final $request =
        Request('POST', $url, client.baseUrl, parameters: parameters);
    return client.send<KidsUserHomeModel, KidsUserHomeModel>($request);
  }

  @override
  Future<Response<KidsHomeModel>> getKidsHomeData() {
    final $url = '/kids_home2';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<KidsHomeModel, KidsHomeModel>($request);
  }

  @override
  Future<Response<WeekDayContentModel>> getWeekDayData(
    String weekDayId,
  ) {
    Map<String, String> parameters = {'weekday': weekDayId};
    final $url = '/weekdaycontent';
    final $request =
        Request('POST', $url, client.baseUrl, parameters: parameters);
    return client.send<WeekDayContentModel, WeekDayContentModel>($request);
  }

  @override
  Future<Response<KidsWeekDayContentModel>> getKidsWeekDayData(
    String weekDayId,
  ) {
    Map<String, String> parameters = {'weekday': weekDayId};
    final $url = '/kids_weekdaycontent';
    final $request =
        Request('POST', $url, client.baseUrl, parameters: parameters);
    return client
        .send<KidsWeekDayContentModel, KidsWeekDayContentModel>($request);
  }

  @override
  Future<Response<FinishTaskModel>> finishTask(
    String type,
    String weekdayId,
    String correctAnswers,
    String wrongAnswers,
    String ratio,
  ) {
    Map<String, String> parameters = {
      'type': type,
      'weekday': weekdayId,
      'correctanswers': correctAnswers,
      'wronganswers': correctAnswers,
      'ratio': ratio
    };
    final $url = '/finishtask';
    final $request =
        Request('POST', $url, client.baseUrl, parameters: parameters);
    return client.send<FinishTaskModel, FinishTaskModel>($request);
  }

  @override
  Future<Response<AddRateModel>> addRate(
    String lessonId,
    String rate,
  ) {
    Map<String, String> parameters = {'lesson': lessonId, 'rate': rate};
    final $url = '/addrate';
    final $request =
        Request('POST', $url, client.baseUrl, parameters: parameters);
    return client.send<AddRateModel, AddRateModel>($request);
  }

  @override
  Future<Response<AddCommentModel>> addComment(
    String lessonId,
    String comment,
  ) {
    Map<String, String> parameters = {'lesson': lessonId, 'comment': comment};
    final $url = '/addcomment';
    final $request =
        Request('POST', $url, client.baseUrl, parameters: parameters);
    return client.send<AddCommentModel, AddCommentModel>($request);
  }

  @override
  Future<Response<LikeModel>> likeVideo(
    String lessonId,
  ) {
    Map<String, String> parameters = {
      'lesson': lessonId,
    };
    final $url = '/like';
    final $request =
        Request('POST', $url, client.baseUrl, parameters: parameters);
    return client.send<LikeModel, LikeModel>($request);
  }

    @override
  Future<Response<SubscribeModel>> subscripe(
    String subscriptionPlanId,
  ) {
    Map<String, String> parameters = {
      'subscription_plan': subscriptionPlanId,
    };
    final $url = '/subscription';
    final $request =
        Request('POST', $url, client.baseUrl, parameters: parameters);
    return client.send<SubscribeModel, SubscribeModel>($request);
  }

  @override
  Future<Response<SearchModel>> searchKeyword(
    String keyword,
  ) {
    Map<String, String> parameters = {
      'keyword': keyword,
    };
    final $url = '/search';
    final $request =
        Request('POST', $url, client.baseUrl, parameters: parameters);
    return client.send<SearchModel, SearchModel>($request);
  }

  @override
  Future<Response<AllCommentsModel>> getAllComments(
    String lessonId,
  ) {
    Map<String, String> parameters = {
      'lesson_id': lessonId,
    };
    final $url = '/comments';
    final $request =
        Request('POST', $url, client.baseUrl, parameters: parameters);
    return client.send<AllCommentsModel, AllCommentsModel>($request);
  }

  @override
  Future<Response<GoogleSignInModel>> signInWthGoogle(
    String email,
  ) {
    Map<String, String> parameters = {
      'email': email,
    };
    final $url = '/loginwithgoogle';
    final $request =
        Request('POST', $url, client.baseUrl, parameters: parameters);
    return client.send<GoogleSignInModel, GoogleSignInModel>($request);
  }

  @override
  Future<Response<FavouriteModel>> addFavourite(
    String lessonId,
  ) {
    Map<String, String> parameters = {
      'lesson': lessonId,
    };
    final $url = '/favourite';
    final $request =
        Request('POST', $url, client.baseUrl, parameters: parameters);
    return client.send<FavouriteModel, FavouriteModel>($request);
  }
}
