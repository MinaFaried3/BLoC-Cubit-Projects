import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rick_and_morty/constants/app_strings.dart';

abstract class CharacterWebService extends Equatable {
  Future<Response> get(String url);
}

class CharacterWebServiceImpl extends CharacterWebService {
  late final Dio dio;

  CharacterWebServiceImpl() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000);

    dio = Dio(baseOptions);

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
  }

  @override
  List<Object> get props => [dio];

  @override
  Future<Response> get(String url) async {
    final response = await dio.get(url);
    //if(response.statusCode == 401) _goToLoginPage();
    return response;
  }
}
