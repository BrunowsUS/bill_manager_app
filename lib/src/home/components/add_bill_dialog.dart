import 'package:flutter/material.dart';

class AddBillDialog extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController dueDateController;
  final TextEditingController amountController;
  final VoidCallback onBillAdded;

  AddBillDialog({
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
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    child: const Icon(Icons.text_fields),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome da conta.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    child: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
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
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: dueDateController,
                      decoration: const InputDecoration(
                        labelText: 'Data de vencimento',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    child: const Text('R\$'),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: amountController,
                      decoration: const InputDecoration(
                        labelText: 'Valor',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o valor.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Container(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade100,
            ),
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade100,
            ),
            child: const Text('Adicionar'),
            onPressed: onBillAdded,
          ),
        ),
      ],
    );
  }
}
