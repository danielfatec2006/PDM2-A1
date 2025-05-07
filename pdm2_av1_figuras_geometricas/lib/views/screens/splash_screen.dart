// lib/views/screens/splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pdm2_av1_figuras_geometricas/utils/app_constants.dart'; // Para AppImages e AppColors

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = false;

  void _initiateLogin() {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Definir paddings com base nas dimensões apropriadas
    final horizontalPadding = screenWidth * 0.05;
    final verticalPadding = screenHeight * 0.03; // Usar screenHeight para padding vertical

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea( // Garante que o conteúdo não fique sob as áreas do sistema (barra de status, notch)
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: LayoutBuilder( // Fornece as restrições de espaço reais para o filho
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight, // Garante que a Column ocupe pelo menos toda a altura visível
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Coloca espaço entre os grupos de filhos
                    crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os filhos horizontalmente
                    children: <Widget>[
                      // Grupo de conteúdo superior (logos, título, botão)
                      Column(
                        mainAxisSize: MainAxisSize.min, // A coluna só ocupa o espaço necessário para seus filhos
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(AppImages.logoCps, height: screenHeight * 0.1, errorBuilder: (c, o, s) => const Text("Logo CPS")),
                          SizedBox(height: screenHeight * 0.02),
                          Image.asset(AppImages.logoFatecMatao, height: screenHeight * 0.1, errorBuilder: (c, o, s) => const Text("Logo Fatec Matão")),
                          SizedBox(height: screenHeight * 0.02),
                          Image.asset(AppImages.logoDsm, height: screenHeight * 0.1, errorBuilder: (c, o, s) => const Text("Logo DSM")),
                          SizedBox(height: screenHeight * 0.05),
                          Text(
                            "Sistema Figuras Geométricas",
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          if (_isLoading) ...[
                            CircularProgressIndicator(color: Theme.of(context).primaryColor),
                            SizedBox(height: screenHeight * 0.03),
                            Text("Carregando...", style: TextStyle(fontSize: screenWidth * 0.04)),
                          ] else ...[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.02),
                                textStyle: TextStyle(fontSize: screenWidth * 0.045),
                              ),
                              onPressed: _initiateLogin,
                              child: const Text("Fazer Login"),
                            ),
                          ],
                        ],
                      ),

                      // Grupo de conteúdo inferior (rodapé)
                      Column(
                        mainAxisSize: MainAxisSize.min, // A coluna só ocupa o espaço necessário para seus filhos
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // Adiciona um pequeno espaço antes do rodapé para garantir que não fique colado
                          // se o conteúdo principal for curto.
                          SizedBox(height: screenHeight * 0.03),
                          Text(
                            "Alunos: Daniel Manoel, Kamily Simeão, Victoria Oliveira",
                            style: TextStyle(fontSize: screenWidth * 0.035),
                            textAlign: TextAlign.center, // Garante centralização se o texto quebrar
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            "Versão 1.0 - 01/2025",
                            style: TextStyle(fontSize: screenWidth * 0.035, color: AppColors.textGrey),
                          ),
                          // O padding vertical global já deve fornecer espaço na parte inferior.
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}