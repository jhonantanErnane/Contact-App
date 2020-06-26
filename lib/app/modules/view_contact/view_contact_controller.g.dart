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

  final _$isFavoriteAtom = Atom(name: '_ViewContactControllerBase.isFavorite');

  @override
  bool get isFavorite {
    _$isFavoriteAtom.reportRead();
    return super.isFavorite;
  }

  @override
  set isFavorite(bool value) {
    _$isFavoriteAtom.reportWrite(value, super.isFavorite, () {
      super.isFavorite = value;
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

  final _$getContactAsyncAction =
      AsyncAction('_ViewContactControllerBase.getContact');

  @override
  Future<void> getContact() {
    return _$getContactAsyncAction.run(() => super.getContact());
  }

  final _$toggleFavoriteAsyncAction =
      AsyncAction('_ViewContactControllerBase.toggleFavorite');

  @override
  Future<void> toggleFavorite() {
    return _$toggleFavoriteAsyncAction.run(() => super.toggleFavorite());
  }

  @override
  String toString() {
    return '''
existWhatsapp: ${existWhatsapp},
isFavorite: ${isFavorite},
contact: ${contact}
    ''';
  }
}
