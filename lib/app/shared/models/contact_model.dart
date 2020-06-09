import 'package:hive/hive.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 0)
class ContactModel {
  @HiveField(1)
  String name;
  @HiveField(2)
  String nickName;
  @HiveField(3)
  String work;
  @HiveField(4)
  bool isFavorite;
  @HiveField(5)
  String photo;
  @HiveField(6)
  String phoneNumber;
  @HiveField(7)
  String email;
  @HiveField(8)
  String webSite;
  @HiveField(9)
  String created;

  ContactModel({
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

  ContactModel.fromJson(Map<String, dynamic> json) {
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
