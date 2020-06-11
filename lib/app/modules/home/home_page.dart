import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/widgets/contact_list/contact_list_widget.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
  Color color = Colors.indigo;
  Widget appBarTitle = new Text("Contatos");
  Icon actionIcon = new Icon(Icons.search);
  bool searching = false;
  final _cSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          // child: StreamBuilder(
          //   builder: (conext, snapshot) {
          //     if (snapshot.hasError) {
          //       print(snapshot.error);
          //       return Text('Error: ${snapshot.error}');
          //     } else {
          //       if (!snapshot.hasData) {
          //         return Center(child: CircularProgressIndicator());
          //       }

          //       if (snapshot.data) {
          //   return AppBar(
          //     title: appBarTitle,
          //     backgroundColor: color,
          //     actions: <Widget>[
          //       IconButton(
          //         icon: actionIcon,
          //         onPressed: () {
          //           setState(() {
          //             if (this.actionIcon.icon == Icons.search) {
          //               this.actionIcon = new Icon(
          //                 Icons.close,
          //                 color: Colors.indigo,
          //               );
          //               this.color = Colors.white;
          //               this.appBarTitle = new TextField(
          //                 controller: _cSearch,
          //                 style: new TextStyle(
          //                   color: Colors.indigo,
          //                 ),
          //                 autofocus: true,
          //                 onChanged: (value) {
          //                   this.searching = true;
          //                 },
          //                 decoration: new InputDecoration(
          //                     prefixIcon: new Icon(Icons.search,
          //                         color: Colors.indigo),
          //                     hintText: "Pesquisar contatos",
          //                     hintStyle:
          //                         new TextStyle(color: Colors.indigo)),
          //               );
          //             } else {
          //               _cSearch.clear();
          //               this.searching = false;
          //               this.actionIcon = new Icon(
          //                 Icons.search,
          //               );
          //               this.color = Colors.indigo;
          //               this.appBarTitle = new Text("Contatos");
          //               // bloc.getListContact();
          //             }
          //           });
          //         },
          //       ),
          //     ],
          //   );
          // } else {
          child: AppBar(
            title: Text("Contatos"),
          )
          //       }
          //     }
          //   },
          // ),
          ),
      body: Observer(builder: (_) {
        return ContactListWidget(
          contacts: controller.contacts,
        );
      }),
      // StreamBuilder(
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return Center(child: CircularProgressIndicator());
      //     }

      //     if (snapshot.hasError) {
      //       print(snapshot.error);
      //       return Text('Error: ${snapshot.error}');
      //     } else {

      //       if (searching && snapshot.data.length == 0) {
      //         return Column(
      //           children: <Widget>[
      //             Center(
      //                 child: Padding(
      //               padding: const EdgeInsets.all(10),
      //               child: Text("Nenhum contato localizado"),
      //             )),
      //           ],
      //         );
      //       } else {
      //         return Container(); // ContactListWidget(items: snapshot.data);
      //       }
      //     }
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Modular.to.pushNamed('contacts/add');
        },
      ),
    );
  }
}
