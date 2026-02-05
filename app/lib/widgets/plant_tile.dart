import "package:flutter/material.dart";

import "../models/plant.dart";

class PlantTile extends StatelessWidget {
  const PlantTile({
    super.key,
    required this.plant,
    required this.onHarvest,
  });

  final PlantInstance plant;
  final VoidCallback onHarvest;

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.green.shade300,
      Colors.green.shade400,
      Colors.green.shade600,
      Colors.green.shade800,
    ];
    final stage = plant.stageIndex.clamp(0, colors.length - 1);

    return InkWell(
      onTap: plant.isHarvestable ? onHarvest : null,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(
          color: colors[stage],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 8,
              left: 8,
              child: Text(
                plant.type.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Center(
              child: Text(
                plant.isHarvestable ? "Harvest" : "Stage ${stage + 1}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Text(
                "${(plant.growth * 100).toStringAsFixed(0)}%",
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
