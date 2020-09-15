import 'package:flutter/material.dart';

class ConfigModalWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Configurações'),
            Row(
              children: <Widget>[
                Text('Sincronizar automaticamente: '),
                Switch(value: false, onChanged: null)
              ],
            )
          ],
        ),
      ),
    );
  }
}
