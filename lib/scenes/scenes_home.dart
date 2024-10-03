import 'package:flutter/material.dart';
import 'package:flutter_solar_system/gen/assets.gen.dart';
import 'package:flutter_solar_system/widgets/solar_system_widget.dart';

class ScenesHome extends StatefulWidget {
  const ScenesHome({super.key});

  @override
  State<ScenesHome> createState() => _ScenesHomeState();
}

class _ScenesHomeState extends State<ScenesHome> {
  int scaleSeconds = 2;
  double scaleRatio = 4;
  double shrinkRatio = 1 / 3;

  bool isScaled1 = false;
  bool isScaled2 = false;
  bool isScaled3 = false;

  bool mapScale() {
    return isScaled1 || isScaled2 || isScaled3;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          AnimatedScale(
            duration: Duration(seconds: scaleSeconds),
            scale: mapScale() == true ? 3 : 1,
            child: Image.asset(
              Assets.textures.stars.path,
              width: screenWidth,
              height: screenHeight,
              fit: BoxFit.cover,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: scaleSeconds),
            left: isScaled1
                ? (screenWidth / 2 - (screenWidth * 0.45) / 2)
                : screenWidth * 0.26,
            top: isScaled1
                ? (screenHeight / 2 - (screenHeight * 0.45) / 2)
                : screenHeight * 0.1,
            child: GestureDetector(
              onDoubleTap: () {
                setState(() {
                  isScaled1 = !isScaled1;
                  isScaled2 = false;
                  isScaled3 = false;
                });
              },
              child: AnimatedScale(
                scale:
                    isScaled1 ? scaleRatio : (mapScale() ? shrinkRatio : 1.0),
                duration: Duration(seconds: scaleSeconds),
                child: SizedBox(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.3,
                  child: const SolarSystemWidget(),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: scaleSeconds),
            left: isScaled2
                ? (screenWidth / 2 - (screenWidth * 0.45) / 2)
                : screenWidth * 0.002,
            top: isScaled2
                ? (screenHeight / 2 - (screenHeight * 0.45) / 2)
                : screenHeight * 0.6,
            child: GestureDetector(
              onDoubleTap: () {
                setState(() {
                  isScaled2 = !isScaled2;
                  isScaled1 = false;
                  isScaled3 = false;
                });
              },
              child: AnimatedScale(
                scale:
                    isScaled2 ? scaleRatio : (mapScale() ? shrinkRatio : 1.0),
                duration: Duration(seconds: scaleSeconds),
                child: SizedBox(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.3,
                  child: const SolarSystemWidget(),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: scaleSeconds),
            left: isScaled3
                ? (screenWidth / 2 - (screenWidth * 0.45) / 2)
                : screenWidth * 0.6,
            top: isScaled3
                ? (screenHeight / 2 - (screenHeight * 0.45) / 2)
                : screenHeight * 0.5,
            child: GestureDetector(
              onDoubleTap: () {
                setState(() {
                  isScaled3 = !isScaled3;
                  isScaled1 = false;
                  isScaled2 = false;
                });
              },
              child: AnimatedScale(
                scale:
                    isScaled3 ? scaleRatio : (mapScale() ? shrinkRatio : 1.0),
                duration: Duration(seconds: scaleSeconds),
                child: SizedBox(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.3,
                  child: const SolarSystemWidget(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
