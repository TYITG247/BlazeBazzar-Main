import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

ThemeData CustomLightTheme() {
  return FlexThemeData.light(
    scaffoldBackground: Colors.white,
    primary: FlexColor.mandyRedLightPrimary,
    useMaterial3: true,
  );
}

ThemeData CustomDarkTheme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.black,
      primaryColor: FlexColor.mandyRedDarkPrimary,
      useMaterial3: true
  );
}