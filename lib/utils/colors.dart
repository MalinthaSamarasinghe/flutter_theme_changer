import 'package:flutter/material.dart';

extension AppColors on ThemeData {
  Color get background => brightness == Brightness.dark ? Colors.black : Colors.white;
}
