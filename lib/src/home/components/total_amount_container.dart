import 'package:bill_manager_app/src/home/home_controller.dart';
import 'package:flutter/material.dart';

class TotalAmountContainer extends StatelessWidget {
  final HomeController controller;

  TotalAmountContainer({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.purple.shade100,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Total pago: R\$ ${controller.totalPaid}',
              style: const TextStyle(color: Colors.white)),
          Text('Total não pago: R\$ ${controller.totalUnpaid}',
              style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
