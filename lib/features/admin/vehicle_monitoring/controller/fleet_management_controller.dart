import 'package:flutter/material.dart';

import '../../../../data/dummy_data.dart';
import '../../../../data/models/fleet_owner_model.dart';

class FleetManagementController extends ChangeNotifier {
  List<FleetOwnerModel> fleetOwners = [];

  // Top metrics
  String totalFleetOwners = "12";
  String activeVehicles = "85";
  String totalDeliveriesToday = "142";

  void loadFleetOwners() {
    fleetOwners = DummyData.fleetOwners;
    notifyListeners();
  }
}
