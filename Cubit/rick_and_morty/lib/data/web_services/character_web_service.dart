import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rick_and_morty/constants/app_strings.dart';

const String characters = 'character';

class CharacterWebService extends Equatable {
  late final Dio dio;

  CharacterWebService() {
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

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get(characters);
      return response.data;
    } catch (error) {
      printK(error.toString());
      return [];
    }
  }

  @override
  List<Object> get props => [dio];
}
