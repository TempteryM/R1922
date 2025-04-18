import 'package:com.gds.radio1922/widgets/custom_container_black.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchDate extends StatelessWidget {
  final String teamHome; // Название домашней команды
  final String teamAway; // Название гостевой команды
  final String homeLogo; // Логотип домашней команды
  final String awayLogo; // Логотип гостевой команды
  final String matchDate; // Дата матча
  final String matchDateTime; // Время матча
  final String league; // Лига

  const MatchDate({
    super.key,
    required this.teamHome,
    required this.teamAway,
    required this.homeLogo,
    required this.awayLogo,
    required this.matchDate,
    required this.matchDateTime,
    required this.league,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainerBlack(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 75.h,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: 6.h, top: 3.h, bottom: 3.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 25,
                            height: 25,
                            child: Image(
                              fit: BoxFit.contain,
                              image: NetworkImage(homeLogo),
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey,
                                  child: Icon(Icons.error, size: 10.sp),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.h),
                            child: Text(
                              teamHome,
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ).tr(),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.h),
                            child: Container(
                              height: 0.6.h,

                              width: double.infinity,
                              // Здесь устанавливаем ширину на максимум
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 25,
                            height: 25,
                            child: Image(
                              fit: BoxFit.contain,
                              image: NetworkImage(awayLogo),
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey,
                                  child: Icon(Icons.error, size: 10.sp),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.h),
                            child: Text(
                              teamAway,
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ).tr(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Разделитель
                    Container(
                      height: 50.w, // Задаем фиксированную высоту
                      width: 0.6.h,
                      color: Theme.of(context).colorScheme.primary,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            league, // Обработать возможный null
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ).tr(),
                          Text(
                            matchDate.toString().toUpperCase(),
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            matchDateTime.toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
