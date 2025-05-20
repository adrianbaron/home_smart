
import '../domain/smart_home_state.dart';
import '../services/tv_api.dart';
import '../services/audio_api.dart';
import '../services/netflix_api.dart';
import '../services/camara_api.dart';
import '../services/playstation_api.dart';
import './smart_home_api.dart';

// Refactorizado para eliminar la dependencia cíclica con GamingFacade
class SmartHomeFacade {
  final SmartHomeApi _smartHomeApi = SmartHomeApi();
  final TvApi _tvApi = TvApi();
  final AudioApi _audioApi = AudioApi();
  final NetflixApi _netflixApi = NetflixApi();
  final PlaystationApi _playstationApi = PlaystationApi(); 
  final CameraApi _cameraApi = CameraApi();
  
  SmartHomeState _state = SmartHomeState();
  
  SmartHomeState get state => _state;
  
  void _updateState(SmartHomeState newState) {
    _state = newState;
  }
  
  // Métodos para Home Cinema
  void startMovie(SmartHomeState state, String movieTitle) {
    _updateState(state.copyWith(
      tvOn: _tvApi.turnOn(state),
      audioSystemOn: _audioApi.turnSpeakersOn(state),
      netflixConnected: _netflixApi.connect(state),
      lightsOn: false,
      // Asegurarse de que otros sistemas estén apagados
      gamingConsoleOn: false,
      streamingCameraOn: false,
    ));
    
    _netflixApi.playTitle(movieTitle, _state);
    print('Home cinema mode started with $movieTitle');
  }
  
  void stopMovie(SmartHomeState state) {
    _updateState(state.copyWith(
      tvOn: _tvApi.turnOff(state),
      audioSystemOn: _audioApi.turnSpeakersOff(state),
      netflixConnected: _netflixApi.disconnect(state),
      lightsOn: true,
    ));
    
    print('Home cinema mode stopped');
  }
  
  // Métodos para Gaming
  void startGaming(SmartHomeState state, String gameTitle) {
    // Actualizar directamente sin pasar por otra facade
    _updateState(state.copyWith(
      tvOn: _tvApi.turnOn(state),
      // Preferencias específicas para gaming
      audioSystemOn: _audioApi.turnSpeakersOn(state),
      lightsOn: false,
      gamingConsoleOn: _playstationApi.turnOn(state),
      // Asegurarse de que otros sistemas estén apagados
      netflixConnected: _netflixApi.disconnect(state), 
      streamingCameraOn: false,
    ));
    
    print('Gaming mode started with $gameTitle');
  }
  
  void stopGaming(SmartHomeState state) {
    _updateState(state.copyWith(
      gamingConsoleOn: _playstationApi.turnOff(state),
      tvOn: _tvApi.turnOff(state),
      audioSystemOn: _audioApi.turnSpeakersOff(state),
      lightsOn: true,
    ));
    
    print('Gaming mode stopped');
  }
  
  // Métodos para Streaming
  void startStreaming(SmartHomeState state) {
    _updateState(state.copyWith(
      tvOn: _tvApi.turnOn(state),
      audioSystemOn: _audioApi.turnSpeakersOn(state),
      streamingCameraOn: _cameraApi.turnCameraOn(state),
      // Configuraciones específicas para streaming
      lightsOn: true, // Luz encendida para buena visibilidad
      // Asegurarse de que otros sistemas estén apagados o encendidos según necesidad
      netflixConnected: false,
      gamingConsoleOn: false, // Se podría permitir encendido para streaming de juegos
    ));
    
    print('Streaming mode started');
  }
  
  void stopStreaming(SmartHomeState state) {
    _updateState(state.copyWith(
      streamingCameraOn: _cameraApi.turnCameraOff(state),
      tvOn: _tvApi.turnOff(state),
      audioSystemOn: _audioApi.turnSpeakersOff(state),
    ));
    
    print('Streaming mode stopped');
  }
  
  // Método para el control de audio independiente
  void toggleAudio() {
    final newAudioState = !_state.audioSystemOn;
    if (newAudioState) {
      _audioApi.turnSpeakersOn(_state);
    } else {
      _audioApi.turnSpeakersOff(_state);
    }
    _updateState(_state.copyWith(audioSystemOn: newAudioState));
  }
  
  // Control de luces
  bool toggleLights() {
    final newLightState = !_state.lightsOn;
    if (newLightState) {
      _smartHomeApi.turnLightsOn(_state);
    } else {
      _smartHomeApi.turnLightsOff(_state);
    }
    _updateState(_state.copyWith(lightsOn: newLightState));
    return newLightState;
  }
  
  // Nuevo método para apagar todo el sistema
  void shutdownSystem() {
    _updateState(SmartHomeState(
      tvOn: _tvApi.turnOff(_state),
      audioSystemOn: _audioApi.turnSpeakersOff(_state),
      netflixConnected: _netflixApi.disconnect(_state),
      gamingConsoleOn: _playstationApi.turnOff(_state),
      streamingCameraOn: _cameraApi.turnCameraOff(_state),
      lightsOn: true, // Dejamos las luces encendidas por seguridad
    ));
    
    print('System shutdown complete');
  }
}