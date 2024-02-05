import 'package:flutter/material.dart';

class AddBillDialog extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController dueDateController;
  final TextEditingController amountController;
  final VoidCallback onBillAdded;

  const AddBillDialog({
    required this.formKey,
    required this.nameController,
    required this.dueDateController,
    required this.amountController,
    required this.onBillAdded,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar nova conta'),
      content: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome da conta.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: dueDateController,
              decoration: const InputDecoration(labelText: 'Data de vencimento'),
              onTap: () async {
                FocusScope.of(context).requestFocus(new FocusNode());
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  dueDateController.text =
                      "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString()}";
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira a data de vencimento.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Valor (R\$)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o valor.';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Adicionar'),
          onPressed: onBillAdded,
        ),
      ],
    );
  }
}
