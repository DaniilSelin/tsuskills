import 'package:flutter/material.dart';

final inputDecoration = InputDecorationTheme(
  filled: true,
  fillColor: Colors.white,
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
  ),
  contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: Colors.grey, width: 1.5),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: Colors.blue, width: 1.5),
  ),
);
