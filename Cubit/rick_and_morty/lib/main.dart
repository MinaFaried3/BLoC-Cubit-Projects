import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/app_colors.dart';
import 'package:rick_and_morty/presentation/app_routes.dart';
import 'package:rick_and_morty/presentation/theme/generate_color.dart';

void main() {
  runApp(RickMorty(
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
      theme: ThemeData(
          primaryColor: AppColors.yellow,
          primarySwatch: createMaterialColor(AppColors.yellow),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.grey,
          appBarTheme: const AppBarTheme(
              elevation: 0,
              centerTitle: true,
              backgroundColor: AppColors.grey,
              titleTextStyle: TextStyle(color: AppColors.yellow)),
          indicatorColor: AppColors.yellow),
      onGenerateRoute: appRoutes.generateRoute,
    );
  }
}
