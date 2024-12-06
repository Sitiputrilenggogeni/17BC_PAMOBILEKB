import 'package:flutter/material.dart';
import 'package:lenggo/my_home_page.dart';
import 'package:lenggo/predict.dart';
import 'package:lenggo/product.dart';
import 'package:lenggo/profile_page.dart';
import 'package:lenggo/splash_screen.dart';
import 'package:lenggo/sign_up.dart';
import 'package:lenggo/sign_in.dart';
import 'package:lenggo/edit_profile.dart';

import 'package:lenggo/controller/controller.dart';
import 'package:lenggo/controller/auth_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PredictionProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff895737),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/home": (context) => const MyHomePage(),
        "/register": (context) => SignUpPage(),
        "/login": (context) => SignInPage(),

        "/predict": (context) => const Predict(),
        "/profile": (context) => const ProfilePage(),
        "/edit-profile": (context) => EditProfilePage(),

        "/product": (context) => const Product(),
      },
      home: const SplashScreen(),
    );
  }
}
