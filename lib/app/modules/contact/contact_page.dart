import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

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
      controller: controller.txName,
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
      controller: controller.txNickName,
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
      controller: controller.txWork,
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
      controller: controller.txPhone,
      inputFormatters: [
        controller.maskFormatter,
      ],
      keyboardType: TextInputType.phone,
      // validator: controller.validatePhone,
      decoration: InputDecoration(
        labelText: "Telefone",
        icon: Icon(Icons.phone),
      ),
    ));

    // email field
    components.add(TextField(
      controller: controller.txEmail,
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
      controller: controller.txWebsite,
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
            FlatButton(
                child: Text(
                  'SALVAR',
                ),
                disabledTextColor: Colors.white60,
                textColor: Colors.white,
                onPressed: () {
                  // if (controller.canSaveContact) {
                  //   controller.saveContact();
                  // }

                  // if (_fbKey.currentState.saveAndValidate()) {
                  // }
                  print(controller.fbKey.currentState.validate());
                    print(controller.fbKey.currentState.value);

                }),
          ],
        ),
        body: SingleChildScrollView(
          child: createForm(),
        ));
  }

  FormBuilder createForm() {
    return FormBuilder(
        key: controller.fbKey,
        child: Column(
          children: <Widget>[
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
                                backgroundImage:
                                    AssetImage('images/profile.png'),
                              ));
                  }),
                ),
              ],
            ),
            FormBuilderTextField(
              attribute: "name",
              decoration: InputDecoration(
                labelText: "Nome",
                icon: Icon(Icons.person),
              ),
              validators: [FormBuilderValidators.required()],
            ),
            FormBuilderTextField(
              attribute: "phone",
              keyboardType: TextInputType.phone,
              inputFormatters: [controller.maskFormatter],
              decoration: InputDecoration(
                labelText: "Telefone",
                icon: Icon(Icons.phone),
              ),
              validators: [controller.validatePhone],
            ),
          ],
        ));
  }

  Column testForm() {
    return Column(
      children: <Widget>[
        FormBuilder(
          // key: _fbKey,
          initialValue: {
            'date': DateTime.now(),
            'accept_terms': false,
          },
          autovalidate: true,
          child: Column(
            children: <Widget>[
              FormBuilderDateTimePicker(
                attribute: "date",
                inputType: InputType.date,
                format: DateFormat("yyyy-MM-dd"),
                decoration: InputDecoration(labelText: "Appointment Time"),
              ),
              FormBuilderSlider(
                attribute: "slider",
                validators: [FormBuilderValidators.min(6)],
                min: 0.0,
                max: 10.0,
                initialValue: 1.0,
                divisions: 20,
                decoration: InputDecoration(labelText: "Number of things"),
              ),
              FormBuilderCheckbox(
                attribute: 'accept_terms',
                label:
                    Text("I have read and agree to the terms and conditions"),
                validators: [
                  FormBuilderValidators.requiredTrue(
                    errorText:
                        "You must accept terms and conditions to continue",
                  ),
                ],
              ),
              FormBuilderDropdown(
                attribute: "gender",
                decoration: InputDecoration(labelText: "Gender"),
                // initialValue: 'Male',
                hint: Text('Select Gender'),
                validators: [FormBuilderValidators.required()],
                items: ['Male', 'Female', 'Other']
                    .map((gender) =>
                        DropdownMenuItem(value: gender, child: Text("$gender")))
                    .toList(),
              ),
              FormBuilderTextField(
                attribute: "age",
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Age"),
                validators: [
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.max(70),
                ],
              ),
              FormBuilderSegmentedControl(
                decoration: InputDecoration(labelText: "Movie Rating (Archer)"),
                attribute: "movie_rating",
                options: List.generate(5, (i) => i + 1)
                    .map((number) => FormBuilderFieldOption(value: number))
                    .toList(),
              ),
              FormBuilderSwitch(
                label: Text('I Accept the tems and conditions'),
                attribute: "accept_terms_switch",
                initialValue: true,
              ),
              FormBuilderTouchSpin(
                decoration: InputDecoration(labelText: "Stepper"),
                attribute: "stepper",
                initialValue: 10,
                step: 1,
              ),
              FormBuilderRate(
                decoration: InputDecoration(labelText: "Rate this form"),
                attribute: "rate",
                iconSize: 32.0,
                initialValue: (1.0).toDouble(),
                max: (5.0).toDouble(),
              ),
              FormBuilderCheckboxList(
                decoration:
                    InputDecoration(labelText: "The language of my people"),
                attribute: "languages",
                initialValue: ["Dart"],
                options: [
                  FormBuilderFieldOption(value: "Dart"),
                  FormBuilderFieldOption(value: "Kotlin"),
                  FormBuilderFieldOption(value: "Java"),
                  FormBuilderFieldOption(value: "Swift"),
                  FormBuilderFieldOption(value: "Objective-C"),
                ],
              ),
              FormBuilderChoiceChip(
                attribute: "favorite_ice_cream",
                options: [
                  FormBuilderFieldOption(
                      child: Text("Vanilla"), value: "vanilla"),
                  FormBuilderFieldOption(
                      child: Text("Chocolate"), value: "chocolate"),
                  FormBuilderFieldOption(
                      child: Text("Strawberry"), value: "strawberry"),
                  FormBuilderFieldOption(child: Text("Peach"), value: "peach"),
                ],
              ),
              FormBuilderFilterChip(
                attribute: "pets",
                options: [
                  FormBuilderFieldOption(child: Text("Cats"), value: "cats"),
                  FormBuilderFieldOption(child: Text("Dogs"), value: "dogs"),
                  FormBuilderFieldOption(
                      child: Text("Rodents"), value: "rodents"),
                  FormBuilderFieldOption(child: Text("Birds"), value: "birds"),
                ],
              ),
              FormBuilderSignaturePad(
                decoration: InputDecoration(labelText: "Signature"),
                attribute: "signature",
                height: 100,
              ),
            ],
          ),
        ),
        // Row(
        //   children: <Widget>[
        //     MaterialButton(
        //       child: Text("Submit"),
        //       onPressed: () {
        //         if (_fbKey.currentState.saveAndValidate()) {
        //           print(_fbKey.currentState.value);
        //         }
        //       },
        //     ),
        //     MaterialButton(
        //       child: Text("Reset"),
        //       onPressed: () {
        //         _fbKey.currentState.reset();
        //       },
        //     ),
        //   ],
        // )
      ],
    );
  }
}
