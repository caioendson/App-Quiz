import 'package:dio/dio.dart';

class RealtimeDBApi {
  static Dio api =
      new Dio(BaseOptions(baseUrl: 'https://educa-iot.firebaseio.com'));
}
