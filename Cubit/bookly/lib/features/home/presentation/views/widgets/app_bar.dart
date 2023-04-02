import 'package:bookly/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar buildMainAppBar(double height, double width) {
  return AppBar(
    toolbarHeight: height / 13,
    automaticallyImplyLeading: false,
    title: Image.asset(
      AssetsData.logo,
      width: width / 4,
    ),
    actions: [
      IconButton(
          onPressed: () {},
          icon: Icon(
            FontAwesomeIcons.magnifyingGlass,
            size: width / 25,
          ))
    ],
  );
}
