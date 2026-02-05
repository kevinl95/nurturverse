class BoincService {
  bool running = false;

  void start() {
    running = true;
  }

  void stop() {
    running = false;
  }
}
