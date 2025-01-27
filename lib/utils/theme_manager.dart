import 'package:aviz_app/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class ThemeManager {
  static appTheme(BuildContext context) {
    return ThemeData(
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: CustomColors.red,
      ),
      // Color of Switch (checkbox) Border Color
      colorScheme: Theme.of(context).colorScheme.copyWith(outline: CustomColors.grey400),
      // Click Circle Effect Disabled Here //
      splashColor: Colors.transparent,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: CustomColors.red,
        selectionHandleColor: Colors.black54,
      ),
    );
  }
}
