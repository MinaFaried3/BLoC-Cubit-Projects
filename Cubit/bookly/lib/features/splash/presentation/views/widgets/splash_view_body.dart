import 'dart:async';

import 'package:bookly/constants.dart';
import 'package:bookly/core/utils/assets.dart';
import 'package:bookly/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<Offset> slidingAnimation;
  late final Animation<double> fadingAnimation;
  late final CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    initAnimation();
    navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildFadeLogoTransition(fadingAnimation),
        buildSlidedTextTransition(slidingAnimation),
      ],
    );
  }

  void navigateToHome() {
    Timer timer = Timer(
      const Duration(seconds: 4),
      () {
        Get.to(
          const HomeView(),
          transition: Transition.fadeIn,
          duration: kTransitionDuration,
        );
      },
    );
  }

  void initAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 4), end: Offset.zero)
            .animate(curvedAnimation);
    fadingAnimation =
        Tween<double>(begin: 0.0, end: 1).animate(curvedAnimation);

    animationController.forward();
    // don't needed because of the animation builder
    // slidingAnimation.addListener(() {});
    // fadingAnimation.addListener(() {});
  }

  Widget buildSlidedTextTransition(Animation<Offset> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, widget) => SlideTransition(
        position: animation,
        child: const Text(
          'Read Free Books',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildFadeLogoTransition(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, widget) => FadeTransition(
          opacity: animation, child: Image.asset(AssetsData.logo)),
    );
  }
}
