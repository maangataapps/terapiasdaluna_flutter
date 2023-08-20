import 'package:flutter/material.dart';

ButtonStyle buttonStyle({required MaterialStateProperty<Color?>? color}) {
  return ButtonStyle(
    backgroundColor: color,
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),
  );
}