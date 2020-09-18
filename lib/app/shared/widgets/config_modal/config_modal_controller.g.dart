// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_modal_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConfigModalController on _ConfigModalControllerBase, Store {
  final _$isSyncAutoStreamAtom =
      Atom(name: '_ConfigModalControllerBase.isSyncAutoStream');

  @override
  ObservableStream<bool> get isSyncAutoStream {
    _$isSyncAutoStreamAtom.reportRead();
    return super.isSyncAutoStream;
  }

  @override
  set isSyncAutoStream(ObservableStream<bool> value) {
    _$isSyncAutoStreamAtom.reportWrite(value, super.isSyncAutoStream, () {
      super.isSyncAutoStream = value;
    });
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
isSyncAutoStream: ${isSyncAutoStream}
    ''';
  }
}
