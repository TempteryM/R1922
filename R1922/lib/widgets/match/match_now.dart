import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchNow extends StatelessWidget {
  final String teamHome; // Название домашней команды
  final String teamAway; // Название гостевой команды
  final String homeLogo; // Логотип домашней команды
  final String awayLogo; // Логотип гостевой команды
  final String homeScore; // Счет домашней команды
  final String awayScore; // Счет гостевой команды
  final String matchDate; // Дата матча
  final String matchDateTime; // Время матча
  final String matchStatus; // "скоро", "идет", "закончен"
  final String league; // Лига
  final String venue; // Стадион

  const MatchNow(
      {super.key,
      required this.teamHome,
      required this.teamAway,
      required this.homeLogo,
      required this.awayLogo,
      required this.homeScore,
      required this.awayScore,
      required this.matchDate,
      required this.matchDateTime,
      required this.matchStatus,
      required this.league,
      required this.venue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Левая часть: домашняя команда
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      homeLogo,
                      width: 40.w,
                      height: 40.w,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 8),
                    Text(
                      teamHome,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).tr(),
                  ],
                ),
              ),

              // Центральная часть: счет, дата и статус
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      league,
                      style: Theme.of(context).textTheme.titleMedium,
                    ).tr(),
                    Text(matchDate.toUpperCase(),
                        style: Theme.of(context).textTheme.bodySmall),
                    Text(
                      matchDateTime.toUpperCase(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text('$homeScore : $awayScore',
                        style: Theme.of(context).textTheme.labelLarge),
                    Text(
                      matchStatus.tr(),
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w500,
                        color: matchStatus == "идет"
                            ? Colors.green
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),

              // Правая часть: гостевая команда
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      awayLogo,
                      width: 40.w,
                      height: 40.w,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 8),
                    Text(
                      teamAway,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).tr(),
                  ],
                ),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Container(
                height: 0.5.h,
                color: Theme.of(context).colorScheme.primary,
              )),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  venue,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ])
        ],
      ),
    );
  }
}
