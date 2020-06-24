// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_contact_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ViewContactController on _ViewContactControllerBase, Store {
  final _$existWhatsappAtom =
      Atom(name: '_ViewContactControllerBase.existWhatsapp');

  @override
  bool get existWhatsapp {
    _$existWhatsappAtom.reportRead();
    return super.existWhatsapp;
  }

  @override
  set existWhatsapp(bool value) {
    _$existWhatsappAtom.reportWrite(value, super.existWhatsapp, () {
      super.existWhatsapp = value;
    });
  }

  final _$contactAtom = Atom(name: '_ViewContactControllerBase.contact');

  @override
  ContactModel get contact {
    _$contactAtom.reportRead();
    return super.contact;
  }

  @override
  set contact(ContactModel value) {
    _$contactAtom.reportWrite(value, super.contact, () {
      super.contact = value;
    });
  }

  @override
  String toString() {
    return '''
existWhatsapp: ${existWhatsapp},
contact: ${contact}
    ''';
  }
}
