import 'package:flutter/material.dart';
import '../../data/mode_data.dart';

class ModeSwitcher extends StatelessWidget {
  final ModeData mode;
  final bool isActive;
  final Function(bool) onChanged;

  const ModeSwitcher({
    super.key,
    required this.mode,
    required this.isActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  mode.icon,
                  color: isActive ? mode.color : Colors.grey,
                  size: 28,
                ),
                const SizedBox(width: 16),
                Text(
                  mode.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isActive ? mode.color : null,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isActive,
            onChanged: onChanged,
            activeColor: mode.color,
          ),
        ],
      ),
    );
  }
}