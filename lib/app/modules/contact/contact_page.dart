import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
  void initState() {
    super.initState();
    controller.setupValidations();
  }

  @override
  Widget build(BuildContext context) {
    Widget inputName = Observer(
      builder: (_) {
        return TextField(
          autofocus: true,
          keyboardType: TextInputType.text,
          onChanged: (v) => controller.name = v,
          inputFormatters: [
            LengthLimitingTextInputFormatter(45),
          ],
          decoration: InputDecoration(
              labelText: 'Nome',
              icon: Icon(Icons.person),
              errorText: controller.formError.name.msg),
        );
      },
    );

    TextField inputNickName = TextField(
      keyboardType: TextInputType.text,
      inputFormatters: [
        LengthLimitingTextInputFormatter(25),
      ],
      decoration: InputDecoration(
        labelText: 'Apelido',
        icon: Icon(Icons.person),
      ),
    );

    TextField inputWork = TextField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(45),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Trabalho',
        icon: Icon(Icons.work),
      ),
    );

    TextField inputPhoneNumber = TextField(
      controller: controller.maskFormatter,
      keyboardType: TextInputType.phone,
      onChanged: (v) => controller.phone = v,
      decoration: InputDecoration(
          labelText: "Telefone",
          icon: Icon(Icons.phone),
          errorText: controller.formError.phone.msg),
    );

    TextField inputEmail = TextField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'E-mail',
        icon: Icon(Icons.email),
      ),
    );

    TextField inputWebSite = TextField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Site da Web',
        icon: Icon(Icons.web),
      ),
    );

    final picture = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 120.0,
          height: 120.0,
          child: CircleAvatar(
            child: Icon(
              Icons.camera_alt,
            ),
          ),
        ),
      ],
    );

    ListView content = ListView(
      padding: EdgeInsets.all(20),
      children: <Widget>[
        SizedBox(height: 20),
        picture,
        Column(
          children: <Widget>[
            inputName,
            inputNickName,
            inputWork,
            inputPhoneNumber,
            inputEmail,
            inputWebSite,
          ],
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Modular.to.pop(),
        ),
        title: Text("Criar novo contato"),
        actions: <Widget>[
          Container(
            width: 80,
            child: IconButton(
                icon: Text(
                  'SALVAR',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed:
                    !controller.canSaveContact ? null : controller.saveContact),
          )
        ],
      ),
      body: content,
    );
  }
}
