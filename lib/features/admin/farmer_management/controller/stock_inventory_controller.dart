import 'package:flutter/material.dart';

class StockInventoryController extends ChangeNotifier {
  String totalUnits = "42";
  String healthyCount = "34";
  String pestAlertsCount = "04";
  String lowStockCount = "04";
  String expiringSoonCount = "05";

  void loadInventoryData(String farmerId) {
    // In a real app, load from API/models
    notifyListeners();
  }
}
