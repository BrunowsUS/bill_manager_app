// home_view.dart
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
            title: const Text(
              'Bill-Manager',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.purple,
            actions: <Widget>[
              DropdownButton<String>(
                value: controller.filterOption,
                icon: const Icon(Icons.filter_list),
                onChanged: (String? newValue) {
                  controller.setFilterOption(newValue!);
                },
                items: <String>[
                  'Todas as contas',
                  'Contas pagas',
                  'Contas não pagas'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          body: Padding(
            padding:
                const EdgeInsets.only(top: 5.0), // Espaçamento de 5px do AppBar
            child: Column(
              children: <Widget>[
                Container(
                  width:
                      double.infinity, // Expandir por toda a extensão da tela
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100, // Cor mais fraca
                    borderRadius:
                        BorderRadius.circular(10), // Bordas arredondadas
                    boxShadow: [
                      // Sombra mais suave
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Conteúdo alinhado à esquerda
                    mainAxisSize: MainAxisSize
                        .min, // Faz o container acompanhar o tamanho do texto
                    children: <Widget>[
                      Text('Total pago: R\$ ${controller.totalPaid}',
                          style: const TextStyle(color: Colors.white)),
                      Text('Total não pago: R\$ ${controller.totalUnpaid}',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Lista de contas',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.filteredBills.length,
                    itemBuilder: (context, index) {
                      return Card(
                          color: controller.filteredBills[index].isPaid
                              ? Colors.green.shade100
                              : null, // Fundo verde claro se a conta estiver paga
                          child: ListTile(
                              title: Text(controller.filteredBills[index].name),
                              subtitle: Text(
                                  'Vencimento: ${DateFormat('dd/MM/yyyy').format(controller.filteredBills[index].dueDate)}'),
                              trailing: Text(
                                  'R\$ ${controller.filteredBills[index].amount}'),
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                      'Pago?'), // Texto 'Pago?' acima do checkbox
                                  Checkbox(
                                    value:
                                        controller.filteredBills[index].isPaid,
                                    onChanged: (bool? value) {
                                      controller.updateBillStatus(
                                          index, value!);
                                    },
                                  ),
                                ],
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Editar conta'),
                                      content: SingleChildScrollView(
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            children: <Widget>[
                                              TextFormField(
                                                controller: _nameController
                                                  ..text = controller
                                                      .filteredBills[index]
                                                      .name,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText: 'Nome'),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Por favor, insira o nome da conta.';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              TextFormField(
                                                controller: _dueDateController
                                                  ..text = DateFormat(
                                                          'dd/MM/yyyy')
                                                      .format(controller
                                                          .filteredBills[index]
                                                          .dueDate),
                                                decoration: const InputDecoration(
                                                    labelText:
                                                        'Data de vencimento (dd/mm/yyyy)'),
                                                onTap: () async {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          new FocusNode());
                                                  final DateTime? picked =
                                                      await showDatePicker(
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
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Por favor, insira a data de vencimento.';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              TextFormField(
                                                controller: _amountController
                                                  ..text = controller
                                                      .filteredBills[index]
                                                      .amount
                                                      .toString(),
                                                decoration:
                                                    const InputDecoration(
                                                        labelText:
                                                            'Valor (R\$)'),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Por favor, insira o valor.';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              CheckboxListTile(
                                                title: const Text('Pago'),
                                                value: controller
                                                    .filteredBills[index]
                                                    .isPaid,
                                                onChanged: (bool? value) {
                                                  controller.updateBillStatus(
                                                      index, value!);
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
                                          onPressed: () {
                                            controller.deleteBill(index);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Salvar'),
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              controller.updateBill(
                                                  index,
                                                  Bill(
                                                    name: _nameController.text,
                                                    dueDate: DateTime.parse(
                                                        convertToDate(
                                                            _dueDateController
                                                                .text)),
                                                    amount: double.parse(
                                                        _amountController.text),
                                                    isPaid: controller
                                                        .filteredBills[index]
                                                        .isPaid,
                                                  ));
                                              Navigator.of(context).pop();
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }));
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Adicionar nova conta'),
                      content: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _nameController,
                              decoration:
                                  const InputDecoration(labelText: 'Nome'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira o nome da conta.';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _dueDateController,
                              decoration: const InputDecoration(
                                  labelText: 'Data de vencimento'),
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
                              decoration: const InputDecoration(
                                  labelText: 'Valor (R\$)'),
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
              child: const Icon(Icons.add),
              backgroundColor: Colors.purple),
        );
      },
    );
  }
}
