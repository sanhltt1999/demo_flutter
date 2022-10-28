import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:getx_user/service/http_services.dart';

const BASE_URL = "https://635a8eeb6f97ae73a6307501.mockapi.io/";

class HttpServicesImpl implements Httpservices {
  late Dio _dio;

  HttpServicesImpl() {
    init();
    initializeInterceptor();
  }

  @override
  Future<Response> getRequest(String url) async {
    Response response;
    try {
      response = await _dio.get(url);
    } on DioError catch (e) {
      throw Exception(e.message);
    } on Exception catch (e) {
      throw Exception(e);
    }
    return response;
  }

  initializeInterceptor() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      log("${options.method} | ${options.path}");
      return handler.next(options);
    }, onResponse: (response, handler) {
      log("${response.statusCode} ${response.statusMessage} ${response.data}");
      return handler.next(response);
    }, onError: (DioError e, handler) {
      log(e.message);
      return handler.next(e);
    }));
  }

  @override
  void init() {
    _dio = Dio(BaseOptions(baseUrl: BASE_URL));
    initializeInterceptor();
  }
}
