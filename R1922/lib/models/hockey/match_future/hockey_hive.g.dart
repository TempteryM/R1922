// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hockey_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HockeyHiveAdapter extends TypeAdapter<HockeyHive> {
  @override
  final int typeId = 10;

  @override
  HockeyHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HockeyHive(
      id: fields[0] as int?,
      date: fields[1] as String?,
      time: fields[2] as String?,
      day: fields[12] as String?,
      timestamp: fields[3] as int?,
      timezone: fields[4] as String?,
      status: fields[5] as StatusH?,
      country: fields[6] as CountryH?,
      league: fields[7] as LeagueH?,
      teams: fields[8] as TeamsH?,
      scores: fields[9] as ScoresH?,
      periods: fields[10] as PeriodsH?,
      events: fields[11] as bool?,
      outputTimeFormat: fields[13] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, HockeyHive obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.timestamp)
      ..writeByte(4)
      ..write(obj.timezone)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.country)
      ..writeByte(7)
      ..write(obj.league)
      ..writeByte(8)
      ..write(obj.teams)
      ..writeByte(9)
      ..write(obj.scores)
      ..writeByte(10)
      ..write(obj.periods)
      ..writeByte(11)
      ..write(obj.events)
      ..writeByte(12)
      ..write(obj.day)
      ..writeByte(13)
      ..write(obj.outputTimeFormat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HockeyHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StatusHAdapter extends TypeAdapter<StatusH> {
  @override
  final int typeId = 11;

  @override
  StatusH read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StatusH(
      long: fields[0] as String?,
      short: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StatusH obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.long)
      ..writeByte(1)
      ..write(obj.short);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusHAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CountryHAdapter extends TypeAdapter<CountryH> {
  @override
  final int typeId = 12;

  @override
  CountryH read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountryH(
      id: fields[0] as int?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CountryH obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryHAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LeagueHAdapter extends TypeAdapter<LeagueH> {
  @override
  final int typeId = 13;

  @override
  LeagueH read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LeagueH(
      id: fields[0] as int?,
      name: fields[1] as String?,
      type: fields[2] as String?,
      logo: fields[3] as String?,
      season: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, LeagueH obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.logo)
      ..writeByte(4)
      ..write(obj.season);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeagueHAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TeamsHAdapter extends TypeAdapter<TeamsH> {
  @override
  final int typeId = 14;

  @override
  TeamsH read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeamsH(
      home: fields[0] as HomeH?,
      away: fields[1] as HomeH?,
    );
  }

  @override
  void write(BinaryWriter writer, TeamsH obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.home)
      ..writeByte(1)
      ..write(obj.away);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamsHAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HomeHAdapter extends TypeAdapter<HomeH> {
  @override
  final int typeId = 15;

  @override
  HomeH read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeH(
      id: fields[0] as int?,
      name: fields[1] as String?,
      logo: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HomeH obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.logo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeHAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ScoresHAdapter extends TypeAdapter<ScoresH> {
  @override
  final int typeId = 16;

  @override
  ScoresH read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScoresH(
      home: fields[0] as String?,
      away: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ScoresH obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.home)
      ..writeByte(1)
      ..write(obj.away);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScoresHAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PeriodsHAdapter extends TypeAdapter<PeriodsH> {
  @override
  final int typeId = 17;

  @override
  PeriodsH read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PeriodsH(
      first: fields[0] as String?,
      second: fields[1] as String?,
      third: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PeriodsH obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.first)
      ..writeByte(1)
      ..write(obj.second)
      ..writeByte(2)
      ..write(obj.third);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeriodsHAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
