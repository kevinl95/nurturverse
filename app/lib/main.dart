import "package:flutter/material.dart";

import "state/garden_state.dart";
import "widgets/boinc_status_bar.dart";
import "widgets/plant_tile.dart";

void main() {
  runApp(const NurturverseApp());
}

class NurturverseApp extends StatelessWidget {
  const NurturverseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Nurturverse",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const GardenScreen(),
    );
  }
}

class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  late final GardenState _state;

  @override
  void initState() {
    super.initState();
    _state = GardenState(rows: 3, columns: 4);
    _state.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nurturverse"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BoincStatusBar(
              running: _state.boincRunning,
              onToggle: _state.toggleBoinc,
              totalMinutes: _state.totalBoincMinutes,
              totalPoints: _state.totalPoints,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _state.boincRunning ? () => _state.addBoincMinutes(5) : null,
                    icon: const Icon(Icons.bolt),
                    label: const Text("Simulate +5 min"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _state.boincRunning ? () => _state.addBoincMinutes(30) : null,
                    icon: const Icon(Icons.timer),
                    label: const Text("Simulate +30 min"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: _state.plants.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _state.columns,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final plant = _state.plants[index];
                  return PlantTile(
                    plant: plant,
                    onHarvest: () => _state.harvest(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
