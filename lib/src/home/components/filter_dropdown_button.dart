import 'package:bill_manager_app/src/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterDropdownButton extends StatelessWidget {
  final HomeController controller;

  FilterDropdownButton({required this.controller});

  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.purple, // Altera a cor de fundo do menu dropdown
      ),
      child: DropdownButton<String>(
        value: controller.filterOption,
        icon: const Icon(Icons.filter_list,
            color: Colors.white), // Altera a cor do ícone
        style: GoogleFonts.lato(
          // Altera a fonte e a cor do texto
          textStyle: const TextStyle(color: Colors.white),
        ),
        underline: Container(
          height: 2,
          color: Colors.white, // Altera a cor do sublinhado
        ),
        onChanged: (String? newValue) {
          controller.setFilterOption(newValue!);
        },
        items: <String>[
          'Todas as contas',
          'Contas pagas',
          'Contas não pagas',
          'Contas vencidas', // Nova opção
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
