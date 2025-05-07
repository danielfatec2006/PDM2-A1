// lib/controllers/shape_controller.dart
import 'dart:math' as math;
import 'package:pdm2_av1_figuras_geometricas/models/shape_result_model.dart';

class ShapeController {
  ShapeResultModel? calculate(String shapeName, Map<String, double> values) {
    double? area, perimeter, volume, radius;
    Map<String, String> stringInputs = values.map((key, value) => MapEntry(key, value.toStringAsFixed(2)));

    try {
      switch (shapeName) {
        case "Retângulo":
          double base = values["Base"]!;
          double altura = values["Altura"]!;
          area = base * altura;
          perimeter = 2 * (base + altura);
          break;
        case "Quadrado":
          double lado = values["Lado"]!;
          area = lado * lado;
          perimeter = 4 * lado;
          break;
        case "Círculo":
          // Instrução: "entrar com o diâmetro para calcular raio, área e perímetro"
          double diametro = values["Diâmetro"]!;
          radius = diametro / 2;
          area = math.pi * math.pow(radius, 2).toDouble(); // Adicionado .toDouble()
          perimeter = 2 * math.pi * radius;
          stringInputs = {"Diâmetro": diametro.toStringAsFixed(2)};
          break;
        case "Paralelogramo":
          double base = values["Base"]!;
          double altura = values["Altura"]!;
          area = base * altura;
          // Perímetro requer lados adjacentes, não apenas base e altura.
          // Para este exemplo, focaremos na área. Se os lados 'a' e 'b' fossem dados:
          // perimeter = 2 * (ladoA + ladoB);
          break;
        case "Losango":
          double dMaior = values["Diagonal Maior (D)"]!;
          double dMenor = values["Diagonal Menor (d)"]!;
          area = (dMaior * dMenor) / 2;
          // Perímetro requer o lado. Lado = sqrt((D/2)^2 + (d/2)^2).
          // perimeter = 4 * lado;
          break;
        case "Trapézio":
          double baseMaior = values["Base Maior (B)"]!;
          double baseMenor = values["Base Menor (b)"]!;
          double altura = values["Altura (h)"]!;
          area = ((baseMaior + baseMenor) * altura) / 2;
          // Perímetro requer os lados não paralelos.
          break;
        case "Esfera":
          double raioEsfera = values["Raio"]!;
          area = 4 * math.pi * math.pow(raioEsfera, 2).toDouble(); // Adicionado .toDouble()
          volume = (4 / 3) * math.pi * math.pow(raioEsfera, 3).toDouble(); // Adicionado .toDouble()
          break;
        case "Cubo":
          double aresta = values["Aresta"]!;
          area = 6 * math.pow(aresta, 2).toDouble(); // Área total da superfície
          volume = math.pow(aresta, 3).toDouble();
          perimeter = 12 * aresta;// Soma de todas as arestas
          break;
        case "Hexágono": // Regular
          double lado = values["Lado (l)"]!;
          area = (3 * math.sqrt(3) * math.pow(lado, 2).toDouble()) / 2; // Adicionado .toDouble()
          perimeter = 6 * lado;
          break;
        case "Triângulo": // Usando base e altura para área
          double base = values["Base"]!;
          double altura = values["Altura"]!;
          area = (base * altura) / 2;
          // Perímetro para um triângulo genérico com base e altura não é direto.
          break;
        default:
          // Forma não reconhecida ou não implementada
          return null;
      }

      return ShapeResultModel(
        shapeName: shapeName,
        inputs: stringInputs,
        area: area,
        perimeter: perimeter,
        volume: volume,
        radius: radius, // Será null para formas que não são círculo
      );

    } catch (e) {
      print("Erro no cálculo: $e");
      // Pode-se lançar uma exceção customizada ou retornar null/um modelo de erro
      return ShapeResultModel(
        shapeName: shapeName,
        inputs: stringInputs, // Mesmo com erro, pode ser útil mostrar os inputs
        // Deixe os resultados como null ou adicione uma mensagem de erro ao modelo
      );
    }
  }

  // Mapeamento de quais inputs cada forma precisa
  Map<String, List<String>> getRequiredInputsForShape(String shapeName) {
    switch (shapeName) {
      case "Retângulo":
        return {"Base": [], "Altura": []};
      case "Quadrado":
        return {"Lado": []};
      case "Círculo":
        return {"Diâmetro": []}; // Alterado de Raio para Diâmetro
      case "Paralelogramo":
        return {"Base": [], "Altura": []};
      case "Losango":
        return {"Diagonal Maior (D)": [], "Diagonal Menor (d)": []};
      case "Trapézio":
        return {"Base Maior (B)": [], "Base Menor (b)": [], "Altura (h)": []};
      case "Esfera":
        return {"Raio": []};
      case "Cubo":
        return {"Aresta": []};
      case "Hexágono":
        return {"Lado (l)": []};
      case "Triângulo":
        return {"Base": [], "Altura": []};
      default:
        return {};
    }
  }
}