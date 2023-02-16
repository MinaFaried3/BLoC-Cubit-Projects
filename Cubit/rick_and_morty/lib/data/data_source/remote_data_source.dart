import 'package:dio/dio.dart';
import 'package:rick_and_morty/constants/app_strings.dart';
import 'package:rick_and_morty/data/web_services/character_web_service.dart';

abstract class RemoteDataSource {
  Future<List> getAllCharacters();
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final CharacterWebService _characterWebService;

  RemoteDataSourceImpl(this._characterWebService);

  @override
  Future<List> getAllCharacters() async {
    Response response = await _characterWebService.get(charactersUrl);
    if (response.statusCode != 200) throw Exception();
    printK(response.data.toString());
    printK("RESPONSE");
    return response.data['results'];
  }
}
