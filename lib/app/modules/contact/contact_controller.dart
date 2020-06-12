import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';

import '../../shared/repositories/repository_interface.dart';
import '../../shared/models/contact_model.dart';

part 'contact_controller.g.dart';

class ContactController = _ContactControllerBase with _$ContactController;

abstract class _ContactControllerBase with Store {
  final _storage = Modular.get<ILocalRepository>();

  @observable
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey flatKey = GlobalKey();

  final TextEditingController _txName = TextEditingController();
  final TextEditingController _txPhone = TextEditingController();
  ContactModel contact = ContactModel();

  @observable
  String nickName = '';

  @observable
  String work = '';

  @observable
  String email = '';

  @observable
  String website = '';

  @observable
  dynamic photo;

  @computed
  bool get canSaveContact => formKey?.currentState?.validate() ?? false;

  TextEditingController get controllertxName => _txName;
  TextEditingController get controllertxPhone => _txPhone;

  final maskFormatter = new MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  Future<void> setupValidations() async {
    if (Modular.args.params != null) {
      await _getContact();
    }
  }

  Future<void> _getContact() async {
    this.contact =
        await _storage.getContact(int.parse(Modular.args.params['id']));
    if (contact != null) setContact(contact);
  }

  @action
  void setContact(ContactModel c) {
    _txName.text = c.name;
    _txPhone.text = c.phoneNumber;
    maskFormatter.formatEditUpdate(
        TextEditingValue(), TextEditingValue(text: _txPhone.text));
    photo = c.photo;

    nickName = c.nickName;
    work = c.work;
    email = c.email;
    website = c.webSite;
  }

  @action
  String validateName(String name) {
    String _msg;
    if (name == null || name.isEmpty) {
      _msg = 'Nome não pode ser vazio';
    } else {
      _msg = null;
    }
    return _msg;
  }

  @action
  String validatePhone(String phone) {
    String _msg;

    if (!maskFormatter.isFill()) {
      _msg = 'Preencha o telefone';
    } else if (phone == null || phone.isEmpty) {
      _msg = 'Telefone não pode ser vazio';
    } else {
      _msg = null;
    }
    return _msg;
  }

  @action
  String validatePhoto(dynamic photo) {
    String _msg;
    if (photo == null) {
      _msg = 'Por favor escolha uma foto';
    } else {
      _msg = null;
    }
    return _msg;
  }

  Future<void> saveContact() async {
    try {
      String base64Image = '';
      if (photo is File) {
        List<int> imageBytes = photo.readAsBytesSync();
        base64Image = base64Encode(imageBytes);
      } else {}
      contact.name = _txName.text;
      contact.phoneNumber = maskFormatter.getMaskedText();
      contact.photo = base64Image == '' ? photo : base64Image;

      photo = base64Decode(base64Image);
      if (contact.id == null) {
        await _storage.addContact(contact);
      } else {
        await _storage.putContact(contact);
      }

      Modular.to.pop();
    } catch (e) {
      print('ocorreu um erro ao salvar o contato');
      print(e.toString());
    }
  }

}
