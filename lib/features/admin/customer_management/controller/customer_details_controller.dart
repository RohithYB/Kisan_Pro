import 'package:flutter/material.dart';
import '../../../../data/models/customer_model.dart';
import '../../../../data/dummy_data.dart';

class CustomerDetailsController extends ChangeNotifier {
  CustomerModel? customer;
  bool isLoading = true;

  void loadCustomerDetails(String customerId) {
    isLoading = true;
    notifyListeners();

    customer = DummyData.customers.firstWhere(
      (c) => c.id == customerId,
      orElse: () => DummyData.customers.first,
    );

    isLoading = false;
    notifyListeners();
  }
}
