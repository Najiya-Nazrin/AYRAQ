import 'package:flutter/services.dart';

class ThreatChannel {
  static const MethodChannel _channel = MethodChannel('threat_channel');

  static void initThreatListener(Function(String) onThreatDetected) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == "checkThreat") {
        String content = call.arguments;
        onThreatDetected(content); // call your AI classifier here
      }
    });
  }
}
