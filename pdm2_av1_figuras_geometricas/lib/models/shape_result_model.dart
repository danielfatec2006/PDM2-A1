// lib/models/shape_result_model.dart
class ShapeResultModel {
  final String shapeName;
  final Map<String, String> inputs; // Ex: {"Base": "5.0", "Altura": "2.0"} OU {"Diâmetro": "10.0"}
  final double? area;
  final double? perimeter; // Ou circunferência
  final double? volume;
  final double? radius; // Específico para o círculo

  ShapeResultModel({
    required this.shapeName,
    required this.inputs,
    this.area,
    this.perimeter,
    this.volume,
    this.radius,
  });

  // Método para facilitar a exibição ou depuração
  @override
  String toString() {
    return 'ShapeResultModel(shapeName: $shapeName, inputs: $inputs, area: $area, perimeter: $perimeter, volume: $volume, radius: $radius)';
  }
}