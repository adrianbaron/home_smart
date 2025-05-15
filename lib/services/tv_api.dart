import '../domain/smart_home_state.dart';

class TvApi {
  bool turnOn(SmartHomeState state) {
    print('TV turned ON');
    return true;
  }

  bool turnOff(SmartHomeState state) {
    print('TV turned OFF');
    return false;
  }
}






