// lib/main.dart
import 'package:flutter/material.dart';
import 'package:pdm2_av1_figuras_geometricas/utils/app_constants.dart';
import 'package:pdm2_av1_figuras_geometricas/views/screens/splash_screen.dart';
import 'package:pdm2_av1_figuras_geometricas/views/screens/login_screen.dart';
import 'package:pdm2_av1_figuras_geometricas/views/screens/main_menu_screen.dart';
import 'package:pdm2_av1_figuras_geometricas/views/screens/calculation_screen.dart';
import 'package:pdm2_av1_figuras_geometricas/views/screens/results_screen.dart';
import 'package:pdm2_av1_figuras_geometricas/models/shape_result_model.dart'; // Para tipagem do argumento de results

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white,
          elevation: 4.0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentColor,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppColors.accentColor, width: 2.0),
          ),
          filled: true,
          fillColor: AppColors.white,
          labelStyle: TextStyle(color: AppColors.primaryColor.withOpacity(0.7)),
        ),
        textTheme: TextTheme(
           titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
           bodyMedium: TextStyle(fontSize: 16, color: AppColors.black.withOpacity(0.87)),
        )
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => LoginScreen(), // Stateful, então não precisa de const
        '/main_menu': (context) => const MainMenuScreen(),
        '/calculation': (context) => CalculationScreen(
              shapeName: ModalRoute.of(context)!.settings.arguments as String,
            ),
        '/results': (context) => ResultsScreen(
              resultData: ModalRoute.of(context)!.settings.arguments as ShapeResultModel,
            ),
      },
    );
  }
}