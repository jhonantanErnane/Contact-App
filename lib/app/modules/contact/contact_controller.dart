import 'dart:convert';
import 'dart:io';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../shared/repositories/repository_interface.dart';
import '../../shared/models/contact_model.dart';
import '../../modules/contact/form_error.store.dart';
import '../../shared/models/field.dart';

part 'contact_controller.g.dart';

class ContactController = _ContactControllerBase with _$ContactController;

abstract class _ContactControllerBase with Store {
  final _storage = Modular.get<ILocalRepository>();
  
  @observable
  String name = '';
  
  @observable
  dynamic photo;

  @observable
  String phone = '';

  @computed
  bool get canSaveContact => !formError.hasErrors;

  final maskFormatter = new MaskedTextController(mask: '(00) 00000-0000');

  final AddEditFormErrorState formError = AddEditFormErrorState();

  List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => name, validateName),
      reaction((_) => phone, validatePhone),
      reaction((_) => photo, validatePhoto),
    ];
  }

  @action
  void validateName(String name) {
    bool _hasError = false;
    String _msg;
    if (name == null || name.isEmpty) {
      _msg = 'Nome não pode ser vazio';
      _hasError = true;
    } else {
      _msg = null;
      _hasError = false;
    }
    formError.name = GenericFormField(hasError: _hasError, msg: _msg);
  }

  @action
  void validatePhone(String phone) {
    // print(phone);
    bool _hasError = false;
    String _msg;
    if (maskFormatter.text.isEmpty) {
      _msg = 'Preencha o telefone';
      _hasError = true;
    } else if (phone == null || phone.isEmpty) {
      _msg = 'Telefone não pode ser vazio';
      _hasError = true;
    } else {
      _msg = null;
      _hasError = false;
    }
    formError.phone = GenericFormField(hasError: _hasError, msg: _msg);
  }

  @action
  void validatePhoto(dynamic photo) {
    bool _hasError = false;
    String _msg;
    if (photo == null) {
      _msg = 'Por favor escolha uma foto';
      _hasError = true;
    } else {
      _msg = null;
      _hasError = false;
    }
    formError.photo = GenericFormField(hasError: _hasError, msg: _msg);
  }

@action
  void saveContact() {
    try {
      String base64Image = '';
      if (photo is File) {
        List<int> imageBytes = photo.readAsBytesSync();
        // print(imageBytes);
        base64Image = base64Encode(imageBytes);
      } else {}
      final contact = ContactModel(
          name: name,
          phoneNumber: phone,
          photo: base64Image == '' ? photo : base64Image);
      photo = base64Decode(base64Image);
      _storage.addContact(contact);
      Modular.to.pop();
    } catch (e) {
      print('ocorreu um erro ao salvar o contato');
      print(e.toString());
    }
  }
  
  void dispose() {
    print('dispose');
    if (_disposers != null) {
      for (var item in _disposers) {
        item();
      }
    }
  }
}
