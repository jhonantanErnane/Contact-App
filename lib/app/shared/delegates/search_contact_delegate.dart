import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/widgets/contact_list/contact_list_widget.dart';
import '../../shared/models/contact_model.dart';
import '../../shared/repositories/repository_interface.dart';

class SearchContact extends SearchDelegate<ContactModel> {
  final _storage = Modular.get<ILocalRepository>();
  final Function(Map<dynamic, dynamic>) onNavigation;

  SearchContact({@required this.onNavigation});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder<List<ContactModel>>(
        future: _storage.getAllContacts(query),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ContactListWidget(
            contacts: snapshot.data,
            onNavigation: onNavigation,
          );
        },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder<List<String>>(
        future: suggestions(query),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List<String> contactList = snapshot.data;
          return ListView.builder(
            itemCount: contactList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(contactList.elementAt(index)),
                onTap: () {
                  query = contactList.elementAt(index);
                  showResults(context);
                },
              );
            },
          );
        },
      );
    }
  }

  Future<List<String>> suggestions(String search) async {
    return await _storage.searchAllContacts(search);
  }
}
