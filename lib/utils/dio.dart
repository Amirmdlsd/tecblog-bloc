import 'package:dio/dio.dart';
import 'package:tecblog/di/di.dart';

class DioService {
  static Dio postDio = Dio(BaseOptions(
      baseUrl: "https://techblog.sasansafari.com/", ));
}
