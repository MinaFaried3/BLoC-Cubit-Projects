import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/data/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository _charactersRepository;

  CharactersCubit(this._charactersRepository) : super(CharactersInitial());

  late final List<Character> _characters;
  late List<Character> _searchedCharacters;
  bool isSearch = false;

  Future<List<Character>> getAllCharacters() async {
    emit(CharacterLoading());
    _characters = await _charactersRepository.getAllCharacters();
    emit(CharactersLoaded(_characters));
    return _characters;
  }

  List<Character> searchCharactersStarWith(String name) {
    if (!isSearch || name.isEmpty) {
      _searchedCharacters = _characters;
    } else {
      name = name.toLowerCase();
      _searchedCharacters = _characters
          .where((character) => character.name.toLowerCase().startsWith(name))
          .toList();
    }

    emit(SearchCharacters(_searchedCharacters));
    return _searchedCharacters;
  }

  void startSearch() {
    isSearch = true;
    searchChanges();
  }

  void endSearch() {
    isSearch = false;
    searchChanges();
  }

  void searchChanges() {
    emit(Search(isSearch));
    emit(CharactersLoaded(_characters));
  }
}
