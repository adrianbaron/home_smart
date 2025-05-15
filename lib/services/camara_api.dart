import '../domain/smart_home_state.dart';

class CameraApi {
  bool turnCameraOn(SmartHomeState state) {
    print('Camera turned ON');
    return true;
  }

  bool turnCameraOff(SmartHomeState state) {
    print('Camera turned OFF');
    return false;
  }
}