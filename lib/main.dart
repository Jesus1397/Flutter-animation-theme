import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myapp/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(
    ChangeNotifierProvider<ThemeChangeProvider>(
      create: (_) => ThemeChangeProvider(ThemeData.light()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeChangeProvider>(context).getTheme,
      home:  const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> colorExpanded;
  late Animation<double> iconSize;

  Color currentColor = Colors.white;
  Color pastColor = Colors.black;

  bool isThemeDark = false;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    colorExpanded = Tween(begin: 0.0, end: 5.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 1.0),
      ),
    );
    iconSize = Tween(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 1.0),
      ),
    );

    super.initState();
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: Container(
                      color: pastColor,
                    ),
                  ),
                  Positioned.fill(
                    child: ClipPath(
                      clipper: ThemeClipper(colorExpanded.value),
                      child: Container(
                        color: currentColor,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: GestureDetector(
                      child: Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                                offset: Offset(1, 1.8),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AnimatedContainer(
                                height: isThemeDark ? 0 : 40,
                                duration: const Duration(milliseconds: 1000),
                                child: const Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/light.png',
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                height: isThemeDark ? 40 : 0,
                                duration: const Duration(milliseconds: 1000),
                                child: const Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/dark.png',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      onTap: () {
                        setState(() {
                          Color aux;
                          animationController.forward(from: 0.0);
                          aux = currentColor;
                          currentColor = pastColor;
                          pastColor = aux;
                          isThemeDark = !isThemeDark;
                        });
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class ThemeClipper extends CustomClipper<Path> {
  // double iconDark = 32;

  final double percent;

  ThemeClipper(this.percent);

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.addArc(
      Rect.fromCenter(
        center: Offset(size.width - 40, 40),
        width: size.width * percent,
        height: size.width * percent,
      ),
      0.0,
      pi * 2,
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}