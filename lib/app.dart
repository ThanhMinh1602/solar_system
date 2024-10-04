import 'package:flutter/material.dart';
import 'package:flutter_solar_system/gen/assets.gen.dart';
import 'package:flutter_solar_system/scenes/scenes_home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Solar System',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.tourneyTextTheme(),
        ),
        home: const ScenesHome());
  }
}
