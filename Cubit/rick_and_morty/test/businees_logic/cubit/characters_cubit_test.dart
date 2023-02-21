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

    when(charactersCubit.getAllCharacters())
        .thenAnswer((_) => Future.value(characters));

    const bool isSearch = false;
    final List<Character> wantedCharacters =
        await charactersCubit.getAllCharacters();

    final expectedStates = [
      const Search(isSearch),
      CharactersLoaded(wantedCharacters)
    ];

    //assert
    expectLater(charactersCubit.stream, emitsInAnyOrder(expectedStates));

    //act
    charactersCubit.searchChanges();
  });

  test("test searchCharactersStarWith() results", () async {
    //arrange
    final List<Character> characters = List.generate(
        5,
        (index) => Character(
              id: index,
              name: index % 2 == 0 ? "even $index" : "odd $index",
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

    when(charactersCubit.getAllCharacters())
        .thenAnswer((_) => Future.value(characters));
    await charactersCubit.getAllCharacters();
    charactersCubit.startSearch();

    final List<Character> expectedCharacters = [
      for (int index = 0; index <= 5; index += 2)
        Character(
          id: index,
          name: "even $index",
          status: "status $index",
          species: "species $index",
          type: "type $index",
          location: Location(name: "name $index", url: "url $index"),
          origin: Origin(name: "name $index", url: "url $index"),
          gender: "gender $index",
          image: "image $index",
          url: "url $index",
          created: "created $index",
        )
    ];

    //act
    const String name = "EveN";
    final actualCharacters = charactersCubit.searchCharactersStarWith(name);

    //asset
    expect(actualCharacters, expectedCharacters);
  });

  test("test searchCharactersStarWith() states", () async {
    //arrange
    final List<Character> characters = List.generate(
        5,
        (index) => Character(
              id: index,
              name: index % 2 == 0 ? "even $index" : "odd $index",
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

    when(charactersCubit.getAllCharacters())
        .thenAnswer((_) => Future.value(characters));
    await charactersCubit.getAllCharacters();
    charactersCubit.startSearch();

    final List<Character> expectedCharacters = [
      for (int index = 0; index <= 5; index += 2)
        Character(
          id: index,
          name: "even $index",
          status: "status $index",
          species: "species $index",
          type: "type $index",
          location: Location(name: "name $index", url: "url $index"),
          origin: Origin(name: "name $index", url: "url $index"),
          gender: "gender $index",
          image: "image $index",
          url: "url $index",
          created: "created $index",
        )
    ];

    //asset
    final expectedStates = [SearchCharacters(expectedCharacters)];
    expectLater(charactersCubit.stream, emitsInAnyOrder(expectedStates));

    //act
    const String name = "EveN";
    charactersCubit.searchCharactersStarWith(name);
  });
}
