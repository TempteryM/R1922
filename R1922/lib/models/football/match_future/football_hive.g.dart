// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'football_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FootabllHiveAdapter extends TypeAdapter<FootabllHive> {
  @override
  final int typeId = 0;

  @override
  FootabllHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FootabllHive(
      fixture: fields[0] as Fixture?,
      league: fields[1] as League?,
      teams: fields[2] as Teams?,
      goals: fields[3] as Goals?,
      score: fields[4] as Score?,
    );
  }

  @override
  void write(BinaryWriter writer, FootabllHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.fixture)
      ..writeByte(1)
      ..write(obj.league)
      ..writeByte(2)
      ..write(obj.teams)
      ..writeByte(3)
      ..write(obj.goals)
      ..writeByte(4)
      ..write(obj.score);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FootabllHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FixtureAdapter extends TypeAdapter<Fixture> {
  @override
  final int typeId = 1;

  @override
  Fixture read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Fixture(
      id: fields[0] as int?,
      referee: fields[1] as String?,
      timezone: fields[2] as String?,
      date: fields[3] as String?,
      time: fields[4] as String?,
      day: fields[5] as String?,
      timestamp: fields[6] as int?,
      periods: fields[7] as Periods?,
      venue: fields[8] as Venue?,
      status: fields[9] as Status?,
      outputTimeFormat: fields[10] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Fixture obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.referee)
      ..writeByte(2)
      ..write(obj.timezone)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.day)
      ..writeByte(6)
      ..write(obj.timestamp)
      ..writeByte(7)
      ..write(obj.periods)
      ..writeByte(8)
      ..write(obj.venue)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.outputTimeFormat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FixtureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PeriodsAdapter extends TypeAdapter<Periods> {
  @override
  final int typeId = 2;

  @override
  Periods read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Periods(
      first: fields[0] as String?,
      second: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Periods obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.first)
      ..writeByte(1)
      ..write(obj.second);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeriodsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VenueAdapter extends TypeAdapter<Venue> {
  @override
  final int typeId = 3;

  @override
  Venue read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Venue(
      id: fields[0] as int?,
      name: fields[1] as String?,
      city: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Venue obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.city);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VenueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StatusAdapter extends TypeAdapter<Status> {
  @override
  final int typeId = 4;

  @override
  Status read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Status(
      long: fields[0] as String?,
      short: fields[1] as String?,
      elapsed: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Status obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.long)
      ..writeByte(1)
      ..write(obj.short)
      ..writeByte(2)
      ..write(obj.elapsed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LeagueAdapter extends TypeAdapter<League> {
  @override
  final int typeId = 5;

  @override
  League read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return League(
      id: fields[0] as int?,
      name: fields[1] as String?,
      country: fields[2] as String?,
      logo: fields[3] as String?,
      flag: fields[4] as String?,
      season: fields[5] as int?,
      round: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, League obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.country)
      ..writeByte(3)
      ..write(obj.logo)
      ..writeByte(4)
      ..write(obj.flag)
      ..writeByte(5)
      ..write(obj.season)
      ..writeByte(6)
      ..write(obj.round);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeagueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TeamsAdapter extends TypeAdapter<Teams> {
  @override
  final int typeId = 6;

  @override
  Teams read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Teams(
      home: fields[0] as Home?,
      away: fields[1] as Home?,
    );
  }

  @override
  void write(BinaryWriter writer, Teams obj) {
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
      other is TeamsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HomeAdapter extends TypeAdapter<Home> {
  @override
  final int typeId = 7;

  @override
  Home read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Home(
      id: fields[0] as int?,
      name: fields[2] as String?,
      logo: fields[3] as String?,
      winner: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Home obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.logo)
      ..writeByte(4)
      ..write(obj.winner);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GoalsAdapter extends TypeAdapter<Goals> {
  @override
  final int typeId = 8;

  @override
  Goals read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Goals(
      home: fields[0] as String?,
      away: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Goals obj) {
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
      other is GoalsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ScoreAdapter extends TypeAdapter<Score> {
  @override
  final int typeId = 9;

  @override
  Score read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Score(
      halftime: fields[0] as Goals?,
      fulltime: fields[1] as Goals?,
      extratime: fields[2] as Goals?,
      penalty: fields[3] as Goals?,
    );
  }

  @override
  void write(BinaryWriter writer, Score obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.halftime)
      ..writeByte(1)
      ..write(obj.fulltime)
      ..writeByte(2)
      ..write(obj.extratime)
      ..writeByte(3)
      ..write(obj.penalty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
