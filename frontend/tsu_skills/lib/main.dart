import 'package:flutter/material.dart';
import 'package:tsu_skills/app/app.dart';
import 'package:tsu_skills/app/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}
