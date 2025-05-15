class SmartHomeState {
  bool tvOn;
  bool audioSystemOn;
  bool netflixConnected;
  bool gamingConsoleOn;
  bool streamingCameraOn;
  bool lightsOn;

  SmartHomeState({
    this.tvOn = false,
    this.audioSystemOn = false,
    this.netflixConnected = false,
    this.gamingConsoleOn = false,
    this.streamingCameraOn = false,
    this.lightsOn = true,
  });

  SmartHomeState copyWith({
    bool? tvOn,
    bool? audioSystemOn,
    bool? netflixConnected,
    bool? gamingConsoleOn,
    bool? streamingCameraOn,
    bool? lightsOn,
  }) {
    return SmartHomeState(
      tvOn: tvOn ?? this.tvOn,
      audioSystemOn: audioSystemOn ?? this.audioSystemOn,
      netflixConnected: netflixConnected ?? this.netflixConnected,
      gamingConsoleOn: gamingConsoleOn ?? this.gamingConsoleOn,
      streamingCameraOn: streamingCameraOn ?? this.streamingCameraOn,
      lightsOn: lightsOn ?? this.lightsOn,
    );
  }

  @override
  String toString() {
    return '''SmartHomeState {
      tvOn: $tvOn,
      audioSystemOn: $audioSystemOn,
      netflixConnected: $netflixConnected,
      gamingConsoleOn: $gamingConsoleOn,
      streamingCameraOn: $streamingCameraOn,
      lightsOn: $lightsOn
    }''';
  }
}