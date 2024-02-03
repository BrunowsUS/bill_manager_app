import 'package:bill_manager_app/src/home/home_module.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_controller.dart';

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(
      builder: (context, controller, child) {
        return MaterialApp(
          theme: controller.themeData,
          home: HomeModule(),
        );
      },
    );
  }
}
