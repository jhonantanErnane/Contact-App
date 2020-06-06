// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ContactListController on _ContactListControllerBase, Store {
  final _$valueAtom = Atom(name: '_ContactListControllerBase.value');

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  final _$_ContactListControllerBaseActionController =
      ActionController(name: '_ContactListControllerBase');

  @override
  void increment() {
    final _$actionInfo = _$_ContactListControllerBaseActionController
        .startAction(name: '_ContactListControllerBase.increment');
    try {
      return super.increment();
    } finally {
      _$_ContactListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
