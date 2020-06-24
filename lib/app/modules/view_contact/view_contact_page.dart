import 'package:contact_app/app/shared/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'view_contact_controller.dart';

class ViewContactPage extends StatefulWidget {
  final String title;
  const ViewContactPage({Key key, this.title = "ViewContact"})
      : super(key: key);

  @override
  _ViewContactPageState createState() => _ViewContactPageState();
}

class _ViewContactPageState
    extends ModularState<ViewContactPage, ViewContactController> {
  static String defaultMessage = "Não informado";

  @override
  Widget build(BuildContext context) {
    controller.getApps();
    ListView content(context, ContactModel contact) {
      return ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              buildHeader(context, contact.name ?? ''),
              buildInformation(
                  contact.phoneNumber ?? '', contact.email ?? '', contact.name),
            ],
          )
        ],
      );
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: AppBar(
            elevation: 0,
            actions: <Widget>[
              Observer(builder: (_) {
                if (controller.contact == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return IconButton(
                  color: Colors.white,
                  icon: controller.contact.isFavorite == 1
                      ? Icon(Icons.star)
                      : Icon(Icons.star_border),
                  onPressed: () {
                    // updateFavorite(contact);
                  },
                );
              }),
              IconButton(
                color: Colors.white,
                icon: Icon(Icons.edit),
                onPressed: () {
                  Modular.to
                      .pushNamed('/contacts/edit/${controller.contact.id}');
                },
              ),
              // IconButton(
              //   color: Colors.white,
              //   icon: Icon(Icons.more_vert),
              //   onPressed: () {},
              // ),
            ],
          )),
      body: Observer(builder: (_) {
        if (controller.contact == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return content(context, controller.contact);
      }),
    );
  }

  void whatsAppOpen(phoneNumber, message) async {
    await FlutterLaunch.launchWathsApp(phone: phoneNumber, message: message);
  }

  _textMe(String number) async {
    // Android
    String uri = "sms:$number";
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      String uri = "sms:$number";
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  _launchCaller(String number) async {
    String url = "tel:$number";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Container buildHeader(BuildContext context, String name) {
    return Container(
      decoration: BoxDecoration(color: Colors.indigo),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.40,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          SizedBox(height: 20),
          Icon(
            Icons.person,
            color: Colors.white,
            size: 160,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding buildInformation(phoneNumber, email, nome) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text(phoneNumber.toString().isNotEmpty
                  ? phoneNumber
                  : defaultMessage),
              subtitle: Text(
                "Telefone",
                style: TextStyle(color: Colors.black54),
              ),
              leading: IconButton(
                icon: Icon(Icons.phone, color: Colors.indigo),
                onPressed: () {
                  _launchCaller(phoneNumber);
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.message),
                onPressed: () {
                  _textMe(phoneNumber);
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(email.toString().isNotEmpty ? email : defaultMessage),
              subtitle: Text(
                "E-mail",
                style: TextStyle(color: Colors.black54),
              ),
              leading: IconButton(
                  icon: Icon(Icons.email, color: Colors.indigo),
                  onPressed: () {}),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                "Enviar contato",
              ),
              subtitle: Text(
                "Compartilhar",
                style: TextStyle(color: Colors.black54),
              ),
              leading: IconButton(
                  icon: Icon(Icons.share, color: Colors.indigo),
                  onPressed: () {
                    Share.share(' Nome: $nome Tel: $phoneNumber ');
                  }),
            ),
          ),
          Card(
            child: controller.existWhatsapp
                ? ListTile(
                    title: Text(
                      "Abrir no Whatsapp",
                    ),
                    subtitle: Text(
                      "Whatsapp",
                      style: TextStyle(color: Colors.black54),
                    ),
                    leading: IconButton(
                        icon: Icon(FontAwesomeIcons.whatsapp,
                            color: Colors.indigo),
                        onPressed: () {
                          whatsAppOpen(phoneNumber.toString(), "");
                        }),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
