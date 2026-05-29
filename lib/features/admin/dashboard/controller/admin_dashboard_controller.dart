import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/core/constants/colors.dart';

class AdminDashboardController extends ChangeNotifier {
  // Metrics Data
  final String totalFarmers = "1,248";
  final String fleetOwners = "84";
  final String activeDeliveries = "52";
  final String businessCustomers = "432";

  // Module Stats
  final List<Map<String, dynamic>> farmerStats = [
    {"label": "Total Farmers", "value": "1,248", "color": AppColors.textPrimary},
    {"label": "Cattle Alerts", "value": "18", "color": Colors.redAccent},
    {"label": "Inventory Alerts", "value": "12", "color": Colors.orangeAccent},
  ];

  final List<Map<String, dynamic>> fleetStats = [
    {"label": "Active Vehicles", "value": "52", "color": AppColors.textPrimary},
    {"label": "In Transit", "value": "34", "color": Colors.blueAccent},
    {"label": "Driver Alerts", "value": "03", "color": Colors.redAccent},
  ];

  final List<Map<String, dynamic>> customerStats = [
    {"label": "Active Customers", "value": "432", "color": AppColors.textPrimary},
    {"label": "Orders Today", "value": "128", "color": Colors.blueAccent},
    {"label": "Complaints", "value": "04", "color": Colors.redAccent},
  ];

  // In a real app, you would fetch these from a service layer.
  void loadDashboardData() {
    // API Call to fetch metrics and set states
    notifyListeners();
  }
}

