// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_HomeControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$getContactsAsyncAction =
      AsyncAction('_HomeControllerBase.getContacts');

  @override
  Future<void> getContacts() {
    return _$getContactsAsyncAction.run(() => super.getContacts());
  }

  final _$delContactAsyncAction = AsyncAction('_HomeControllerBase.delContact');

  @override
  Future<void> delContact(int id) {
    return _$delContactAsyncAction.run(() => super.delContact(id));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
