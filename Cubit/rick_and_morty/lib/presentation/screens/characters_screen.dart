import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/business_logic/cubit/characters_cubit.dart';
import 'package:rick_and_morty/constants/app_colors.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/presentation/widgets/character_item.dart';
import 'package:rick_and_morty/presentation/widgets/loading_indicator.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> characters;
  final TextEditingController controller = TextEditingController();
  late CharactersCubit charactersCubit;

  @override
  void initState() {
    super.initState();
    charactersCubit = BlocProvider.of<CharactersCubit>(context)
      ..getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: charactersCubit.isSearch ? buildSearchBar() : buildAppBarTitle(),
        actions: buildAppBarActions(),
        leading: charactersCubit.isSearch
            ? const BackButton(
                color: AppColors.yellow,
              )
            : const SizedBox(),
        leadingWidth: 30,
        backgroundColor: AppColors.grey,
      ),
      body: buildCharactersWidget(),
    );
  }

  Widget buildCharactersWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        characters = state.characters;
        return buildCharactersGridView();
      } else if (state is SearchCharacters) {
        characters = state.searchedCharacters;
        return buildCharactersGridView();
      } else {
        return const LoadingIndicator();
      }
    });
  }

  Widget buildCharactersGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1),
      itemBuilder: (context, index) {
        return CharacterItem(
          character: characters[index],
        );
      },
      itemCount: characters.length,
    );
  }

  Widget buildSearchBar() {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "Search Character...",
        hintStyle: TextStyle(color: AppColors.yellow.withOpacity(0.3)),
        border: InputBorder.none,
      ),
      style: TextStyle(color: AppColors.yellow.withOpacity(0.8)),
      cursorColor: AppColors.yellow,
      onChanged: (name) {
        charactersCubit.searchCharactersStarWith(name);
      },
    );
  }

  List<Widget> buildAppBarActions() {
    if (charactersCubit.isSearch) {
      return [
        IconButton(
          icon: const Icon(
            Icons.clear,
            color: AppColors.yellow,
          ),
          onPressed: () {
            charactersCubit.endSearch();

            controller.text.isNotEmpty
                ? controller.clear()
                : Navigator.pop(context);
          },
        )
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(
            Icons.search,
            color: AppColors.yellow,
          ),
          onPressed: startSearch,
        )
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(
        LocalHistoryEntry(onRemove: charactersCubit.endSearch));
    charactersCubit.startSearch();
  }

  Widget buildAppBarTitle() => const Text("Characters");
}
