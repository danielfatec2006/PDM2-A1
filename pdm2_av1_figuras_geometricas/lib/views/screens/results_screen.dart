// lib/views/screens/results_screen.dart
import 'package:flutter/material.dart';
import 'package:pdm2_av1_figuras_geometricas/models/shape_result_model.dart';
import 'package:pdm2_av1_figuras_geometricas/utils/app_constants.dart';

class ResultsScreen extends StatelessWidget {
  final ShapeResultModel resultData;

  const ResultsScreen({super.key, required this.resultData});

  Widget _buildResultRow(BuildContext context, String label, String? value, {bool isHeader = false, bool isInput = false}) {
    if (value == null) return const SizedBox.shrink(); // Não mostra nada se o valor for nulo

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isHeader ? 18 : 16,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              color: isInput ? AppColors.grey700 : Theme.of(context).primaryColorDark,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isHeader ? 18 : 16,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
              color: isInput ? AppColors.black : AppColors.accentColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultados: ${resultData.shapeName}"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    "Detalhes do Cálculo",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22),
                  ),
                ),
                const SizedBox(height: 10),
                Divider(thickness: 1, color: AppColors.grey300),
                const SizedBox(height: 15),

                Text(
                  "Dados de Entrada:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                ...resultData.inputs.entries.map((entry) =>
                  _buildResultRow(context, entry.key, entry.value, isInput: true)
                ).toList(),
                
                // Específico para Círculo, conforme solicitado
                if (resultData.shapeName == "Círculo" && resultData.radius != null)
                  _buildResultRow(context, "Raio Calculado", resultData.radius!.toStringAsFixed(2), isInput: true),


                const SizedBox(height: 20),
                Divider(thickness: 1, color: AppColors.grey300),
                const SizedBox(height: 15),

                Text(
                  "Resultados Calculados:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                if (resultData.area != null)
                  _buildResultRow(context, "Área", resultData.area!.toStringAsFixed(2)),
                if (resultData.perimeter != null)
                  _buildResultRow(context, resultData.shapeName == "Círculo" ? "Circunferência" : "Perímetro", resultData.perimeter!.toStringAsFixed(2)),
                if (resultData.volume != null)
                  _buildResultRow(context, "Volume", resultData.volume!.toStringAsFixed(2)),
                
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Volta para a tela de cálculo
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.grey700),
                    child: const Text(AppStrings.backButton),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}