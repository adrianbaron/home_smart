import '../domain/smart_home_state.dart';

class AudioApi {
  bool turnSpeakersOn(SmartHomeState state) {
    print('Audio system turned ON');
    return true;
  }

  bool turnSpeakersOff(SmartHomeState state) {
    print('Audio system turned OFF');
    return false;
  }
}