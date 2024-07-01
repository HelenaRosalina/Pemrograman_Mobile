import 'package:flutter/material.dart';

class HealthInfoWidget extends StatelessWidget {
  final Map<String, bool> healthInfo;

  HealthInfoWidget({required this.healthInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: healthInfo.entries.map((entry) {
        return Row(
          children: [
            Icon(
              entry.value ? Icons.check_circle : Icons.cancel,
              color: entry.value ? Colors.green : Colors.red,
            ),
            SizedBox(width: 8),
            Text(entry.key),
          ],
        );
      }).toList(),
    );
  }
}
