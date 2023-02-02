import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/constants/app_strings.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/data/web_services/character_web_service.dart';

class CharactersRepository extends Equatable {
  final CharacterWebService _characterWebService;

  const CharactersRepository(this._characterWebService);

  Future<List<Character>> getAllCharacters() async {
    try {
      final results = await _characterWebService.getAllCharacters();

      return results.map((character) => Character.fromJson(character)).toList();
    } catch (error) {
      printK(error.toString());
      printK("ERROR");
      return [];
    }
  }

  @override
  List<Object> get props => [_characterWebService];
}
