class User {
  final String userName;
  final String team;
  final String urlAvatar;

  const User({
    required this.userName,
    required this.team,
    required this.urlAvatar,
  });

  static User fromJson(json) => User(
        userName: json['userName'],
        team: json['team'],
        urlAvatar: json['urlAvatar'],
      );
}
