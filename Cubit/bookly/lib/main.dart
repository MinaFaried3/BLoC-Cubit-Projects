import 'package:bookly/constants.dart';
import 'package:bookly/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const BooklyApp());
}

class BooklyApp extends StatelessWidget {
  const BooklyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
          appBarTheme: const AppBarTheme(
              color: kPrimaryColor,
              elevation: 0,
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarColor: kPrimaryColor)),
          textTheme:
              GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme)),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      home: const SplashView(),
    );
  }
}
