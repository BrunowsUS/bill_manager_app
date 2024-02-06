import 'package:flutter/material.dart';
import 'package:bill_manager_app/src/models/bill.dart';

class EditBillDialog extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController dueDateController;
  final TextEditingController amountController;
  final VoidCallback onBillSaved;
  final VoidCallback onBillDeleted;
  final Bill bill;

  EditBillDialog({
    required this.formKey,
    required this.nameController,
    required this.dueDateController,
    required this.amountController,
    required this.onBillSaved,
    required this.onBillDeleted,
    required this.bill,
  });

  @override
  _EditBillDialogState createState() => _EditBillDialogState();
}

class _EditBillDialogState extends State<EditBillDialog> {
  bool isPaid = false;

  @override
  void initState() {
    super.initState();
    isPaid = widget.bill.isPaid;
  }

  @override
  Widget build(BuildContext context) {
    widget.nameController.text = widget.bill.name;
    widget.dueDateController.text =
        "${widget.bill.dueDate.day.toString().padLeft(2, '0')}/${widget.bill.dueDate.month.toString().padLeft(2, '0')}/${widget.bill.dueDate.year.toString()}";
    widget.amountController.text = widget.bill.amount.toString();

    return AlertDialog(
      title: const Text('Editar conta'),
      content: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
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
                      controller: widget.nameController,
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
                          widget.dueDateController.text =
                              "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString()}";
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: widget.dueDateController,
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
                      controller: widget.amountController,
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
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    child: const Text('Pago'),
                  ),
                  Expanded(
                    child: Checkbox(
                      value: isPaid,
                      onChanged: (bool? value) {
                        if (value != null) {
                          setState(() {
                            isPaid = value;
                            widget.bill.isPaid = value;
                          });
                        }
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
              primary: Colors.red.shade100,
            ),
            child: const Text('Excluir'),
            onPressed: widget.onBillDeleted,
          ),
        ),
        Container(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade100,
            ),
            child: const Text('Salvar'),
            onPressed: widget.onBillSaved,
          ),
        ),
      ],
    );
  }
}
