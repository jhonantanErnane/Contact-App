import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'contact_controller.dart';

class ContactPage extends StatefulWidget {
  final String title;
  final int contactId;
  const ContactPage({this.title = "Contact", this.contactId});

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
