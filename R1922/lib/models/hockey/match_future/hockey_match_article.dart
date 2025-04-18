import 'package:intl/intl.dart';

class HockeyResponse {
  int? id;
  String? date;
  String? time;
  int? timestamp;
  String? timezone;
  Status? status;
  Country? country;
  League? league;
  Teams? teams;
  Scores? scores;
  Periods? periods;
  bool? events;
  String? day;
  dynamic outputTimeFormat;

  HockeyResponse(
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

  HockeyResponse.fromJson(Map<dynamic, dynamic> json) {
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

    timestamp = json['timestamp'];
    timezone = json['timezone'];

    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    league =
        json['league'] != null ? new League.fromJson(json['league']) : null;
    teams = json['teams'] != null ? new Teams.fromJson(json['teams']) : null;
    scores =
        json['scores'] != null ? new Scores.fromJson(json['scores']) : null;
    periods =
        json['periods'] != null ? new Periods.fromJson(json['periods']) : null;
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

class Status {
  String? long;
  String? short;

  Status({this.long, this.short});

  Status.fromJson(Map<dynamic, dynamic> json) {
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

class Country {
  int? id;
  String? name;

  Country({
    this.id,
    this.name,
  });

  Country.fromJson(Map<dynamic, dynamic> json) {
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

class League {
  int? id;
  String? name;
  String? type;
  String? logo;
  int? season;

  League({this.id, this.name, this.type, this.logo, this.season});

  League.fromJson(Map<dynamic, dynamic> json) {
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

class Teams {
  Home? home;
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

class Home {
  int? id;
  String? name;
  String? logo;

  Home({this.id, this.name, this.logo});

  Home.fromJson(Map<dynamic, dynamic> json) {
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

class Scores {
  String? home;
  String? away;

  Scores({this.home, this.away});

  Scores.fromJson(Map<dynamic, dynamic> json) {
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

class Periods {
  String? first;
  String? second;
  String? third;

  Periods({
    this.first,
    this.second,
    this.third,
  });

  Periods.fromJson(Map<dynamic, dynamic> json) {
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
