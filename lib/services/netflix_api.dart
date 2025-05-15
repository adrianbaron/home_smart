import '../domain/smart_home_state.dart';

class NetflixApi {
  bool connect(SmartHomeState state) {
    print('Netflix connected');
    return true;
  }

  bool disconnect(SmartHomeState state) {
    print('Netflix disconnected');
    return false;
  }

  void playTitle(String title, SmartHomeState state) {
    print('Playing $title on Netflix');
  }
}