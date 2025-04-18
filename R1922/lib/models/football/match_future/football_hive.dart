import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'football_hive.g.dart'; // В этом файле будет сгенерированный код

@HiveType(typeId: 0)
class FootabllHive {
  @HiveField(0)
  Fixture? fixture;
  @HiveField(1)
  League? league;
  @HiveField(2)
  Teams? teams;
  @HiveField(3)
  Goals? goals;
  @HiveField(4)
  Score? score;

  FootabllHive({this.fixture, this.league, this.teams, this.goals, this.score});

  FootabllHive.fromJson(Map<dynamic, dynamic> json) {
    fixture =
        json['fixture'] != null ? new Fixture.fromJson(json['fixture']) : null;
    league =
        json['league'] != null ? new League.fromJson(json['league']) : null;
    teams = json['teams'] != null ? new Teams.fromJson(json['teams']) : null;
    goals = json['goals'] != null ? new Goals.fromJson(json['goals']) : null;
    score = json['score'] != null ? new Score.fromJson(json['score']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    if (this.fixture != null) {
      data['fixture'] = this.fixture!.toJson();
    }
    if (this.league != null) {
      data['league'] = this.league!.toJson();
    }
    if (this.teams != null) {
      data['teams'] = this.teams!.toJson();
    }
    if (this.goals != null) {
      data['goals'] = this.goals!.toJson();
    }
    if (this.score != null) {
      data['score'] = this.score!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 1)
class Fixture {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? referee;
  @HiveField(2)
  String? timezone;
  @HiveField(3)
  String? date;
  @HiveField(4)
  String? time;
  @HiveField(5)
  String? day;
  @HiveField(6)
  int? timestamp;
  @HiveField(7)
  Periods? periods;
  @HiveField(8)
  Venue? venue;
  @HiveField(9)
  Status? status;
  @HiveField(10)
  dynamic outputTimeFormat;

  Fixture(
      {this.id,
      this.referee,
      this.timezone,
      this.date,
      this.time,
      this.day,
      this.timestamp,
      this.periods,
      this.venue,
      this.status,
      this.outputTimeFormat});

  Fixture.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    referee = json['referee'];
    timezone = json['timezone'];
    periods =
        json['periods'] != null ? new Periods.fromJson(json['periods']) : null;
    venue = json['venue'] != null ? new Venue.fromJson(json['venue']) : null;
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    timestamp = json['timestamp'];
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
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['referee'] = this.referee;
    data['timezone'] = this.timezone;
    data['date'] = this.date;
    data['timestamp'] = this.timestamp;
    if (this.periods != null) {
      data['periods'] = this.periods!.toJson();
    }
    if (this.venue != null) {
      data['venue'] = this.venue!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 2)
class Periods {
  @HiveField(0)
  String? first;
  @HiveField(1)
  String? second;

  Periods({this.first, this.second});

  Periods.fromJson(Map<dynamic, dynamic> json) {
    first = json['first'].toString();
    second = json['second'].toString();
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['first'] = this.first;
    data['second'] = this.second;
    return data;
  }
}

@HiveType(typeId: 3)
class Venue {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? city;

  Venue({this.id, this.name, this.city});

  Venue.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'] == null ? 'Eще не определено' : name = json['name'];
    city = json['city'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['city'] = this.city;
    return data;
  }
}

@HiveType(typeId: 4)
class Status {
  @HiveField(0)
  String? long;
  @HiveField(1)
  String? short;
  @HiveField(2)
  String? elapsed;

  Status({this.long, this.short, this.elapsed});

  Status.fromJson(Map<dynamic, dynamic> json) {
    long = json['long'];
    short = json['short'];
    elapsed = json['elapsed'].toString();
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['long'] = this.long;
    data['short'] = this.short;
    data['elapsed'] = this.elapsed;
    return data;
  }
}

@HiveType(typeId: 5)
class League {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? country;
  @HiveField(3)
  String? logo;
  @HiveField(4)
  String? flag;
  @HiveField(5)
  int? season;
  @HiveField(6)
  String? round;

  League(
      {this.id,
      this.name,
      this.country,
      this.logo,
      this.flag,
      this.season,
      this.round});

  League.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    logo = json['logo'];
    flag = json['flag'];
    season = json['season'];
    round = json['round'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country'] = this.country;
    data['logo'] = this.logo;
    data['flag'] = this.flag;
    data['season'] = this.season;
    data['round'] = this.round;
    return data;
  }
}

@HiveType(typeId: 6)
class Teams {
  @HiveField(0)
  Home? home;
  @HiveField(1)
  Home? away;

  Teams({this.home, this.away});

  Teams.fromJson(Map<dynamic, dynamic> json) {
    home = json['home'] != null ? new Home.fromJson(json['home']) : null;
    away = json['away'] != null ? new Home.fromJson(json['away']) : null;
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

@HiveType(typeId: 7)
class Home {
  @HiveField(0)
  int? id;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? logo;
  @HiveField(4)
  String? winner;

  Home({this.id, this.name, this.logo, this.winner});

  Home.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    winner = json['winner'].toString();
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['winner'] = this.winner;
    return data;
  }
}

@HiveType(typeId: 8)
class Goals {
  @HiveField(0)
  String? home;
  @HiveField(1)
  String? away;

  Goals({this.home, this.away});

  Goals.fromJson(Map<dynamic, dynamic> json) {
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

@HiveType(typeId: 9)
class Score {
  @HiveField(0)
  Goals? halftime;
  @HiveField(1)
  Goals? fulltime;
  @HiveField(2)
  Goals? extratime;
  @HiveField(3)
  Goals? penalty;

  Score({this.halftime, this.fulltime, this.extratime, this.penalty});

  Score.fromJson(Map<dynamic, dynamic> json) {
    halftime =
        json['halftime'] != null ? new Goals.fromJson(json['halftime']) : null;
    fulltime =
        json['fulltime'] != null ? new Goals.fromJson(json['fulltime']) : null;
    extratime = json['extratime'] != null
        ? new Goals.fromJson(json['extratime'])
        : null;
    penalty =
        json['penalty'] != null ? new Goals.fromJson(json['penalty']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    if (this.halftime != null) {
      data['halftime'] = this.halftime!.toJson();
    }
    if (this.fulltime != null) {
      data['fulltime'] = this.fulltime!.toJson();
    }
    if (this.extratime != null) {
      data['extratime'] = this.extratime!.toJson();
    }
    if (this.penalty != null) {
      data['penalty'] = this.penalty!.toJson();
    }
    return data;
  }
}
