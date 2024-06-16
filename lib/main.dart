import 'package:flutter/material.dart';
import 'package:myapp/pages/home_page.dart';
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
      home: const HomePage(),
    );
  }
}
