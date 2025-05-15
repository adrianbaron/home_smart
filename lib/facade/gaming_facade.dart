import 'package:home_smart/services/camara_api.dart';
import 'package:home_smart/services/playstation_api.dart';
import 'package:home_smart/services/tv_api.dart';

import '../domain/smart_home_state.dart';


class GamingFacade {
  final PlaystationApi _playstationApi = PlaystationApi();
  final CameraApi _cameraApi = CameraApi();
  final TvApi _tvApi = TvApi();
  
  void startGaming(SmartHomeState state, SmartHomeState Function(SmartHomeState) updateState, String moveTitle) {
    final newState = updateState(state.copyWith(
      gamingConsoleOn: _playstationApi.turnOn(state),
      streamingCameraOn: _cameraApi.turnCameraOff(state),
      tvOn: _tvApi.turnOn(state)
    ));
    
    print('Gaming mode started with $moveTitle');
  }
  
  void stopGaming(SmartHomeState state, SmartHomeState Function(SmartHomeState) updateState) {
    final newState = updateState(state.copyWith(
      gamingConsoleOn: _playstationApi.turnOff(state),
      streamingCameraOn: _cameraApi.turnCameraOff(state),
    ));
    
    print('Gaming mode stopped');
  }

  void startStreaming(SmartHomeState state, SmartHomeState Function(SmartHomeState) updateState) {
    final newState = updateState(state.copyWith(
      streamingCameraOn: _cameraApi.turnCameraOn(state),
      tvOn: _tvApi.turnOn(state)
    ));
    
    print('Streaming started');
  }
  
  void stopStreaming(SmartHomeState state, SmartHomeState Function(SmartHomeState) updateState) {
    final newState = updateState(state.copyWith(
      streamingCameraOn: _cameraApi.turnCameraOff(state),
    ));
    
    print('Streaming stopped');
  }
}