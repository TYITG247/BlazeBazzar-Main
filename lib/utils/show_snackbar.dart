import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

showSnack(context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
      backgroundColor: FlexColor.mandyRedLightPrimary,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
