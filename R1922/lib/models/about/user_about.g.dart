// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_about.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 18;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      userName: fields[0] as String,
      team: fields[1] as String,
      urlAvatar: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.team)
      ..writeByte(2)
      ..write(obj.urlAvatar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
