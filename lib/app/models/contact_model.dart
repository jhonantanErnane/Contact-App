class ContactModel {
  final String name;
  final String nickName;
  final String work;
  final bool isFavorite;
  final String phoneNumber;
  final String email;
  final String webSite;
  final String created;

  ContactModel({
    this.name,
    this.nickName,
    this.work,
    this.isFavorite,
    this.phoneNumber,
    this.email,
    this.webSite,
    this.created,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
        //field: json[''],
        );
  }

  Map<String, dynamic> toJson() => {};
}
