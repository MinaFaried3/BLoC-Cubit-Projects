import 'package:flutter/foundation.dart';

const String baseUrl = 'https://rickandmortyapi.com/api/';
const String charactersUrl = '${baseUrl}character';
//routes
const String charactersScreen = '/';
const String characterDetailsScreen = '/character_details';

void printK(Object printed) {
  if (kDebugMode) {
    print(printed);
  }
}
