part of 'characters_cubit.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();
}

class CharactersInitial extends CharactersState {
  @override
  List<Object> get props => [];
}

class CharacterLoading extends CharactersState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;

  const CharactersLoaded(this.characters);

  @override
  List<Object> get props => [characters];
}

class SearchCharacters extends CharactersState {
  final List<Character> searchedCharacters;

  const SearchCharacters(this.searchedCharacters);

  @override
  List<Object> get props => [searchedCharacters];
}

class Search extends CharactersState {
  final bool isSearch;

  const Search(this.isSearch);

  @override
  List<Object> get props => [isSearch];
}
