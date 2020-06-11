import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/widgets/image_source_sheet/image_source_sheet_widget.dart';
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
    final List<Widget> components = List<Widget>();

    // name field
    components.add(Observer(
      builder: (_) {
        return TextField(
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
    ));

    // nickName field
    components.add(Observer(
      builder: (_) {
        return TextField(
          keyboardType: TextInputType.text,
          inputFormatters: [
            LengthLimitingTextInputFormatter(25),
          ],
          decoration: InputDecoration(
            labelText: 'Apelido',
            icon: Icon(Icons.person),
          ),
        );
      },
    ));

    // work field
    components.add(Observer(
      builder: (_) {
        return TextField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(45),
          ],
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Trabalho',
            icon: Icon(Icons.work),
          ),
        );
      },
    ));

    // phone field
    components.add(Observer(
      builder: (_) {
        return TextField(
          inputFormatters: [
            controller.maskFormatter,
          ],
          keyboardType: TextInputType.phone,
          onChanged: (v) => controller.phone = v,
          decoration: InputDecoration(
              labelText: "Telefone",
              icon: Icon(Icons.phone),
              errorText: controller.formError.phone.msg),
        );
      },
    ));

    // email field
    components.add(Observer(
      builder: (_) {
        return TextField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(50),
          ],
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'E-mail',
            icon: Icon(Icons.email),
          ),
        );
      },
    ));

    // website field
    components.add(Observer(
      builder: (_) {
        return TextField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(50),
          ],
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Site da Web',
            icon: Icon(Icons.web),
          ),
        );
      },
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
                            backgroundImage: controller.photo is Uint8List
                                ? MemoryImage(controller.photo)
                                : FileImage(controller.photo),
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

    return Scaffold(
      appBar: AppBar(
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
                  onPressed: !controller.canSaveContact
                      ? null
                      : controller.saveContact);
            },
          ),
        ],
      ),
      body: content,
    );
  }
}
