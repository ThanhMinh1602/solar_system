import 'package:flutter/material.dart';
import 'package:flutter_solar_system/scenes/scenes_home.dart';
import 'package:flutter_solar_system/widgets/solar_system_widget.dart';

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
      ),
      home: const ScenesHome(),
    );
  }
}
