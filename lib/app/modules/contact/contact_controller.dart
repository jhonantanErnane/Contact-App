import 'dart:convert';
import 'dart:io';
import 'package:contact_app/app/modules/contact/contact_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';

import '../../shared/repositories/repository_interface.dart';
import '../../shared/models/contact_model.dart';
import '../../modules/contact/form_error.store.dart';
import '../../shared/models/field.dart';

part 'contact_controller.g.dart';

class ContactController = _ContactControllerBase with _$ContactController;

abstract class _ContactControllerBase with Store {
  final _storage = Modular.get<ILocalRepository>();
  final AddEditFormErrorState formError = AddEditFormErrorState();

  @observable
  String name = '';

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

  @observable
  String phone = '';

  @computed
  bool get canSaveContact => !formError.hasErrors;

  final maskFormatter = new MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  List<ReactionDisposer> _disposers;

  void setupValidations() {
    if (Modular.args.params != null) {
      _getContact();
    }

    _disposers = [
      reaction((_) => name, validateName),
      reaction((_) => phone, validatePhone),
      reaction((_) => photo, validatePhoto),
    ];
  }

  @action
  Future<void> _getContact() async {
    ContactModel c =
        await _storage.getContact(int.parse(Modular.args.params['id']));
// setState(() {
      
//     });
// _disposers.add(
//   reaction((_) => photo, validatePhoto)
// );
    name = c.name;
    nickName = c.nickName;
    work = c.work;
    email = c.email;
    website = c.webSite;
    photo = c.photo;
    phone = c.phoneNumber;

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

    if (!maskFormatter.isFill()) {
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
          phoneNumber: maskFormatter.getUnmaskedText(),
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
