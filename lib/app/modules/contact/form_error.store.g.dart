// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_error.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddEditFormErrorState on _AddEditFormErrorState, Store {
  Computed<bool> _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_AddEditFormErrorState.hasErrors'))
          .value;

  final _$nameAtom = Atom(name: '_AddEditFormErrorState.name');

  @override
  GenericFormField get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(GenericFormField value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$phoneAtom = Atom(name: '_AddEditFormErrorState.phone');

  @override
  GenericFormField get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(GenericFormField value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  final _$photoAtom = Atom(name: '_AddEditFormErrorState.photo');

  @override
  GenericFormField get photo {
    _$photoAtom.reportRead();
    return super.photo;
  }

  @override
  set photo(GenericFormField value) {
    _$photoAtom.reportWrite(value, super.photo, () {
      super.photo = value;
    });
  }

  @override
  String toString() {
    return '''
name: ${name},
phone: ${phone},
photo: ${photo},
hasErrors: ${hasErrors}
    ''';
  }
}
