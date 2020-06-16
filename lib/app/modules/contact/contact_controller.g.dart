// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ContactController on _ContactControllerBase, Store {
  Computed<bool> _$canSaveContactComputed;

  @override
  bool get canSaveContact =>
      (_$canSaveContactComputed ??= Computed<bool>(() => super.canSaveContact,
              name: '_ContactControllerBase.canSaveContact'))
          .value;

  final _$formKeyAtom = Atom(name: '_ContactControllerBase.formKey');

  @override
  GlobalKey<FormState> get formKey {
    _$formKeyAtom.reportRead();
    return super.formKey;
  }

  @override
  set formKey(GlobalKey<FormState> value) {
    _$formKeyAtom.reportWrite(value, super.formKey, () {
      super.formKey = value;
    });
  }

  final _$photoAtom = Atom(name: '_ContactControllerBase.photo');

  @override
  dynamic get photo {
    _$photoAtom.reportRead();
    return super.photo;
  }

  @override
  set photo(dynamic value) {
    _$photoAtom.reportWrite(value, super.photo, () {
      super.photo = value;
    });
  }

  final _$_ContactControllerBaseActionController =
      ActionController(name: '_ContactControllerBase');

  @override
  void setContact(ContactModel c) {
    final _$actionInfo = _$_ContactControllerBaseActionController.startAction(
        name: '_ContactControllerBase.setContact');
    try {
      return super.setContact(c);
    } finally {
      _$_ContactControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String validateName(String name) {
    final _$actionInfo = _$_ContactControllerBaseActionController.startAction(
        name: '_ContactControllerBase.validateName');
    try {
      return super.validateName(name);
    } finally {
      _$_ContactControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String validatePhone(String phone) {
    final _$actionInfo = _$_ContactControllerBaseActionController.startAction(
        name: '_ContactControllerBase.validatePhone');
    try {
      return super.validatePhone(phone);
    } finally {
      _$_ContactControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
formKey: ${formKey},
photo: ${photo},
canSaveContact: ${canSaveContact}
    ''';
  }
}
