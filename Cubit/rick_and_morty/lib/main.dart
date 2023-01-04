import 'package:flutter/material.dart';
import 'package:rick_and_morty/presentation/app_routes.dart';

void main() {
  runApp(const RickMorty(
    appRoutes: AppRoutes(),
  ));
}

class RickMorty extends StatelessWidget {
  final AppRoutes appRoutes;

  const RickMorty({super.key, required this.appRoutes});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty',
      onGenerateRoute: appRoutes.generateRoute,
    );
  }
}
