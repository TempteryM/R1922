import 'package:com.gds.radio1922/widgets/custom_container_black.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchPast extends StatelessWidget {
  final String teamHome; // Название домашней команды
  final String teamAway; // Название гостевой команды
  final String homeLogo; // Логотип домашней команды
  final String awayLogo; // Логотип гостевой команды
  final String homeScore; // Счет домашней команды
  final String awayScore; // Счет гостевой команды
  final String matchDate; // Дата матча
  final String matchDateTime; // Время матча
  final String league; // Лига
  final String matchStatus; // "скоро", "идет", "закончен"

  const MatchPast({
    super.key,
    required this.teamHome,
    required this.teamAway,
    required this.homeLogo,
    required this.awayLogo,
    required this.homeScore,
    required this.awayScore,
    required this.matchDate,
    required this.matchDateTime,
    required this.league,
    required this.matchStatus,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainerBlack(
        child: Container(
      constraints: BoxConstraints(
        maxHeight: 75.h,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                crossAxisAlignment:
                    CrossAxisAlignment.start, // Изменено на center
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 9.h),
                    child: Row(
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
                  ),
                  Container(
                    height: 0.6.h,
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 9.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Разделитель
                  Container(
                    height: double.infinity,
                    width: 0.6.h,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  // Колонка со счетами
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.h),
                        child: Text(
                          homeScore,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ).tr(),
                      ),
                      // SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.h),
                        child: Text(
                          awayScore,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ).tr(),
                      ),
                    ],
                  ),
                  // Разделитель

                  // Колонка с информацией о матче
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: double.infinity,
                            width: 0.6.h,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .start, // Изменено на spaceEvenly
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  league,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ).tr(),
                                Text(
                                  matchDate.toString().toUpperCase(),
                                  style: Theme.of(context).textTheme.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      matchDateTime.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(width: 6.h),
                                    Text(
                                      matchStatus.toString().tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

  //  Padding(
  //                     padding: const EdgeInsets.symmetric(vertical: 8),
  //                     child: Container(
  //                       height: 0.5.h,
  //                       width: double.minPositive,
  //                       // Здесь устанавливаем ширину на максимум
  //                       color: Theme.of(context).colorScheme.primary,
  //                     ),
  //                   ),
  //  Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 // Разделитель
  //                 Container(
  //                   height: 60.h, // Задаем фиксированную высоту
  //                   width: 0.5.h,
  //                   color: Theme.of(context).colorScheme.primary,
  //                 ),
  //                 SizedBox(width: 8.h), // Отступ между разделителем и текстом
  //                 Column(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Text(
  //                       league ?? '', // Обработать возможный null
  //                       style: Theme.of(context).textTheme.titleMedium,
  //                       maxLines: 1,
  //                       overflow: TextOverflow.ellipsis,
  //                     ).tr(),
  //                     Text(
  //                       matchDate.toString().toUpperCase(),
  //                       style: Theme.of(context).textTheme.bodySmall,
  //                       maxLines: 1,
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                     Text(
  //                       matchDateTime.toString(),
  //                       style: Theme.of(context).textTheme.bodySmall,
  //                       maxLines: 1,
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),