import 'dart:convert';
import 'package:contact_app/app/shared/widgets/contact_list/contact_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../models/contact.dart';

class ContactListWidget extends StatelessWidget {
  final Function(Map<dynamic, dynamic>) onNavigation;
  final Function(int id) onDelete;
  final bool isLoading;

  final List<Contact> contacts;

  ContactListWidget(
      {@required this.contacts,
      @required this.onNavigation,
      @required this.onDelete,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<ContactListController>();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    if (isLoading) {
      return Container();
    }

    if (contacts == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (contacts.length == 0) {
      return column(context);
    }

    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (BuildContext context, int index) {
        Contact contact = contacts[index];
        return GestureDetector(
          onTapDown: controller.onTapDown,
          onLongPress: () {
            showMenu(
              context: context,
              items: [
                PopupMenuItem(
                  child: FlatButton(
                    child: Text(
                      "Editar",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () async {
                      Modular.to.popUntil((route) => route.isFirst);
                      final param = await Modular.to
                          .pushNamed('/contacts/edit/${contact.id}');
                      onNavigation(param);
                    },
                  ),
                ),
                PopupMenuItem(
                  child: FlatButton(
                    child: Text(
                      "Excluir",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Modular.to.pop();
                      _showDialog(contact, context);
                    },
                  ),
                ),
              ],
              position: controller.getRelativeRect(overlay),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
              leading: CircleAvatar(
                  backgroundImage: contact.photo != null
                      ? MemoryImage(
                          base64Decode(contact?.photo),
                        )
                      : null,
                  child: contact.photo == null || contact.photo.isEmpty
                      ? Text(
                          contact.name.substring(0, 1).toUpperCase(),
                          style: TextStyle(fontSize: 26, color: Colors.white60),
                        )
                      : null),
              trailing: contact.isFavorite
                  ? Icon(Icons.star, color: Colors.indigo)
                  : Icon(Icons.star_border),
              title: Text(
                contact.name,
                style: TextStyle(fontSize: 17),
              ),
              subtitle: contact.phoneNumber.toString().isNotEmpty
                  ? Text(contact.phoneNumber)
                  : null,
              onTap: () async {
                await Modular.to.pushNamed('/view/${contact.id}');
                final param = {'loadContact': contact.id};
                onNavigation(param);
              },
            ),
          ),
        );
      },
    );
  }

  Column column(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Icon(
            Icons.list,
            size: 120,
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Text(
            'Sua lista de contatos está vazia',
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () => Modular.to.pushNamed('/contacts/add'),
          child: Text(
            "ADICIONAR CONTATO",
            style: TextStyle(
              color: Colors.indigo,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () => Modular.to.pushNamed('/about'),
          child: Text(
            "SOBRE",
            style: TextStyle(
              color: Colors.indigo,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _showDialog(Contact contact, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Deseja excluir o contato?"),
          content: Text(contact.name),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () {
                Modular.to.pop();
              },
            ),
            FlatButton(
              child: Text("Sim"),
              onPressed: () {
                Modular.to.pop();
                onDelete(contact.id);
              },
            ),
          ],
        );
      },
    );
  }
}
