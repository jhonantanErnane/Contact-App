// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_progress_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $SyncProgressController = BindInject(
  (i) => SyncProgressController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SyncProgressController on _SyncProgressControllerBase, Store {
  final _$messageAtom = Atom(name: '_SyncProgressControllerBase.message');

  @override
  String get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(String value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  final _$_SyncProgressControllerBaseActionController =
      ActionController(name: '_SyncProgressControllerBase');

  @override
  void startSyncManually() {
    final _$actionInfo = _$_SyncProgressControllerBaseActionController
        .startAction(name: '_SyncProgressControllerBase.startSyncManually');
    try {
      return super.startSyncManually();
    } finally {
      _$_SyncProgressControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
message: ${message}
    ''';
  }
}
