import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'config_modal_controller.dart';

class ConfigModalWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<ConfigModalController>();

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
                Observer(builder: (_) {
                  return Switch(
                      value: controller.isSyncAuto ?? false,
                      onChanged: controller.toggleSync);
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}
