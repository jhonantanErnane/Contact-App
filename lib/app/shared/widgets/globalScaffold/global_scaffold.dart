import 'package:flutter/material.dart';

class GlobalScaffold {
  static final GlobalScaffold instance = GlobalScaffold();

  final scaffKey = GlobalKey<ScaffoldState>();

  void showSnackBar(SnackBar content) {
    scaffKey.currentState.showSnackBar(content);
  }
}