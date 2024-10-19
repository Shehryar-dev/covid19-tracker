import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:covid_app/View/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late final AnimationController _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

   @override
   void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      Timer(const Duration(seconds: 5), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const WorldStates()));
      });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
                AnimatedBuilder(
                    animation: _animationController,
                    builder: (BuildContext context, Widget? child ){
                      return Transform.rotate(
                          angle: _animationController.value * 2.0 * math.pi,
                          child: Container(
                            width: 200,
                            height: 200,
                            child:const Image(image: AssetImage('assets/images/virus.png')),
                          )
                      );
                    }
                ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'SF-Pro',
                  fontWeight: FontWeight.w700,
                  color: Colors.white
                ),
                textAlign: TextAlign.center,
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TyperAnimatedText('Covid-19\nTracker App',textAlign: TextAlign.center,speed:const Duration(milliseconds:80 )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
