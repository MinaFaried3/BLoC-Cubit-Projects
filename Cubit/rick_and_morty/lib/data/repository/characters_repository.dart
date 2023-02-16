import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/constants/app_strings.dart';
import 'package:rick_and_morty/data/data_source/remote_data_source.dart';
import 'package:rick_and_morty/data/models/character_model.dart';

class CharactersRepository extends Equatable {
  final RemoteDataSource _remoteDataSource;

  const CharactersRepository(this._remoteDataSource);

  Future<List<Character>> getAllCharacters() async {
    try {
      final results = await _remoteDataSource.getAllCharacters();
      return results.map((character) => Character.fromJson(character)).toList();
    } catch (error) {
      printK(error.toString());
      printK("ERROR");
      return [];
    }
  }

  @override
  List<Object> get props => [_remoteDataSource];
}
