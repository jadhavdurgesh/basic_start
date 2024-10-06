import 'package:basic_start/constants/colors.dart';
import 'package:basic_start/experience/experience_selection_screen.dart';
import 'package:basic_start/pratice/practice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'onboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: base1,
          appBarTheme: AppBarTheme(color: base2),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ExperienceSelectionScreen());
  }
}
