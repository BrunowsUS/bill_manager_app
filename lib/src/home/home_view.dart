import 'package:bill_manager_app/src/models/bill.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Importe a biblioteca intl
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String convertToDate(String date) {
    List<String> dateParts = date.split('/');
    return '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Gerenciador de Contas'),
            backgroundColor: Colors.purple,
          ),
          body: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.purpleAccent],
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Text('Total pago: R\$ ${controller.totalPaid}',
                        style: TextStyle(color: Colors.white)),
                    Text('Total não pago: R\$ ${controller.totalUnpaid}',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.bills.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(controller.bills[index].name),
                        subtitle: Text(
                            'Vencimento: ${DateFormat('dd/MM/yyyy').format(controller.bills[index].dueDate)}'),
                        trailing: Text('R\$ ${controller.bills[index].amount}'),
                        leading: Icon(
                            controller.bills[index].isPaid
                                ? Icons.check_circle
                                : Icons.error,
                            color: controller.bills[index].isPaid
                                ? Colors.green
                                : Colors.red),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Adicionar nova conta'),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(labelText: 'Nome'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira o nome da conta.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _dueDateController,
                            decoration: InputDecoration(
                                labelText: 'Data de vencimento (dd/mm/yyyy)'),
                            onTap: () async {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                _dueDateController.text =
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
                            controller: _amountController,
                            decoration:
                                InputDecoration(labelText: 'Valor (R\$)'),
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
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Adicionar'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.addBill(Bill(
                              name: _nameController.text,
                              dueDate: DateTime.parse(
                                  convertToDate(_dueDateController.text)),
                              amount: double.parse(_amountController.text),
                            ));
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.purple,
          ),
        );
      },
    );
  }
}
