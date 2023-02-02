import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/models/character_model.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: GridTile(
        footer: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          color: Colors.black54,
          child: Text(
            character.name,
            style:
                const TextStyle(height: 1.3, fontSize: 15, color: Colors.white),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        child: character.image.isNotEmpty
            ? FadeInImage.assetNetwork(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                placeholder: "assets/images/loading.gif",
                image: character.image)
            : Image.asset("assets/images/placeholder.png"),
      ),
    );
  }
}
