import 'package:flutter/material.dart';

class ModeData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> capabilities;

  const ModeData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.capabilities,
  });
}

// Lista de modos disponibles con sus datos
final List<ModeData> availableModes = [
  const  ModeData(
    title: 'Home Cinema',
    description: 'Enjoy movies with optimized light and sound settings',
    icon: Icons.movie,
    color: Colors.red,
    capabilities: [
      'Automatic TV power on',
      'Audio system optimization',
      'Netflix integration',
      'Dimmed lights for theater experience',
    ],
  ),
   ModeData(
    title: 'Gaming',
    description: 'Perfect settings for immersive gaming experience',
    icon: Icons.sports_esports,
    color: Colors.blue,
    capabilities: [
      'Playstation integration',
      'Game-optimized display settings',
      'Audio enhancements for gameplay',
      'Optional streaming capabilities',
    ],
  ),
   ModeData(
    title: 'Streaming',
    description: 'Ready to stream your content to the world',
    icon: Icons.live_tv,
    color: Colors.purple,
    capabilities: [
      'Camera and microphone setup',
      'Optimized lighting for streaming',
      'Multi-platform streaming support',
      'Gaming console integration (optional)',
    ],
  ),
];