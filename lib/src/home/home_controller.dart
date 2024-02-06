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

  void addBill(Bill bill) {
    bills.add(bill);
    if (bill.isPaid) {
      totalPaid += bill.amount;
    } else {
      totalUnpaid += bill.amount;
    }
    notifyListeners();
  }

  void updateBillStatus(int index, bool isPaid) {
    if (isPaid) {
      totalPaid += bills[index].amount;
      totalUnpaid -= bills[index].amount;
    } else {
      totalPaid -= bills[index].amount;
      totalUnpaid += bills[index].amount;
    }
    bills[index].isPaid = isPaid;
    notifyListeners();
  }

  void updateBill(int index, Bill updatedBill) {
    if (bills[index].isPaid != updatedBill.isPaid) {
      updateBillStatus(index, updatedBill.isPaid);
    } else {
      if (bills[index].isPaid) {
        totalPaid = totalPaid - bills[index].amount + updatedBill.amount;
      } else {
        totalUnpaid = totalUnpaid - bills[index].amount + updatedBill.amount;
      }
    }
    bills[index] = updatedBill;
    notifyListeners();
  }

  void deleteBill(int index) {
    if (bills[index].isPaid) {
      totalPaid -= bills[index].amount;
    } else {
      totalUnpaid -= bills[index].amount;
    }
    bills.removeAt(index);
    notifyListeners();
  }
}
