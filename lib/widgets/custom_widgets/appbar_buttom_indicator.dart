import 'package:aviz_app/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class AppbarBottomIndicator extends StatelessWidget {
  AppbarBottomIndicator({
    super.key,
    required this.leanierProgressIndicator,
  });

  final double leanierProgressIndicator;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
        tween: Tween<double>(
          begin: 0,
          end: leanierProgressIndicator / 100,
        ),
        builder: (context, value, _) => LinearProgressIndicator(
          backgroundColor: Colors.white,
          value: value,
          color: CustomColors.red,
        ),
      ),
    );
  }
}
