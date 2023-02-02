import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/business_logic/cubit/characters_cubit.dart';
import 'package:rick_and_morty/constants/app_strings.dart';
import 'package:rick_and_morty/data/repository/characters_repository.dart';
import 'package:rick_and_morty/data/web_services/character_web_service.dart';
import 'package:rick_and_morty/presentation/screens/character_details_screen.dart';
import 'package:rick_and_morty/presentation/screens/characters_screen.dart';

class AppRoutes extends Equatable {
  late final CharactersRepository _charactersRepository;
  late final CharactersCubit _charactersCubit;

  AppRoutes() {
    _charactersRepository = CharactersRepository(CharacterWebService());
    _charactersCubit = CharactersCubit(_charactersRepository)
      ..getAllCharacters();
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => _charactersCubit,
                  child: const CharactersScreen(),
                ));
      case characterDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const CharacterDetailsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const CharactersScreen());
    }
  }

  @override
  List<Object> get props => [];
}
