import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'hockey_hive.g.dart';

@HiveType(typeId: 10)
class HockeyHive {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? date;
  @HiveField(2)
  String? time;
  @HiveField(3)
  int? timestamp;
  @HiveField(4)
  String? timezone;
  @HiveField(5)
  StatusH? status;
  @HiveField(6)
  CountryH? country;
  @HiveField(7)
  LeagueH? league;
  @HiveField(8)
  TeamsH? teams;
  @HiveField(9)
  ScoresH? scores;
  @HiveField(10)
  PeriodsH? periods;
  @HiveField(11)
  bool? events;
  @HiveField(12)
  String? day;
  @HiveField(13)
  dynamic outputTimeFormat;

  HockeyHive(
      {this.id,
      this.date,
      this.time,
      this.day,
      this.timestamp,
      this.timezone,
      this.status,
      this.country,
      this.league,
      this.teams,
      this.scores,
      this.periods,
      this.events,
      this.outputTimeFormat});

  HockeyHive.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    date = json['date'];
    // Парсим дату из UTC
    var inputDate = DateTime.parse(date.toString());

    // Проверяем, если время в UTC равно 00:00
    if (inputDate.hour == 0 && inputDate.minute == 0) {
      time = '--:--'; // Если время в UTC 00:00, выводим '--:--'
    } else {
      // Конвертируем в локальное время
      var localDate = inputDate.toLocal();
      var outputTimeFormat = DateFormat('HH:mm');
      time = outputTimeFormat.format(localDate);
    }

    // Форматируем день
    var outputDayFormat = DateFormat('E | dd-MM-yyyy');
    day = outputDayFormat.format(inputDate.toLocal());

    time = json['time'];
    timestamp = json['timestamp'];
    timezone = json['timezone'];

    status =
        json['status'] != null ? new StatusH.fromJson(json['status']) : null;
    country =
        json['country'] != null ? new CountryH.fromJson(json['country']) : null;
    league =
        json['league'] != null ? new LeagueH.fromJson(json['league']) : null;
    teams = json['teams'] != null ? new TeamsH.fromJson(json['teams']) : null;
    scores =
        json['scores'] != null ? new ScoresH.fromJson(json['scores']) : null;
    periods =
        json['periods'] != null ? new PeriodsH.fromJson(json['periods']) : null;
    events = json['events'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;

    data['date'] = this.date;

    data['time'] = this.time;
    data['timestamp'] = this.timestamp;
    data['timezone'] = this.timezone;

    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.league != null) {
      data['league'] = this.league!.toJson();
    }
    if (this.teams != null) {
      data['teams'] = this.teams!.toJson();
    }
    if (this.scores != null) {
      data['scores'] = this.scores!.toJson();
    }
    if (this.periods != null) {
      data['periods'] = this.periods!.toJson();
    }
    data['events'] = this.events;
    return data;
  }
}

@HiveType(typeId: 11)
class StatusH {
  @HiveField(0)
  String? long;
  @HiveField(1)
  String? short;

  StatusH({this.long, this.short});

  StatusH.fromJson(Map<dynamic, dynamic> json) {
    long = json['long'];
    short = json['short'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['long'] = this.long;
    data['short'] = this.short;
    return data;
  }
}

@HiveType(typeId: 12)
class CountryH {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;

  CountryH({
    this.id,
    this.name,
  });

  CountryH.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    return data;
  }
}

@HiveType(typeId: 13)
class LeagueH {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? type;
  @HiveField(3)
  String? logo;
  @HiveField(4)
  int? season;

  LeagueH({this.id, this.name, this.type, this.logo, this.season});

  LeagueH.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    logo = json['logo'];
    season = json['season'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['logo'] = this.logo;
    data['season'] = this.season;
    return data;
  }
}

@HiveType(typeId: 14)
class TeamsH {
  @HiveField(0)
  HomeH? home;
  @HiveField(1)
  HomeH? away;

  TeamsH({this.home, this.away});

  TeamsH.fromJson(Map<dynamic, dynamic> json) {
    home = json['home'] != null ? new HomeH.fromJson(json['home']) : null;
    away = json['away'] != null ? new HomeH.fromJson(json['away']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    if (this.home != null) {
      data['home'] = this.home!.toJson();
    }
    if (this.away != null) {
      data['away'] = this.away!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 15)
class HomeH {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? logo;

  HomeH({this.id, this.name, this.logo});

  HomeH.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}

@HiveType(typeId: 16)
class ScoresH {
  @HiveField(0)
  String? home;
  @HiveField(1)
  String? away;

  ScoresH({this.home, this.away});

  ScoresH.fromJson(Map<dynamic, dynamic> json) {
    home = json['home'] == null ? '0' : home = json['home'].toString();
    away = json['away'] == null ? '0' : away = json['away'].toString();
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['home'] = this.home;
    data['away'] = this.away;
    return data;
  }
}

@HiveType(typeId: 17)
class PeriodsH {
  @HiveField(0)
  String? first;
  @HiveField(1)
  String? second;
  @HiveField(2)
  String? third;

  PeriodsH({
    this.first,
    this.second,
    this.third,
  });

  PeriodsH.fromJson(Map<dynamic, dynamic> json) {
    first = json['first'];
    second = json['second'];
    third = json['third'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['first'] = this.first;
    data['second'] = this.second;
    data['third'] = this.third;

    return data;
  }
}
