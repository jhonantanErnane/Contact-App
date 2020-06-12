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
  final TextEditingController _txName = TextEditingController();
  final TextEditingController _txNickName = TextEditingController();
  final TextEditingController _txWork = TextEditingController();
  final TextEditingController _txPhone = TextEditingController();
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
    components.add(Observer(
      builder: (_) {
    // _txName.text = controller.name;
        return TextFormField(
          initialValue: controller.name,
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
        _txNickName.text = controller.nickName;
        return TextField(
          controller: _txNickName,
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
        _txWork.text = controller.work;
        return TextField(
          controller: _txWork,
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
        _txPhone.text = controller.phone;
        return TextField(
          controller: _txPhone,
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
        _txEmail.text = controller.email;
        return TextField(
          controller: _txEmail,
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
        _txWebsite.text = controller.website;
        return TextField(
          controller: _txWebsite,
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
                            backgroundImage: controller.photo is File
                                ? FileImage(controller.photo)
                                : MemoryImage(base64Decode(controller.photo)),
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
