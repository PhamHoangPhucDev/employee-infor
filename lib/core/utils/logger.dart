class Logger {
  Logger._();

  static void log(String message) {
    // Có thể thay bằng logger package
    // ignore: avoid_print
    print("[APP LOG] $message");
  }
}
