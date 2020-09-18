// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_modal_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConfigModalController on _ConfigModalControllerBase, Store {
  final _$isSyncAutoAtom = Atom(name: '_ConfigModalControllerBase.isSyncAuto');

  @override
  bool get isSyncAuto {
    _$isSyncAutoAtom.reportRead();
    return super.isSyncAuto;
  }

  @override
  set isSyncAuto(bool value) {
    _$isSyncAutoAtom.reportWrite(value, super.isSyncAuto, () {
      super.isSyncAuto = value;
    });
  }

  final _$_getSyncAsyncAction =
      AsyncAction('_ConfigModalControllerBase._getSync');

  @override
  Future<void> _getSync() {
    return _$_getSyncAsyncAction.run(() => super._getSync());
  }

  final _$toggleSyncAsyncAction =
      AsyncAction('_ConfigModalControllerBase.toggleSync');

  @override
  Future<void> toggleSync(bool toggle) {
    return _$toggleSyncAsyncAction.run(() => super.toggleSync(toggle));
  }

  @override
  String toString() {
    return '''
isSyncAuto: ${isSyncAuto}
    ''';
  }
}
