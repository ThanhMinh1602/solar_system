import 'package:flutter/material.dart';
import 'package:flutter_solar_system/gen/assets.gen.dart';
import 'package:flutter_solar_system/widgets/glb_model_viewer.dart';
import 'package:flutter_solar_system/widgets/solar_system_widget.dart';
import 'package:lottie/lottie.dart';

class ScenesHome extends StatefulWidget {
  const ScenesHome({super.key});

  @override
  State<ScenesHome> createState() => _ScenesHomeState();
}

class _ScenesHomeState extends State<ScenesHome>
    with SingleTickerProviderStateMixin {
  int scaleSeconds = 2;
  double scaleRatio = 4;
  double shrinkRatio = 1 / 3;
  bool isScaled1 = false,
      isScaled2 = false,
      isScaled3 = false,
      isRocketCentered = false;

  late AnimationController _controller;
  late Animation<double> _rocketAnimation;

  bool mapScale() => isScaled1 || isScaled2 || isScaled3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _rocketAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void checkRocketPosition() {
    if (!mapScale()) {
      setState(() {
        isRocketCentered = false;
        _controller.reverse();
      });
    }
  }

  void toggleScale(int index) {
    setState(() {
      isScaled1 = index == 1 ? !isScaled1 : false;
      isScaled2 = index == 2 ? !isScaled2 : false;
      isScaled3 = index == 3 ? !isScaled3 : false;
      isRocketCentered = mapScale();

      if (isRocketCentered) {
        _controller.forward();
      }
      checkRocketPosition();
    });
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
            scale: mapScale() ? 3 : 1,
            child: Image.asset(
              Assets.textures.stars.path,
              width: screenWidth,
              height: screenHeight,
              fit: BoxFit.cover,
            ),
          ),
          _buildSolarSystem(
              index: 1,
              isScaled: isScaled1,
              right: screenWidth * 0.26,
              top: screenHeight * 0.1,
              child: const SolarSystemWidget()),
          _buildSolarSystem(
              index: 2,
              isScaled: isScaled2,
              right: screenWidth * 0.002,
              top: screenHeight * 0.6,
              child: const SolarSystemWidget()),
          _buildSolarSystem(
              index: 3,
              isScaled: isScaled3,
              right: screenWidth * 0.6,
              top: screenHeight * 0.5,
              child: const GlbViewWidget()),
          _buildSpaceship(screenWidth, screenHeight),
          _buildViewDetail(screenHeight, screenWidth),
        ],
      ),
    );
  }

  Widget _buildViewDetail(double screenHeight, double screenWidth) {
    return AnimatedPositioned(
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      top: mapScale() ? screenHeight * 0.1 : -screenHeight,
      left: screenWidth * 0.03,
      child: AnimatedOpacity(
        duration: const Duration(seconds: 2),
        opacity: mapScale() ? 1.0 : 0.0,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          width: screenWidth * 0.3,
          height: screenHeight * 0.8,
          decoration: BoxDecoration(
            color: const Color(0xff0f202e).withOpacity(0.8),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Column(
            children: [
              const Text(
                'Solar System Detail',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
              const SizedBox(height: 20),
              // You can add more details about the planets here
              const Text(
                'This is the detail view of the selected solar system.',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              if (isScaled1)
                const Text('Details about Solar System 1',
                    style: TextStyle(color: Colors.white)),
              if (isScaled2)
                const Text('Details about Solar System 2',
                    style: TextStyle(color: Colors.white)),
              if (isScaled3)
                const Text('Details about Solar System 3',
                    style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSolarSystem(
      {required int index,
      required bool isScaled,
      required double right,
      required double top,
      required Widget child}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedPositioned(
      duration: Duration(seconds: scaleSeconds),
      right: isScaled ? (screenWidth / 2.5 - (screenWidth * 0.45) / 2) : right,
      top: isScaled ? (screenHeight / 2 - (screenHeight * 0.45) / 2) : top,
      child: GestureDetector(
        onDoubleTap: () => toggleScale(index),
        child: AnimatedScale(
          scale: isScaled ? scaleRatio : (mapScale() ? shrinkRatio : 1.0),
          duration: Duration(seconds: scaleSeconds),
          child: SizedBox(
            width: screenWidth * 0.3,
            height: screenHeight * 0.3,
            child: child,
          ),
        ),
      ),
    );
  }

  AnimatedBuilder _buildSpaceship(double screenWidth, double screenHeight) {
    return AnimatedBuilder(
      animation: _rocketAnimation,
      builder: (context, child) {
        double targetRight = screenWidth / 2.5 - (screenWidth * 0.45) / 2;

        double rocketRight = screenWidth / 2 - screenHeight * 0.1;
        double rocketBottom = 0;

        return Positioned(
          right: rocketRight -
              (rocketRight - targetRight) * _rocketAnimation.value,
          bottom: rocketBottom +
              (screenHeight / 2 - rocketBottom) * _rocketAnimation.value,
          child: SizedBox(
            width: screenHeight * 0.2,
            height: screenHeight * 0.2,
            child: Lottie.asset(Assets.jsons.rocket),
          ),
        );
      },
    );
  }
}
