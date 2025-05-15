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
  
  void startMovie(SmartHomeState state, String movieTitle) {
    _updateState(state.copyWith(
      tvOn: _tvApi.turnOn(state),
      audioSystemOn: _audioApi.turnSpeakersOn(state),
      netflixConnected: _netflixApi.connect(state),
      lightsOn: false,
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
  
  void startGaming(SmartHomeState state, String gameTitle) {
    _updateState(state.copyWith(
      tvOn: _tvApi.turnOn(state),
      audioSystemOn: _audioApi.turnSpeakersOff(state),
      lightsOn: false,
      streamingCameraOn: false,
      gamingConsoleOn: true
    ));
    
    _gamingFacade.startGaming(state, (s) {
      _updateState(s);
      return _state;
    }, gameTitle);
    
    print('Gaming mode started with $gameTitle');
  }
  
  void stopGaming(SmartHomeState state) {
    _gamingFacade.stopGaming(state, (s) {
      _updateState(s);
      return _state;
    });
    
    _updateState(state.copyWith(
      tvOn: _tvApi.turnOff(state),
      audioSystemOn: _audioApi.turnSpeakersOff(state),
    ));
    
    print('Gaming mode stopped');
  }
  
  void startStreaming(SmartHomeState state) {
    _updateState(state.copyWith(
      tvOn: _tvApi.turnOn(state),
      audioSystemOn: _audioApi.turnSpeakersOn(state),
    ));
    
    _gamingFacade.startStreaming(state, (s) {
      _updateState(s);
      return _state;
    });
    
    print('Streaming mode started');
  }
  
  void stopStreaming(SmartHomeState state) {
    _gamingFacade.stopStreaming(state, (s) {
      _updateState(s);
      return _state;
    });
    
    _updateState(state.copyWith(
      tvOn: _tvApi.turnOff(state),
      audioSystemOn: _audioApi.turnSpeakersOff(state),
    ));
    
    print('Streaming mode stopped');
  }
  
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
}