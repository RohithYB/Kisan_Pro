import 'package:flutter/material.dart';
import 'package:kisan_pro_jrf/data/models/farmer_model.dart';

import '../../../../data/dummy_data.dart';

class FarmerManagementController extends ChangeNotifier {
  List<FarmerModel> _farmers = [];
  List<FarmerModel> filteredFarmers = [];
  String searchQuery = "";
  bool isLoading = true;

  void loadFarmers() {
    isLoading = true;
    notifyListeners();

    _farmers = DummyData.farmers.cast<FarmerModel>();
    filteredFarmers = _farmers;

    isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    searchQuery = query;
    final q = query.toLowerCase();

    filteredFarmers = _farmers.where((f) {
      return f.name.toLowerCase().contains(q) || f.id.toLowerCase().contains(q);
    }).toList();

    notifyListeners();
  }
}
