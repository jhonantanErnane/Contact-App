import 'package:contact_app/app/shared/widgets/globalScaffold/global_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Modular.navigatorKey,
      title: 'App de Contatos',
      builder: (context, child) {
        return Scaffold(
          key: GlobalScaffold.instance.scaffKey,
          body: child,
        );
      },
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigo,
      ),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
