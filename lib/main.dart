import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'Auth/login.dart';
import 'Screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final auth = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin app ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: Column(
          children: [
            Flexible(
              child: Image.asset(
                'images/home.jpg',
              ),
            ),
            ColorLoader5(
                dotOneColor: Colors.redAccent,
                dotTwoColor: Colors.black,
                dotThreeColor: Colors.blueAccent,
                duration: const Duration(milliseconds: 1000),
                dotType: DotType.circle,
                dotIcon: const Icon(Icons.blur_on))
          ],
        ),
        duration: 1000,
        nextScreen: auth == null ? LogIn() : HomePage(),
      ),
    );
  }
}

enum DotType {
  square,
  circle,
  diamond,
  icon,
  iconForward,
  iconAdd,
  iconArrow,
  iconBright,
  iconDonut
}

class ColorLoader5 extends StatefulWidget {
  final Color dotOneColor;
  final Color dotTwoColor;
  final Color dotThreeColor;
  final Duration duration;
  final DotType dotType;
  final Icon dotIcon;

  ColorLoader5(
      {this.dotOneColor = Colors.redAccent,
      this.dotTwoColor = Colors.green,
      this.dotThreeColor = Colors.blueAccent,
      this.duration = const Duration(milliseconds: 1000),
      this.dotType = DotType.circle,
      this.dotIcon = const Icon(Icons.blur_on)});

  @override
  _ColorLoader5State createState() => _ColorLoader5State();
}

class _ColorLoader5State extends State<ColorLoader5>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation_1;
  late Animation<double> animation_2;
  late Animation<double> animation_3;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation_1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.70, curve: Curves.linear),
      ),
    );

    animation_2 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.1, 0.80, curve: Curves.linear),
      ),
    );

    animation_3 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.2, 0.90, curve: Curves.linear),
      ),
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Opacity(
            opacity: (animation_1.value <= 0.4
                ? 2.5 * animation_1.value
                : (animation_1.value > 0.40 && animation_1.value <= 0.60)
                    ? 1.0
                    : 2.5 - (2.5 * animation_1.value)),
            child: new Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Dot(
                radius: 10.0,
                color: widget.dotOneColor,
                type: widget.dotType,
                icon: widget.dotIcon,
              ),
            ),
          ),
          Opacity(
            opacity: (animation_2.value <= 0.4
                ? 2.5 * animation_2.value
                : (animation_2.value > 0.40 && animation_2.value <= 0.60)
                    ? 1.0
                    : 2.5 - (2.5 * animation_2.value)),
            child: new Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Dot(
                radius: 10.0,
                color: widget.dotTwoColor,
                type: widget.dotType,
                icon: widget.dotIcon,
              ),
            ),
          ),
          Opacity(
            opacity: (animation_3.value <= 0.4
                ? 2.5 * animation_3.value
                : (animation_3.value > 0.40 && animation_3.value <= 0.60)
                    ? 1.0
                    : 2.5 - (2.5 * animation_3.value)),
            child: new Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Dot(
                radius: 10.0,
                color: widget.dotThreeColor,
                type: widget.dotType,
                icon: widget.dotIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;
  final DotType type;
  final Icon icon;

  Dot(
      {required this.radius,
      required this.color,
      required this.type,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: type == DotType.iconDonut
          ? Icon(
              Icons.donut_large,
              color: color,
              size: 1.3 * radius,
            )
          : type == DotType.iconBright
              ? Icon(
                  Icons.brightness_5,
                  color: color,
                  size: 1.3 * radius,
                )
              : type == DotType.iconArrow
                  ? Icon(
                      Icons.arrow_right,
                      color: color,
                      size: 2.5 * radius,
                    )
                  : type == DotType.iconForward
                      ? Icon(
                          Icons.arrow_forward_ios,
                          color: color,
                          size: 1.3 * radius,
                        )
                      : type == DotType.iconAdd
                          ? Icon(
                              Icons.add,
                              color: color,
                              size: 1.3 * radius,
                            )
                          : type == DotType.icon
                              ? Icon(
                                  icon.icon,
                                  color: color,
                                  size: 1.3 * radius,
                                )
                              : Transform.rotate(
                                  angle: type == DotType.diamond ? pi / 4 : 0.0,
                                  child: Container(
                                    width: radius,
                                    height: radius,
                                    decoration: BoxDecoration(
                                        color: color,
                                        shape: type == DotType.circle
                                            ? BoxShape.circle
                                            : BoxShape.rectangle),
                                  ),
                                ),
    );
  }
}
