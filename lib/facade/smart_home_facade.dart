import '../domain/smart_home_state.dart';
import '../services/tv_api.dart';
import '../services/audio_api.dart';
import '../services/netflix_api.dart';
import './smart_home_api.dart';
import './gaming_facade.dart';

class SmartHomeFacade {
  final SmartHomeApi _smartHomeApi = SmartHomeApi();
  final TvApi _tvApi = TvApi();
  final AudioApi _audioApi = AudioApi();
  final NetflixApi _netflixApi = NetflixApi();
  final GamingFacade _gamingFacade = GamingFacade();
  
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
  
  // Métodos para Gaming - ahora delegados a GamingFacade
  void startGaming(SmartHomeState state, String gameTitle) {
    // Primero encendemos la TV y configuramos el entorno básico
    _updateState(state.copyWith(
      tvOn: _tvApi.turnOn(state),
      audioSystemOn: _audioApi.turnSpeakersOn(state),
      lightsOn: false,
      netflixConnected: _netflixApi.disconnect(state),
    ));
    
    // Delegamos la configuración específica de gaming a GamingFacade
    _gamingFacade.startGaming(_state, _updateState, gameTitle);
  }
  
  void stopGaming(SmartHomeState state) {
    // Delegamos detención específica al GamingFacade
    _gamingFacade.stopGaming(state, _updateState);
    
    // Completamos la configuración general del sistema
    _updateState(_state.copyWith(
      tvOn: _tvApi.turnOff(state),
      audioSystemOn: _audioApi.turnSpeakersOff(state),
      lightsOn: true,
    ));
  }
  
  // Métodos para Streaming - ahora parcialmente delegados a GamingFacade
  void startStreaming(SmartHomeState state) {
    // Configuración básica del entorno
    _updateState(state.copyWith(
      tvOn: _tvApi.turnOn(state),
      audioSystemOn: _audioApi.turnSpeakersOn(state),
      lightsOn: true,
      netflixConnected: false,
      gamingConsoleOn: false,
    ));
    
    // Delegamos la configuración específica de streaming
    _gamingFacade.startStreaming(_state, _updateState);
  }
  
  void stopStreaming(SmartHomeState state) {
    // Delegamos la detención específica al GamingFacade
    _gamingFacade.stopStreaming(state, _updateState);
    
    // Completamos la configuración general
    _updateState(_state.copyWith(
      tvOn: _tvApi.turnOff(state),
      audioSystemOn: _audioApi.turnSpeakersOff(state),
    ));
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
  
  // Método para apagar todo el sistema
  void shutdownSystem() {
    _updateState(SmartHomeState(
      tvOn: _tvApi.turnOff(_state),
      audioSystemOn: _audioApi.turnSpeakersOff(_state),
      netflixConnected: _netflixApi.disconnect(_state),
      gamingConsoleOn: false, // Ya no accedemos directamente a la API
      streamingCameraOn: false, // Ya no accedemos directamente a la API
      lightsOn: false,
    ));
    
    print('System shutdown complete');
  }
}