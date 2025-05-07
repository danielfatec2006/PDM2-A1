// lib/utils/app_constants.dart
import 'package:flutter/material.dart';

// Exemplo de constantes (adicione mais conforme necessário)
class AppStrings {
  static const String appName = "Figuras Geométricas MVC";
  static const String acessSystemTitle = "Acesso ao Sistema";
  static const String usernameHint = "Nome de Usuário";
  static const String passwordHint = "Senha";
  static const String loginButton = "Entrar";
  static const String calculateButton = "Calcular";
  static const String backButton = "Voltar";
  static const String loginTitle = "Login";
  // ... outras strings
}

class AppColors {
  static const Color primaryColor = Color(0xFF3B5998); // Azul da faixa do título da Avaliação1
  static const Color accentColor = Colors.blueAccent;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  // ... outras cores
  static Color grey300 = Colors.grey[300]!; // Usar '!' para indicar que não será nulo
  static Color grey700 = Colors.grey[700]!;
  static Color textGrey = Colors.grey[700]!;
}

class AppImages {
  static const String logoCps = "assets/images/cps-55-anos.png";
  static const String logoFatecMatao = "assets/images/fatec-matao.jpg";
  static const String logoDsm = "assets/images/cst-dsm.png";
}

// Exemplo de função utilitária (se houver)
// double screenAwareSize(double size, BuildContext context) {
//   return size * MediaQuery.of(context).size.width / 375.0; // Exemplo de responsividade
// }