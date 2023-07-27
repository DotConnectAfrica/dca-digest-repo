import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login.dart';
import 'news_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController _anime_controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    const anime_duration = 2;

    _anime_controller = AnimationController(
        duration: const Duration(seconds: anime_duration),
        reverseDuration: Duration(seconds: anime_duration),
        vsync: this);
    animation = Tween<double>(begin: 30, end: 150).animate(_anime_controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _anime_controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _anime_controller.forward();
      }
    });
    _anime_controller.forward();
  }

  _move_to_next() async{
    const duration = 3;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    Timer(Duration(seconds: duration), () async {
      if (isLoggedIn==true) {
        int x = 1;
        if (x == 1) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen(),
            ),
          );
        } else if (x == 2) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => NewsPageScreen(),
            ),
          );
        }
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen(),
          ),
        );
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    _move_to_next();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'DCA Digital Digest',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return Container(
                      height: animation.value,
                      width: animation.value,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 110,
                        child: CircleAvatar(
                          radius: 110,
                          backgroundImage: AssetImage('assets/images/logo.jpg'),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _anime_controller.dispose();
    super.dispose();
  }
}