class PlantType {
  final String id;
  final String name;
  final int basePoints;
  final List<double> stageThresholds;

  const PlantType({
    required this.id,
    required this.name,
    required this.basePoints,
    required this.stageThresholds,
  });
}

class PlantInstance {
  final PlantType type;
  double growth;

  PlantInstance({
    required this.type,
    this.growth = 0.0,
  });

  int get stageIndex {
    for (var i = 0; i < type.stageThresholds.length; i++) {
      if (growth < type.stageThresholds[i]) {
        return i;
      }
    }
    return type.stageThresholds.length;
  }

  bool get isHarvestable => growth >= 1.0;
}
