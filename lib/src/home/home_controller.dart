import 'package:flutter/material.dart';
import 'package:bill_manager_app/src/models/bill.dart';

class HomeController extends ChangeNotifier {
  List<Bill> bills = [];
  double totalPaid = 0;
  double totalUnpaid = 0;

  void addBill(Bill bill) {
    bills.add(bill);
    notifyListeners();
  }
}
