import 'package:flutter/material.dart';

class CattleMonitoringController extends ChangeNotifier {
  bool isLiveFeedActive = true;
  String healthyCount = "22";
  String criticalCount = "0";
  String observationCount = "1";

  // Telemetry data
  String pastureTemp = "27.5 °C";
  String soilMoisture = "64%";
  String humidity = "58%";

  void loadMonitoringData(String farmerId) {
    // In a real app, fetch data based on farmerId
    if (farmerId == "FRM-2045") {
      criticalCount = "1";
    }
    notifyListeners();
  }
}
