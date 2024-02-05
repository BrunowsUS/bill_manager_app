import 'package:flutter/material.dart';
import 'package:bill_manager_app/src/models/bill.dart';
import 'package:intl/intl.dart';

class BillListTile extends StatelessWidget {
  final Bill bill;
final ValueChanged<bool?> onBillStatusChanged;
  final VoidCallback onBillTapped;

  BillListTile({
    required this.bill,
    required this.onBillStatusChanged,
    required this.onBillTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bill.isPaid ? Colors.green.shade100 : null,
      child: ListTile(
        title: Text(bill.name),
        subtitle: Text('Vencimento: ${DateFormat('dd/MM/yyyy').format(bill.dueDate)}'),
        trailing: Text('R\$ ${bill.amount}'),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Pago?'),
            Checkbox(
              value: bill.isPaid,
              onChanged: onBillStatusChanged,
            ),
          ],
        ),
        onTap: onBillTapped,
      ),
    );
  }
}
