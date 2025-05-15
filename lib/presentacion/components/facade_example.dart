import 'package:flutter/material.dart';
import '../../domain/smart_home_state.dart';
import '../../facade/smart_home_facade.dart';

class FacadeExample extends StatelessWidget {
  final SmartHomeFacade facade;
  final SmartHomeState state;
  final Function() onStateChanged;

  const FacadeExample({
    super.key,
    required this.facade,
    required this.state,
    required this.onStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Facade Example',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Current State:',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            _buildStateRow('TV', state.tvOn),
            _buildStateRow('Audio System', state.audioSystemOn),
            _buildStateRow('Netflix Connected', state.netflixConnected),
            _buildStateRow('Gaming Console', state.gamingConsoleOn),
            _buildStateRow('Streaming Camera', state.streamingCameraOn),
            _buildStateRow('Lights', state.lightsOn),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  context,
                  'Toggle Lights',
                  Icons.lightbulb_outline,
                  Colors.amber,
                  () {
                    facade.toggleLights();
                    onStateChanged();
                  },
                ),
                _buildActionButton(
                  context,
                  'Start Movie',
                  Icons.movie_outlined,
                  Colors.red,
                  () {
                    facade.startMovie(state, 'The Matrix');
                    onStateChanged();
                  },
                  isDisabled: state.tvOn,
                ),
                _buildActionButton(
                  context,
                  'Stop Movie',
                  Icons.stop_circle_outlined,
                  Colors.red[700]!,
                  () {
                    facade.stopMovie(state);
                    onStateChanged();
                  },
                  isDisabled: !state.tvOn || !state.netflixConnected,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  context,
                  'Start Gaming',
                  Icons.sports_esports_outlined,
                  Colors.blue,
                  () {
                    facade.startGaming(state, 'Elden Ring');
                    onStateChanged();
                  },
                  isDisabled: state.gamingConsoleOn,
                ),
                _buildActionButton(
                  context,
                  'Stop Gaming',
                  Icons.stop_circle_outlined,
                  Colors.blue[700]!,
                  () {
                    facade.stopGaming(state);
                    onStateChanged();
                  },
                  isDisabled: !state.gamingConsoleOn,
                ),
                _buildActionButton(
                  context,
                  'Start Streaming',
                  Icons.live_tv_outlined,
                  Colors.purple,
                  () {
                    facade.startStreaming(state);
                    onStateChanged();
                  },
                  isDisabled: state.streamingCameraOn,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateRow(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            value ? Icons.check_circle_outline : Icons.highlight_off,
            color: value ? Colors.green : Colors.red,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 4),
          Text(
            value ? 'ON' : 'OFF',
            style: TextStyle(
              color: value ? Colors.green : Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed, {
    bool isDisabled = false,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton.icon(
          onPressed: isDisabled ? null : onPressed,
          icon: Icon(icon, size: 18),
          label: Text(
            label,
            style: const TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: color.withOpacity(0.1),
            foregroundColor: color,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: color.withOpacity(0.5)),
            ),
          ),
        ),
      ),
    );
  }
}