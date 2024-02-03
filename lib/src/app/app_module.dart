import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_controller.dart';
import 'app_view.dart';

class AppModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppController(),
      child: AppView(),
    );
  }
}
