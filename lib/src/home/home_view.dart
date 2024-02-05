import 'package:bill_manager_app/src/home/components/edit_bill_dialog.dart';
import 'package:bill_manager_app/src/home/components/add_bill_dialog.dart';
import 'package:bill_manager_app/src/home/components/bill_list_tile.dart';
import 'package:bill_manager_app/src/home/components/filter_dropdown_button.dart';
import 'package:bill_manager_app/src/home/components/total_amount_container.dart';
import 'package:bill_manager_app/src/models/bill.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              FilterDropdownButton(controller: controller),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              children: <Widget>[
                TotalAmountContainer(controller: controller),
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
                      return BillListTile(
                        bill: controller.filteredBills[index],
                        onBillStatusChanged: (bool? value) {
                          if (value != null) {
                            controller.updateBillStatus(index, value);
                          }
                        },
                        onBillTapped: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EditBillDialog(
                                bill: controller.filteredBills[index],
                                formKey: _formKey,
                                nameController: _nameController,
                                dueDateController: _dueDateController,
                                amountController: _amountController,
                                onBillDeleted: () {
                                  controller.deleteBill(index);
                                  Navigator.of(context).pop();
                                },
                                onBillSaved: () {
                                  if (_formKey.currentState!.validate()) {
                                    controller.updateBill(
                                        index,
                                        Bill(
                                          name: _nameController.text,
                                          dueDate: DateTime.parse(convertToDate(
                                              _dueDateController.text)),
                                          amount: double.parse(
                                              _amountController.text),
                                          isPaid: controller
                                              .filteredBills[index].isPaid,
                                        ));
                                    Navigator.of(context).pop();
                                  }
                                },
                              );
                            },
                          );
                        },
                      );
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
                    return AddBillDialog(
                      formKey: _formKey,
                      nameController: _nameController,
                      dueDateController: _dueDateController,
                      amountController: _amountController,
                      onBillAdded: () {
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
