import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/app_colors.dart';
import 'package:rick_and_morty/data/models/character_model.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key, required this.character});
  final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          _buildAppBarSliver(),
          SliverList(
              delegate: SliverChildListDelegate([
            _buildCharacterInfo(),
            const SizedBox(
              height: 400,
            )
          ])),
        ],
      ),
    );
  }

  Widget _buildAppBarSliver() {
    return SliverAppBar(
      backgroundColor: AppColors.grey,
      elevation: 0,
      expandedHeight: 400,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        title: LayoutBuilder(
          builder: (context, constrains) => Text(
            character.name,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: constrains.maxHeight > 150
                  ? AppColors.grey
                  : AppColors.yellow,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ),
        centerTitle: true,
        titlePadding: const EdgeInsets.all(8),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterInfo() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildTileInfo(
            title: "species",
            description: character.species,
          ),
          _buildDivider(280),
          _buildTileInfo(
            title: "status",
            description: character.status,
          ),
          _buildDivider(300),
          _buildTileInfo(
            title: "gender",
            description: character.gender,
          ),
          _buildDivider(290),
          _buildTileInfo(
            title: "location",
            description: character.location.name,
          ),
          _buildDivider(280),
          _buildTileInfo(
            title: "origin",
            description: character.origin.name,
          ),
          _buildDivider(300),
          _buildTileInfo(
            title: "created",
            description: character.created,
          ),
          _buildDivider(280),
        ],
      ),
    );
  }

  Widget _buildTileInfo({
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          "$title : ",
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        Flexible(
          child: Text(
            description,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
      ],
    );
  }

  Divider _buildDivider(double endIndent) {
    return Divider(
      color: AppColors.yellow,
      thickness: 2,
      endIndent: endIndent,
      height: 30,
    );
  }
}
