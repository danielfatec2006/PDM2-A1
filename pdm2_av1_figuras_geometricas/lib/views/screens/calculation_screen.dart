// lib/views/screens/calculation_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdm2_av1_figuras_geometricas/controllers/shape_controller.dart';
import 'package:pdm2_av1_figuras_geometricas/models/shape_result_model.dart';
import 'package:pdm2_av1_figuras_geometricas/utils/app_constants.dart';

class CalculationScreen extends StatefulWidget {
  final String shapeName;

  const CalculationScreen({super.key, required this.shapeName});

  @override
  State<CalculationScreen> createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  final _formKey = GlobalKey<FormState>();
  final ShapeController _shapeController = ShapeController();
  late Map<String, TextEditingController> _textControllers;
  late List<String> _inputLabels;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _inputLabels = _shapeController.getRequiredInputsForShape(widget.shapeName).keys.toList();
    _textControllers = {
      for (var label in _inputLabels) label: TextEditingController()
    };
  }

  void _calculateAndNavigate() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isLoading = true);

      Map<String, double> inputValues = {};
      _textControllers.forEach((key, controller) {
        inputValues[key] = double.tryParse(controller.text.replaceAll(',', '.')) ?? 0.0;
      });

      // Simula um pequeno delay para o cálculo se necessário
      // await Future.delayed(const Duration(milliseconds: 500));

      ShapeResultModel? result = _shapeController.calculate(widget.shapeName, inputValues);
      
      setState(() => _isLoading = false);

      if (result != null && mounted) {
        Navigator.of(context).pushNamed('/results', arguments: result);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erro ao calcular. Verifique os valores.")),
        );
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cálculo: ${widget.shapeName}"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Entrada de Dados para ${widget.shapeName}",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.black, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                ..._inputLabels.map((label) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      controller: _textControllers[label],
                      decoration: InputDecoration(
                        labelText: label,
                        hintText: "Valor para $label",
                        prefixIcon: const Icon(Icons.straighten), // Ícone genérico para medida
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*[,.]?\d*')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira o valor de $label';
                        }
                        if (double.tryParse(value.replaceAll(',', '.')) == null) {
                          return 'Número inválido';
                        }
                        if ((double.tryParse(value.replaceAll(',', '.')) ?? -1) <=0) {
                           return 'Valor deve ser positivo';
                        }
                        return null;
                      },
                    ),
                  );
                }).toList(),
                const SizedBox(height: 30),
                 _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _calculateAndNavigate,
                        child: const Text(AppStrings.calculateButton),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}