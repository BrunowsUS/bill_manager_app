import 'package:flutter/material.dart';
import 'package:bill_manager_app/src/models/bill.dart';

class EditBillDialog extends StatelessWidget {
  final Bill bill;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController dueDateController;
  final TextEditingController amountController;
  final VoidCallback onBillDeleted;
  final VoidCallback onBillSaved;

  EditBillDialog({
    required this.bill,
    required this.formKey,
    required this.nameController,
    required this.dueDateController,
    required this.amountController,
    required this.onBillDeleted,
    required this.onBillSaved,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar conta'),
      content: SingleChildScrollView(
        child: Form(
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
                decoration: const InputDecoration(
                    labelText: 'Data de vencimento (dd/mm/yyyy)'),
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
                decoration:
                    const InputDecoration(labelText: 'Valor (R\$)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o valor.';
                  }
                  return null;
                },
              ),
              CheckboxListTile(
                title: const Text('Pago'),
                value: bill.isPaid,
                onChanged: (bool? value) {
                  bill.isPaid = value!;
                },
              ),
            ],
          ),
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
          child: const Text('Deletar'),
          onPressed: onBillDeleted,
        ),
        TextButton(
          child: const Text('Salvar'),
          onPressed: onBillSaved,
        ),
      ],
    );
  }
}
