import 'package:bill_manager_app/src/home/home_controller.dart';
import 'package:flutter/material.dart';

class FilterDropdownButton extends StatelessWidget {
  final HomeController controller;

  FilterDropdownButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
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
    );
  }
}
