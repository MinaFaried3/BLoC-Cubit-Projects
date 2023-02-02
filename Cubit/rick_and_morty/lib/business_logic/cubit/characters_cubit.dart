import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/data/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository _charactersRepository;

  CharactersCubit(this._charactersRepository) : super(CharactersInitial());

  late final List<Character> _characters;

  Future<List<Character>> getAllCharacters() async {
    emit(CharacterLoading());
    _characters = await _charactersRepository.getAllCharacters();
    emit(CharactersLoaded(_characters));
    return _characters;
  }
}
