// lib/views/screens/main_menu_screen.dart
import 'package:flutter/material.dart';
import 'package:pdm2_av1_figuras_geometricas/utils/app_constants.dart'; // Para AppStrings se necessário

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  final List<String> formas = const [
    "Retângulo", "Quadrado", "Círculo", "Paralelogramo", "Losango",
    "Trapézio", "Esfera", "Cubo", "Hexágono", "Triângulo",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu de Figuras"),
        centerTitle: true,
         actions: [ // Botão de Logout
           IconButton(
             icon: const Icon(Icons.logout),
             onPressed: () {
               Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
             },
           ),
         ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: formas.length,
          itemBuilder: (context, index) {
            final forma = formas[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
              elevation: 3.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                title: Text(
                  forma,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColorDark
                  ),
                ),
                trailing: Icon(Icons.calculate_outlined, color: Theme.of(context).primaryColor),
                onTap: () {
                  Navigator.of(context).pushNamed('/calculation', arguments: forma);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}