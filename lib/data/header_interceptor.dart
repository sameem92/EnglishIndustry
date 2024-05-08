// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'package:chopper/chopper.dart';

class HeaderInterceptor implements RequestInterceptor {
  // 1
  static const String AUTH_HEADER = "Authorization";
  // 2
  static const String BEARER = "Bearer ";
  // 3
  static const String LANGUAGE = "Accept-Language";

  // ignore: non_constant_identifier_names
  static String V4_AUTH_HEADER = "";
  // ignore: non_constant_identifier_names
  static String LANG = "";

  @override
  FutureOr<Request> onRequest(Request request) async {
    // 5
    Request newRequest = request.copyWith(
        headers: {AUTH_HEADER: BEARER + V4_AUTH_HEADER, LANGUAGE: LANG});
    return newRequest;
  }
}
