import 'package:chopper/chopper.dart';
import 'package:englishindustry/data/header_interceptor.dart';
import 'package:englishindustry/data/model_converter.dart';
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

part 'data_api_service.chopper.dart';

@ChopperApi(baseUrl: '/db.json')
abstract class DataApiService extends ChopperService {
  static String imagebaseUrl = 'https://enindustry.com/users/images/';

  static String videobaseUrl = 'https://enindustry.com/users/videos/';

  static String baseUrl = 'https://enindustry.com/api/v2';

  // @Post()
  // @FactoryConverter(
  //   request: FormUrlEncodedConverter.requestFactory,
  // )
  // Future<Response<DataModel>> getData(
  //   @Field('path_id') String pathId,
  //   @Field('stage_id') String stageId,
  //   @Field('class_id') String classId,
  //   @Field('term_id') String termId,
  // );

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<ActiveCodeModel>> getActiveCode(
    @Field('phone') String phone,
  );

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<AutherizeTokenModel>> authorizeAndGetToken(
    @Field('phone') String phone,
    @Field('code') String code,
  );

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<RefreshTokenModel>> refreshToken(   
    @Field('user_id') String userId,
  );

  

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<LogOutModel>> logout();

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<ProfileModel>> getProfile();

  
  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<DeleteAccountModel>> deleteAccount();

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<SettingModel>> getSetting();

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<MyWeeksModel>> getMyWeeks();

   @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<KidsMyWeeks>> getKidsMyWeeks();

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<MyFavouritesModel>> getMyFavourites();

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<FAQModel>> getFAQs();

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<TermsModel>> getTerms();

  @Get(path: "/{id}")
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<WordsModel>> getWordsById(@Path("id") String id);

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<UserHomeModel>> getUserHomeData(
    @Field('week') String currentWeek,
  );

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<HomeModel>> getHomeData();

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<KidsUserHomeModel>> getKidsUserHomeData(
    @Field('week') String currentWeek,
  );

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<KidsHomeModel>> getKidsHomeData(   
  );

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<WeekDayContentModel>> getWeekDayData(
    @Field('weekday') String weekDayId,
  );

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<KidsWeekDayContentModel>> getKidsWeekDayData(
    @Field('weekday') String weekDayId,
  );

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<FinishTaskModel>> finishTask(
    @Field('type') String type,
    @Field('weekday') String weekDayId,
    @Field('correctanswers') String correctAnswers,
    @Field('wronganswers') String wrongAnswers,
    @Field('ratio') String ratio,
  );

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<AddRateModel>> addRate(
    @Field('lesson') String lessonId,
    @Field('rate') String rate,
  );

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<AddCommentModel>> addComment(
    @Field('lesson') String lessonId,
    @Field('comment') String comment,
  );

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<LikeModel>> likeVideo(
    @Field('lesson') String lessonId,
  );

  
  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<SubscribeModel>> subscripe(
    @Field('lesson') String lessonId,
  );



  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<SearchModel>> searchKeyword(
    @Field('keyword') String keyword,
  );

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<AllCommentsModel>> getAllComments(
    @Field('lesson_id') String lessonId,
  );

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<GoogleSignInModel>> signInWthGoogle(
    @Field('email') String lessonId,
  );

  @Post()
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response<FavouriteModel>> addFavourite(
    @Field('lesson') String lessonId,
  );

  static DataApiService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: baseUrl,
      services: [
        // The generated implementation
        _$DataApiService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: ModelConverter(),
      errorConverter: const JsonConverter(),
      interceptors: [HttpLoggingInterceptor(), HeaderInterceptor()],
    );

    // The generated class with the ChopperClient passed in
    return _$DataApiService(client);
  }
}
