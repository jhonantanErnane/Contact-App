import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/delegates/search_contact_delegate.dart';
import '../../shared/widgets/custom_loading/custom_loading_widget.dart';
import '../../shared/widgets/contact_list/contact_list_widget.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  Color color = Colors.indigo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: AppBar(
            title: Text("Contatos"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  await showSearch(
                      context: context,
                      delegate: SearchContact(
                        onNavigation: controller.onNavigation,
                        onDelete: controller.delContact,
                      ));
                },
              ),
            ],
          )),
      body: Observer(builder: (_) {
        return CustomLoadingWidget(
          isLoading: controller.isLoading,
          child: ContactListWidget(
            isLoading: controller.isLoading,
            contacts: controller.contacts,
            onNavigation: controller.onNavigation,
            onDelete: controller.delContact,
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final param = await Modular.to.pushNamed('contacts/add') as Map;
          controller.onNavigation(param);
          // await controller.delContacts();
        },
      ),
    );
  }
}
