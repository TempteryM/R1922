import 'package:hive_flutter/hive_flutter.dart';

part 'user_about.g.dart';

@HiveType(typeId: 18)
class User {
  @HiveField(0)
  final String userName;
  @HiveField(1)
  final String team;
  @HiveField(2)
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
  Map<String, dynamic> toJson() {
    return {'userName': userName, 'team': team, 'urlAvatar': urlAvatar};
  }
}
