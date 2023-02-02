import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.yellow,
      ),
    );
  }
}
