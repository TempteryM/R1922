class Match {
  final String leagues;
  final String teamOne;
  final String teamTwo;
  final String logoTeamOne;
  final String logoTeamTwo;
  final String dateDay;
  final String dateTime;

  const Match({
    required this.leagues,
    required this.teamOne,
    required this.teamTwo,
    required this.logoTeamOne,
    required this.logoTeamTwo,
    required this.dateDay,
    required this.dateTime,
  });

  static Match fromJson(json) => Match(
      leagues: json['leagues'],
      teamOne: json['teamOne'],
      teamTwo: json['teamTwo'],
      logoTeamOne: json['logoTeamOne'],
      logoTeamTwo: json['logoTeamTwo'],
      dateDay: json['dateDay'],
      dateTime: json['dateTime']);
}
