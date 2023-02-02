import 'package:flutter/foundation.dart';

const String baseUrl = 'https://rickandmortyapi.com/api/';
//routes
const String charactersScreen = '/';
const String characterDetailsScreen = '/character_details';

void printK(String string) {
  if (kDebugMode) {
    print(string);
  }
}
