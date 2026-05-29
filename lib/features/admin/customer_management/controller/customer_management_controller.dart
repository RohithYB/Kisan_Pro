import 'package:flutter/material.dart';
import '../../../../data/models/customer_model.dart';
import '../../../../data/dummy_data.dart';

class CustomerManagementController extends ChangeNotifier {
  List<CustomerModel> _customers = [];
  List<CustomerModel> filteredCustomers = [];
  String searchQuery = "";
  bool isLoading = true;

  void loadCustomers() {
    isLoading = true;
    notifyListeners();

    _customers = DummyData.customers;
    filteredCustomers = _customers;

    isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    searchQuery = query;
    final q = query.toLowerCase();
    
    filteredCustomers = _customers.where((c) {
      return c.businessName.toLowerCase().contains(q) || c.id.toLowerCase().contains(q);
    }).toList();
    
    notifyListeners();
  }
}
