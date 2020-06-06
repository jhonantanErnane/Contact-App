import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'contact_controller.dart';

class ContactPage extends StatefulWidget {
  final String title;
  const ContactPage({Key key, this.title = "Contact"}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends ModularState<ContactPage, ContactController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
