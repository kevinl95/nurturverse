import "dart:math";

import "package:flutter/foundation.dart";

import "../models/plant.dart";

class GardenState extends ChangeNotifier {
  GardenState({
    required this.rows,
    required this.columns,
  }) {
    _plants = List.generate(rows * columns, (_) => _newPlant());
  }

  final int rows;
  final int columns;

  final List<PlantType> plantTypes = const [
    PlantType(id: "sprout", name: "Sprout", basePoints: 5, stageThresholds: [0.25, 0.5, 0.75]),
    PlantType(id: "bloom", name: "Bloom", basePoints: 8, stageThresholds: [0.2, 0.55, 0.8]),
    PlantType(id: "orchid", name: "Orchid", basePoints: 12, stageThresholds: [0.3, 0.6, 0.85]),
    PlantType(id: "sunflower", name: "Sunflower", basePoints: 15, stageThresholds: [0.25, 0.55, 0.9]),
  ];

  final Random _random = Random();
  late List<PlantInstance> _plants;
  int totalPoints = 0;
  int totalBoincMinutes = 0;
  bool boincRunning = false;

  List<PlantInstance> get plants => _plants;

  void toggleBoinc() {
    boincRunning = !boincRunning;
    notifyListeners();
  }

  void addBoincMinutes(int minutes) {
    if (minutes <= 0) return;
    totalBoincMinutes += minutes;

    final growthDelta = minutes / 120.0;
    for (final plant in _plants) {
      plant.growth = (plant.growth + growthDelta).clamp(0.0, 1.0);
    }
    notifyListeners();
  }

  void harvest(int index) {
    final plant = _plants[index];
    if (!plant.isHarvestable) return;

    final pointsEarned = plant.type.basePoints * 10;
    totalPoints += pointsEarned;
    _plants[index] = _newPlant();
    notifyListeners();
  }

  PlantInstance _newPlant() {
    final type = plantTypes[_random.nextInt(plantTypes.length)];
    return PlantInstance(type: type, growth: 0.0);
  }
}
