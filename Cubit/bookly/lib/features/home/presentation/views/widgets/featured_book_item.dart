import 'package:bookly/core/utils/assets.dart';
import 'package:flutter/material.dart';

class FeaturedBookItem extends StatelessWidget {
  const FeaturedBookItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3 / 2,
      child: Container(
        margin:
            EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.01),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage(
                AssetsData.testImage,
              ),
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
