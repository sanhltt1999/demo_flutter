import 'package:dio/dio.dart';

abstract class Httpservices {
  void init();

  Future<Response> getRequest(String url);
}
