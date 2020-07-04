// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactModelAdapter extends TypeAdapter<ContactModel> {
  @override
  final typeId = 0;

  @override
  ContactModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactModel(
      name: fields[1] as String,
      nickName: fields[2] as String,
      work: fields[3] as String,
      isFavorite: fields[4] as bool,
      photo: fields[5] as String,
      phoneNumber: fields[6] as String,
      email: fields[7] as String,
      webSite: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ContactModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.nickName)
      ..writeByte(3)
      ..write(obj.work)
      ..writeByte(4)
      ..write(obj.isFavorite)
      ..writeByte(5)
      ..write(obj.photo)
      ..writeByte(6)
      ..write(obj.phoneNumber)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.webSite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
