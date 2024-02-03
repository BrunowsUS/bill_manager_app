import 'package:flutter/material.dart';

class BillCard extends StatelessWidget {
  final String billName;
  final String dueDate;
  final double amount;
  final bool isPaid;

  BillCard(
      {this.billName = '',
      this.dueDate = '',
      this.amount = 0.0,
      this.isPaid = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(billName),
        subtitle: Text('Vencimento: $dueDate'),
        trailing: Text('R\$ $amount'),
        leading: Icon(isPaid ? Icons.check_circle : Icons.error,
            color: isPaid ? Colors.green : Colors.red),
      ),
    );
  }
}
