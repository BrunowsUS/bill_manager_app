import 'package:flutter/material.dart';
import 'package:bill_manager_app/src/models/bill.dart';

class HomeController extends ChangeNotifier {
  List<Bill> _bills = [];
  double totalPaid = 0;
  double totalUnpaid = 0;
  String filterOption = 'Todas as contas';

  List<Bill> get bills {
    _checkBillDueDate();
    return _bills;
  }

  void _checkBillDueDate() {
    DateTime now = DateTime.now();
    for (var bill in _bills) {
      if (!bill.isPaid && bill.dueDate.isBefore(now)) {
        bill.isExpired = true;
      }
    }
  }

  List<Bill> get filteredBills {
    switch (filterOption) {
      case 'Contas pagas':
        return bills.where((bill) => bill.isPaid).toList();
      case 'Contas não pagas':
        return bills.where((bill) => !bill.isPaid).toList();
      case 'Contas vencidas':
        return bills.where((bill) => bill.isExpired && !bill.isPaid).toList();
      default:
        return bills;
    }
  }

  void setFilterOption(String option) {
    filterOption = option;
    notifyListeners();
  }

  void _updateTotalValues() {
    totalPaid = 0;
    totalUnpaid = 0;
    for (var bill in _bills) {
      if (bill.isPaid) {
        totalPaid += bill.amount;
      } else {
        totalUnpaid += bill.amount;
      }
    }
  }

  void addBill(Bill bill) {
    _bills.add(bill);
    _updateTotalValues();
    notifyListeners();
  }

  void updateBillStatus(int index, bool isPaid) {
    if (isPaid) {
      totalPaid += _bills[index].amount;
      totalUnpaid -= _bills[index].amount;
    } else {
      totalPaid -= _bills[index].amount;
      totalUnpaid += _bills[index].amount;
    }
    _bills[index].isPaid = isPaid;
    notifyListeners();
  }

  void updateBill(int index, Bill updatedBill) {
    _bills[index] = updatedBill;
    _updateTotalValues();
    notifyListeners();
  }

  void deleteBill(int index) {
    _bills.removeAt(index);
    _updateTotalValues();
    notifyListeners();
  }
}
