// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_drawer_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CustomDrawerController on _CustomDrawerBase, Store {
  final _$isloggedStreamAtom = Atom(name: '_CustomDrawerBase.isloggedStream');

  @override
  ObservableStream<bool> get isloggedStream {
    _$isloggedStreamAtom.reportRead();
    return super.isloggedStream;
  }

  @override
  set isloggedStream(ObservableStream<bool> value) {
    _$isloggedStreamAtom.reportWrite(value, super.isloggedStream, () {
      super.isloggedStream = value;
    });
  }

  @override
  String toString() {
    return '''
isloggedStream: ${isloggedStream}
    ''';
  }
}
