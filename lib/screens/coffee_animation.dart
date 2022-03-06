import 'package:coffee_animation/screens/my_canvas/rect_canvas.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter/material.dart';

import 'my_canvas/oval_canvas.dart';

class CoffeeAnimation extends StatefulWidget {
  const CoffeeAnimation({Key? key}) : super(key: key);

  @override
  State<CoffeeAnimation> createState() => _CoffeeAnimationState();
}

class _CoffeeAnimationState extends State<CoffeeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _coffeeController;
  bool copAnimated = false;
  bool animateCafeText = false;

  @override
  void initState() {
    _coffeeController = AnimationController(vsync: this);
    _coffeeController.addListener(() {
      if (_coffeeController.value > 0.7) {
        _coffeeController.stop();
        copAnimated = true;
        setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          animateCafeText = true;
          setState(() {});
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _coffeeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Stack(
        children: [
          // White Container top half
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: copAnimated ? screenHeight * 0.6 : screenHeight,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(copAnimated ? 40.0 : 0.0),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, -5),
                    color: Colors.grey,
                    spreadRadius: 5,
                    blurRadius: 15,
                  )
                ]),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Visibility(
                  visible: copAnimated,
                  child: CustomPaint(
                    painter: OvalCanvas(),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Visibility(
                      visible: !copAnimated,
                      child: Lottie.asset(
                        'assets/coffeesplash.json',
                        controller: _coffeeController,
                        onLoaded: (composition) {
                          _coffeeController
                            ..duration = composition.duration
                            ..forward();
                        },
                      ),
                    ),
                    Visibility(
                      visible: copAnimated,
                      child: Image.asset(
                        'assets/cafe.png',
                        height: 150.0,
                        width: 150.0,
                      ),
                    ),
                    Center(
                      child: AnimatedPadding(
                        duration: const Duration(milliseconds: 1400),
                        padding: EdgeInsets.only(
                            bottom: animateCafeText ? 0 : 100, top: 10),
                        child: AnimatedOpacity(
                          opacity: animateCafeText ? 1 : 0,
                          duration: const Duration(seconds: 1),
                          child: const Text(
                            'C A F É',
                            style:
                                TextStyle(fontSize: 50.0, color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80)
                  ],
                ),
              ],
            ),
          ),

          // Text bottom part
          Visibility(visible: copAnimated, child: _bottomPart()),
        ],
      ),
    );
  }

  _bottomPart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
          ),
          child: Text(
            'Find The Best Coffee for You',
            style: TextStyle(
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(height: 50),
        AnimatedPadding(
          duration: const Duration(seconds: 1),
          padding: EdgeInsets.symmetric(horizontal: animateCafeText ? 95 : 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomPaint(
                painter: RectCanvas(const Color(0xFF9c6644), "Log In"),
              ),
              CustomPaint(
                painter: RectCanvas(const Color(0xFFfbf8cc), "Sing Up"),
              ),
            ],
          ),
        ),
        const SizedBox(height: 130),
      ],
    );
  }
}
