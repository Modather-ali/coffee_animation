import 'package:lottie/lottie.dart';

import 'package:flutter/material.dart';

import 'my_canvas/my_canvas.dart';

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
                    painter: MyCanvas(),
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
                        'assets/coffeepic.png',
                        height: 190.0,
                        width: 190.0,
                      ),
                    ),
                    Center(
                      child: AnimatedPadding(
                        duration: const Duration(seconds: 2),
                        padding:
                            EdgeInsets.only(bottom: animateCafeText ? 0 : 100),
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
          Visibility(visible: copAnimated, child: const _BottomPart()),
        ],
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 100),
        child: Text(
          'Find The Best Coffee for You',
          style: TextStyle(
              fontSize: 27.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
