import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/data/data_source/remote_data_source.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/data/repository/characters_repository.dart';

import 'characters_repository_test.mocks.dart';

@GenerateMocks([RemoteDataSource])
void main() {
  late RemoteDataSource mockDataSource;
  late CharactersRepository charactersRepository;

  setUp(() {
    mockDataSource = MockRemoteDataSource();
    charactersRepository = CharactersRepository(mockDataSource);
  });

  test("test getAllCharacters() function should return list<Characters>",
      () async {
    //arrange
    final characters = List.generate(
        5,
        (index) => Character(
              id: index,
              name: "name $index",
              status: "status $index",
              species: "species $index",
              type: "type $index",
              gender: "gender $index",
              location: Location(name: "name $index", url: "url $index"),
              origin: Origin(name: "name $index", url: "url $index"),
              image: "image $index",
              url: "url $index",
              created: "created $index",
            ));

    final List<Map<String, dynamic>?> charactersMap =
        characters.map((e) => e.toMap()).toList();

    when(mockDataSource.getAllCharacters()).thenAnswer(
      (_) => Future.value(charactersMap),
    );

    //act
    final result = await charactersRepository.getAllCharacters();

    //assert
    expect(result, characters);
  });

  test("test getAllCharacters() function should return [] error ", () async {
    //arrange
    final List expectedResult = [];

    when(mockDataSource.getAllCharacters()).thenAnswer(
      (_) => throw Exception(),
    );
    //act
    final result = await charactersRepository.getAllCharacters();

    //assert
    expect(result, expectedResult);
  });
}
