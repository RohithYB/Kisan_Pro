import 'package:flutter/material.dart';

import '../../../../data/dummy_data.dart';
import '../../../../data/models/vehicle_model.dart';

class VehicleController extends ChangeNotifier {
  VehicleModel? selectedVehicle;
  List<VehicleModel> ownerVehicles = [];
  bool isLoading = true;

  void loadVehicleDetails(String plateNumber) {
    selectedVehicle = DummyData.vehicles.firstWhere(
      (v) => v.plateNumber == plateNumber,
      orElse: () => DummyData.vehicles.first,
    );
    // UI might call this synchronously so we notify
    notifyListeners();
  }

  void loadOwnerVehicles(String ownerId) {
    isLoading = true;
    // simulating network delay would go here
    ownerVehicles = DummyData.vehicles;
    isLoading = false;
    notifyListeners();
  }
}
