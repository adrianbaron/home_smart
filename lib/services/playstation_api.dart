import '../domain/smart_home_state.dart';

class PlaystationApi {
  bool turnOn(SmartHomeState state) {
    print('PlayStation turned ON');
    return true;
  }

  bool turnOff(SmartHomeState state) {
    print('PlayStation turned OFF');
    return false;
  }
}