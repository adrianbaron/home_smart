import '../domain/smart_home_state.dart';
import '../services/camara_api.dart';
import '../services/playstation_api.dart';

class GamingFacade {
  final PlaystationApi _playstationApi = PlaystationApi();
  final CameraApi _cameraApi = CameraApi();
  
  void startGaming(SmartHomeState state, Function(SmartHomeState) updateState, String gameTitle) {
    final newState = state.copyWith(
      gamingConsoleOn: _playstationApi.turnOn(state),
      streamingCameraOn: _cameraApi.turnCameraOff(state),
    );
    
    updateState(newState);
    print('Gaming mode started with $gameTitle');
  }
  
  void stopGaming(SmartHomeState state, Function(SmartHomeState) updateState) {
    final newState = state.copyWith(
      gamingConsoleOn: _playstationApi.turnOff(state),
      streamingCameraOn: _cameraApi.turnCameraOff(state),
    );
    
    updateState(newState);
    print('Gaming mode stopped');
  }

  void startStreaming(SmartHomeState state, Function(SmartHomeState) updateState) {
    final newState = state.copyWith(
      streamingCameraOn: _cameraApi.turnCameraOn(state),
    );
    
    updateState(newState);
    print('Streaming started');
  }
  
  void stopStreaming(SmartHomeState state, Function(SmartHomeState) updateState) {
    final newState = state.copyWith(
      streamingCameraOn: _cameraApi.turnCameraOff(state),
    );
    
    updateState(newState);
    print('Streaming stopped');
  }
}