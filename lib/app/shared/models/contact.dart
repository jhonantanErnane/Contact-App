import 'package:contact_app/app/shared/models/contact_model.dart';

class Contact {
  int id;
  String name;
  String nickName;
  String work;
  bool isFavorite;
  String photo;
  String phoneNumber;
  String email;
  String webSite;
  String created;

  Contact({
    this.id,
    this.name,
    this.nickName,
    this.work,
    this.isFavorite,
    this.photo,
    this.phoneNumber,
    this.email,
    this.webSite,
    this.created,
  });

  Contact.fromContactModel(ContactModel c) {
    this.id = c.id;
    this.name = c.name;
    this.nickName = c.nickName;
    this.work = c.work;
    this.isFavorite = c.isFavorite;
    this.photo = c.photo;
    this.phoneNumber = c.phoneNumber;
    this.email = c.email;
    this.webSite = c.webSite;
    this.created = c.created;
  }

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nickName = json['nickName'];
    work = json['work'];
    isFavorite = json['isFavorite'];
    photo = json['photo'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    webSite = json['webSite'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nickName'] = this.nickName;
    data['work'] = this.work;
    data['isFavorite'] = this.isFavorite;
    data['photo'] = this.photo;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['webSite'] = this.webSite;
    data['created'] = this.created;
    return data;
  }
}