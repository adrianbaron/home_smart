import 'package:flutter/material.dart';
import '../data/mode_data.dart';
import '../domain/smart_home_state.dart';
import '../facade/smart_home_facade.dart';
import 'components/device_icon.dart';
import 'components/mode_switcher.dart';
import 'components/facade_example.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final SmartHomeFacade _facade = SmartHomeFacade();
  late TabController _tabController;
  
  // Mode states
  bool homeTheaterMode = false;
  bool gamingMode = false;
  bool streamingMode = false;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  void _toggleMode(String mode, bool value) {
    setState(() {
      switch (mode) {
        case 'Home Cinema':
          homeTheaterMode = value;
          if (value) {
            _facade.startMovie(_facade.state, 'Avengers: Endgame');
            // Turn off other modes
            gamingMode = false;
            streamingMode = false;
          } else {
            _facade.stopMovie(_facade.state);
          }
          break;
        case 'Gaming':
          gamingMode = value;
          if (value) {
            _facade.startGaming(_facade.state, 'Call of Duty');
            // Turn off other modes
            homeTheaterMode = false;
            streamingMode = false;
            
          } else {
            _facade.stopGaming(_facade.state);
          }
          break;
        case 'Streaming':
          streamingMode = value;
          if (value) {
            _facade.startStreaming(_facade.state);
            // Turn off other modes
            homeTheaterMode = false;
            gamingMode = false;
          } else {
            _facade.stopStreaming(_facade.state);
          }
          break;
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Smart Home Control',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Dashboard', icon: Icon(Icons.dashboard)),
            Tab(text: 'Advanced', icon: Icon(Icons.settings)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildAdvancedTab(),
        ],
      ),
    );
  }
  
  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildModeSection(),
          const SizedBox(height: 24),
          _buildStatusSection(),
          const SizedBox(height: 24),
          _buildDeviceControlSection(),
        ],
      ),
    );
  }
  
  Widget _buildAdvancedTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Facade Pattern Implementation',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This example demonstrates the Facade design pattern applied to a smart home system.',
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 16),
          FacadeExample(
            facade: _facade,
            state: _facade.state,
            onStateChanged: () => setState(() {}),
          ),
        ],
      ),
    );
  }
  
  Widget _buildModeSection() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Smart Home Modes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ModeSwitcher(
              mode: availableModes[0],
              isActive: homeTheaterMode,
              onChanged: (value) => _toggleMode('Home Cinema', value),
            ),
            const Divider(),
            ModeSwitcher(
              mode: availableModes[1],
              isActive: gamingMode,
              onChanged: (value) => _toggleMode('Gaming', value),
            ),
            const Divider(),
            ModeSwitcher(
              mode: availableModes[2],
              isActive: streamingMode,
              onChanged: (value) => _toggleMode('Streaming', value),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatusSection() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'System Status',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildStatusItem('TV', _facade.state.tvOn),
            _buildStatusItem('Audio System', _facade.state.audioSystemOn),
            _buildStatusItem('Lights', _facade.state.lightsOn),
            _buildStatusItem('Netflix', _facade.state.netflixConnected),
            _buildStatusItem('Gaming Console', _facade.state.gamingConsoleOn),
            _buildStatusItem('Camera', _facade.state.streamingCameraOn),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatusItem(String label, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: isActive ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Text(
            isActive ? 'ON' : 'OFF',
            style: TextStyle(
              color: isActive ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDeviceControlSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Controls',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DeviceIcon(
              icon: Icons.tv,
              label: 'TV',
              color: Colors.indigo,
              isActive: _facade.state.tvOn,
              onTap: () {
                setState(() {
                  if (_facade.state.tvOn) {
                    _facade.stopMovie(_facade.state);
                    homeTheaterMode = false;
                  } else {
                    _facade.startMovie(_facade.state, 'Quick Play');
                    homeTheaterMode = true;
                  }
                });
              },
            ),
            DeviceIcon(
              icon: Icons.speaker,
              label: 'Audio',
              color: Colors.orange,
              isActive: _facade.state.audioSystemOn,
              onTap: () {
                // This would typically be handled through the facade
                // For demo purposes, we're just showing the UI state
                setState(() {});
              },
            ),
            DeviceIcon(
              icon: Icons.lightbulb,
              label: 'Lights',
              color: Colors.amber,
              isActive: _facade.state.lightsOn,
              onTap: () {
                setState(() {
                  _facade.toggleLights();
                });
              },
            ),
            DeviceIcon(
              icon: Icons.videogame_asset,
              label: 'Gaming',
              color: Colors.blue,
              isActive: _facade.state.gamingConsoleOn,
              onTap: () {
                setState(() {
                  if (_facade.state.gamingConsoleOn) {
                    _facade.stopGaming(_facade.state);
                    gamingMode = false;
                  } else {
                    _facade.startGaming(_facade.state, 'Quick Game');
                    gamingMode = true;
                  }
                });
              },
            ),
            DeviceIcon(
              icon: Icons.camera_alt,
              label: 'Camera',
              color: Colors.green,
              isActive: _facade.state.streamingCameraOn,
              onTap: () {
                setState(() {
                  if (_facade.state.streamingCameraOn) {
                    _facade.stopStreaming(_facade.state);
                    streamingMode = false;
                  } else {
                    _facade.startStreaming(_facade.state);
                    streamingMode = true;
                  }
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}