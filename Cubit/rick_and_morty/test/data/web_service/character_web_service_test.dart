import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/constants/app_strings.dart';
import 'package:rick_and_morty/data/data_source/remote_data_source.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/data/web_services/character_web_service.dart';

import 'character_web_service_test.mocks.dart';

@GenerateMocks([CharacterWebService])
void main() {
  late RemoteDataSource remoteDataSource;
  late CharacterWebService mockWebService;

  setUp(() {
    mockWebService = MockCharacterWebService();
    remoteDataSource = RemoteDataSourceImpl(mockWebService);
  });

  test("test remote data source should return posts map", () async {
    //arrange
    final characters = List.generate(
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

    final characterMap = characters.map((e) => e.toMap()).toList();

    when(mockWebService.get(charactersUrl)).thenAnswer((_) => Future.value(
          Response(
            requestOptions: RequestOptions(path: charactersUrl),
            data: {"results": characterMap},
            statusCode: 200,
          ),
        ));

    //act
    final List<dynamic> result = await remoteDataSource.getAllCharacters();

    //assert
    expect(result, characterMap);
  });

  test("test throwing an exception ", () async {
    //arrange
    final expectedResult = throwsA(isA<Exception>());

    when(mockWebService.get(charactersUrl))
        .thenAnswer((_) => Future.value(Response(
            requestOptions: RequestOptions(
              path: charactersUrl,
            ),
            statusCode: 404)));

    //act
    result() async => await remoteDataSource.getAllCharacters();

    //assert
    expect(result, expectedResult);
  });
}
