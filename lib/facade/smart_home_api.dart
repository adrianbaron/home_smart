import '../domain/smart_home_state.dart';
import '../services/tv_api.dart';
import '../services/audio_api.dart';

class SmartHomeApi {
  final TvApi _tvApi = TvApi();
  final AudioApi _audioApi = AudioApi();

  bool turnLightsOn(SmartHomeState state) {
    print('Lights turned ON');
    return true;
  }

  bool turnLightsOff(SmartHomeState state) {
    print('Lights turned OFF');
    return false;
  }
  
  bool turnTvOn(SmartHomeState state) {
    return _tvApi.turnOn(state);
  }
  
  bool turnTvOff(SmartHomeState state) {
    return _tvApi.turnOff(state);
  }
  
  bool turnAudioOn(SmartHomeState state) {
    return _audioApi.turnSpeakersOn(state);
  }
  
  bool turnAudioOff(SmartHomeState state) {
    return _audioApi.turnSpeakersOff(state);
  }
}
