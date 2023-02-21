import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/business_logic/cubit/characters_cubit.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/data/repository/characters_repository.dart';

import 'characters_cubit_test.mocks.dart';

@GenerateMocks([CharactersRepository])
void main() {
  late CharactersCubit charactersCubit;
  late CharactersRepository mockCharactersRepository;

  setUp(() {
    mockCharactersRepository = MockCharactersRepository();
    charactersCubit = CharactersCubit(mockCharactersRepository);
    charactersCubit.getAllCharacters();
  });

  test("test getAllCharacters must return List<Characters>", () async {
    //arrange
    final List<Character> characters = List.generate(
        5,
        (index) => Character(
              id: index,
              name: "name $index",
              status: "status $index",
              species: "species $index",
              type: "type $index",
              location: Location(name: "name $index", url: "url $index"),
              origin: Origin(name: "name $index", url: "url $index"),
              gender: "gender $index",
              image: "image $index",
              url: "url $index",
              created: "created $index",
            ));

    when(mockCharactersRepository.getAllCharacters())
        .thenAnswer((_) => Future.value(characters));

    final expectedStates = [CharacterLoading(), CharactersLoaded(characters)];

    //assert
    expectLater(charactersCubit.stream, emitsInAnyOrder(expectedStates));

    //act
    await charactersCubit.getAllCharacters();
  });

  test("test throwing an exception to test the return from the method",
      () async {
    //arrange
    final List<Character> characters = [];

    when(mockCharactersRepository.getAllCharacters())
        .thenAnswer((realInvocation) => throw Exception());

    final expectedStates = [CharacterLoading(), CharactersLoaded(characters)];

    //assert
    expectLater(charactersCubit.stream, emitsInAnyOrder(expectedStates));

    //act
    await charactersCubit.getAllCharacters();
  });

  test("test searchChanges()", () async {
    //arrange
    const bool isSearch = false;
    final List<Character> characters = [];

    final expectedStates = [
      const Search(isSearch),
      CharactersLoaded(characters)
    ];

    //assert
    expectLater(charactersCubit.stream, emitsInAnyOrder(expectedStates));

    //act
    charactersCubit.searchChanges();
  });
}
