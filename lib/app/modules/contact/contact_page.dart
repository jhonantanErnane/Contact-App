import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/widgets/image_source_sheet/image_source_sheet_widget.dart';
import 'contact_controller.dart';

class ContactPage extends StatefulWidget {
  final String title;
  const ContactPage({this.title = "Contact"});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends ModularState<ContactPage, ContactController> {
  //use 'controller' variable to access controller
  final TextEditingController _txNickName = TextEditingController();
  final TextEditingController _txWork = TextEditingController();
  final TextEditingController _txEmail = TextEditingController();
  final TextEditingController _txWebsite = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.setupValidations();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> components = List<Widget>();

    // name field
    components.add(TextFormField(
      controller: controller.controllertxName,
      keyboardType: TextInputType.text,
      inputFormatters: [
        LengthLimitingTextInputFormatter(45),
      ],
      validator: controller.validateName,
      decoration: InputDecoration(
        labelText: 'Nome',
        icon: Icon(Icons.person),
      ),
    ));

    // nickName field
    components.add(TextField(
      controller: _txNickName,
      keyboardType: TextInputType.text,
      inputFormatters: [
        LengthLimitingTextInputFormatter(25),
      ],
      decoration: InputDecoration(
        labelText: 'Apelido',
        icon: Icon(Icons.person),
      ),
    ));

    // work field
    components.add(TextField(
      controller: _txWork,
      inputFormatters: [
        LengthLimitingTextInputFormatter(45),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Trabalho',
        icon: Icon(Icons.work),
      ),
    ));

    // phone field
    components.add(TextFormField(
      controller: controller.controllertxPhone,
      inputFormatters: [
        controller.maskFormatter,
      ],
      keyboardType: TextInputType.phone,
      validator: controller.validatePhone,
      decoration: InputDecoration(
        labelText: "Telefone",
        icon: Icon(Icons.phone),
      ),
    ));

    // email field
    components.add(TextField(
      controller: _txEmail,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'E-mail',
        icon: Icon(Icons.email),
      ),
    ));

    // website field
    components.add(TextField(
      controller: _txWebsite,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Site da Web',
        icon: Icon(Icons.web),
      ),
    ));

    // picture field
    components.insert(
        0,
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (_) => ImageSourceSheetWidget(
                          onImageSelected: (image) {
                            if (image != null) {
                              controller.photo = image;
                            }
                            Modular.to.pop();
                          },
                        ));
              },
              child: Observer(builder: (BuildContext context) {
                return Container(
                    width: 100.0,
                    height: 100.0,
                    child: controller.photo != null
                        ? CircleAvatar(
                            backgroundImage: controller.photo is File
                                ? FileImage(controller.photo)
                                : MemoryImage(controller.photo is String
                                    ? base64Decode(controller.photo)
                                    : controller.photo),
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage('images/profile.png'),
                          ));
              }),
            ),
          ],
        ));

    ListView content = ListView(
      padding: EdgeInsets.all(20),
      children: <Widget>[
        Column(
          children: components,
        ),
      ],
    );

    Form form =
        Form(key: controller.formKey, autovalidate: true, child: content);

    return Scaffold(
        appBar: AppBar(
          key: controller.flatKey,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Modular.to.pop(),
          ),
          title: Text("Criar novo contato"),
          actions: <Widget>[
            Observer(
              builder: (_) {
                return FlatButton(
                    child: Text(
                      'SALVAR',
                    ),
                    disabledTextColor: Colors.white60,
                    textColor: Colors.white,
                    onPressed: () {
                      if (controller.canSaveContact) {
                        controller.saveContact();
                      }
                    });
              },
            ),
          ],
        ),
        body: form);
  }
}
