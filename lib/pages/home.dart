import 'package:bouncing_button_flutter/delayed_animation.dart';
import 'package:bouncing_button_flutter/pages/login.dart';
import 'package:bouncing_button_flutter/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final int delayedAmount = 1;
  AnimationController _controller;
  double _scale;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color(0xFF14183D),
          body: Center(
            child: Column(
              children: <Widget>[
                AvatarGlow(
                  endRadius: 90,
                  duration: Duration(seconds: 2),
                  glowColor: Colors.white24,
                  repeat: true,
                  repeatPauseDuration: Duration(seconds: 2),
                  startDelay: Duration(seconds: 1),
                  child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF14183D),
                        backgroundImage: ExactAssetImage('assets/images/iron-man-helmet.gif'),
                        radius: 70.0,
                      )
                  ),
                ),
                DelayedAnimation(
                  child: Text(
                    "Hi there,",
                    style: TextStyle(
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: color),
                  ),
                  delay: delayedAmount,
                ),
                DelayedAnimation(
                  child: Text(
                    "I'm Jarvis",
                    style: TextStyle(
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: color),
                  ),
                  delay: delayedAmount + 1,
                ),
                SizedBox(height: 50.0),
                DelayedAnimation(
                  child: Text(
                    "Your new personal",
                    style: TextStyle(
                        fontFamily: 'Barlow',
                        fontSize: 20.0,
                        color: color),
                  ),
                  delay: delayedAmount + 2,
                ),
                DelayedAnimation(
                  child: Text(
                    "daily mission tracker",
                    style: TextStyle(
                        fontFamily: 'Barlow',
                        fontSize: 20.0,
                        color: color),
                  ),
                  delay: delayedAmount + 2,
                ),
                SizedBox(height: 100.0),
                DelayedAnimation(
                  child:   GestureDetector(
                    onTapDown: _onTapDown,
                    onTapUp: _onTapUp,
                    onTap: (){
                      Navigator.of(context)
                          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                        return new SignupScreen();
                      }));
                    },
                    child: Transform.scale(
                      scale: _scale,
                      child: _animatedButtonUi,
                    ),
                  ),
                  delay: delayedAmount + 3,
                ),
                SizedBox(height: 30.0),
                DelayedAnimation(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context)
                          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                        return new LoginScreen();
                      }));
                    },
                    child:  Text(
                      "I Already Have An Account".toUpperCase(),
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: color
                      ),
                    ),
                  ),
                  delay: delayedAmount + 4,
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget get _animatedButtonUi => Container(
    height: 60,
    width: 270,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Colors.white,
    ),
    child: Center(
      child: Text(
          'Hi, Jarvis!'.toUpperCase(),
          style: TextStyle(
              color: Color(0xFF14183D),
              fontWeight: FontWeight.bold,
              fontSize: 15.0
          ),
      ),
    ),
  );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
