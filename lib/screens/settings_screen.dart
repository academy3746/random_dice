import 'package:flutter/material.dart';
import 'package:random_dice/common/constants/colors.dart';
import 'package:random_dice/common/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.threshold,
    required this.onThresholdChange,
  });

  final double threshold;

  final ValueChanged<double> onThresholdChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Sizes.size20),
          child: Row(
            children: [
              Text(
                '센서 민감도',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Slider(
                value: threshold,
                onChanged: onThresholdChange,
                min: 0.1,
                max: 10.0,
                divisions: 101,
                label: threshold.toStringAsFixed(1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
