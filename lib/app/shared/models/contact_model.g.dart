// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactModelAdapter extends TypeAdapter<ContactModel> {
  @override
  final int typeId = 0;

  @override
  ContactModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
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
    )
      ..idServer = fields[9] as String
      ..wasSync = fields[10] as bool
      ..active = fields[11] as bool;
  }

  @override
  void write(BinaryWriter writer, ContactModel obj) {
    writer
      ..writeByte(11)
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
      ..write(obj.webSite)
      ..writeByte(9)
      ..write(obj.idServer)
      ..writeByte(10)
      ..write(obj.wasSync)
      ..writeByte(11)
      ..write(obj.active);
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
