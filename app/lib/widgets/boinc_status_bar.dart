import "package:flutter/material.dart";

class BoincStatusBar extends StatelessWidget {
  const BoincStatusBar({
    super.key,
    required this.running,
    required this.onToggle,
    required this.totalMinutes,
    required this.totalPoints,
  });

  final bool running;
  final VoidCallback onToggle;
  final int totalMinutes;
  final int totalPoints;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: running ? Colors.green.shade700 : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  running ? "BOINC running" : "BOINC stopped",
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  "Minutes: $totalMinutes · Points: $totalPoints",
                  style: const TextStyle(color: Colors.white70),
                )
              ],
            ),
          ),
          TextButton(
            onPressed: onToggle,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: running ? Colors.green.shade900 : Colors.blueGrey.shade700,
            ),
            child: Text(running ? "Stop" : "Start"),
          )
        ],
      ),
    );
  }
}
