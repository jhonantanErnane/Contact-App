// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawer_tile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DrawerTileController on _DrawerTileBase, Store {
  final _$valueAtom = Atom(name: '_DrawerTileBase.value');

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

  final _$_DrawerTileBaseActionController =
      ActionController(name: '_DrawerTileBase');

  @override
  void increment() {
    final _$actionInfo = _$_DrawerTileBaseActionController.startAction(
        name: '_DrawerTileBase.increment');
    try {
      return super.increment();
    } finally {
      _$_DrawerTileBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
