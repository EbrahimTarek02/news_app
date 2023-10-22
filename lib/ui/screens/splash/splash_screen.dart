import 'package:flutter/material.dart';
import 'package:news_app/ui/screens/home/home_screen.dart';
import 'package:news_app/ui/utils/app_assets.dart';

class SplashScreen extends StatefulWidget {

  static const String routeName = 'splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, HomeScreen.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.splash,
      fit: BoxFit.cover,
    );
  }
}
