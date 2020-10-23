import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'sync_progress_controller.dart';

class SyncProgressWidget extends StatefulWidget {
  final bool startSync;

  SyncProgressWidget({@required this.startSync});

  @override
  _SyncProgressWidgetState createState() => _SyncProgressWidgetState();
}

class _SyncProgressWidgetState
    extends ModularState<SyncProgressWidget, SyncProgressController> {
  @override
  void initState() {
    super.initState();
    controller.init(widget.startSync);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Observer(builder: (_) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sincronizando seus contatos... \n ${controller.message}',
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
