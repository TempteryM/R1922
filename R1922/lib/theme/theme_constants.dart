import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const colorPrimary = Color(0xFFE62A4D);
const colorAppBAr = Color(0xFFE62A4D);
//Ligth
const backgroundColorLight = Colors.white;
const backgroundColorLightAdd = Colors.white;
const socialColorlight = Color(0xFFE3183F);
const backgroundbuttonLight = Colors.white;
const metadataColorLigth = Colors.black;
const iconColorLight = Color(0xFFE3183F);
const iconColorLightAdd = Colors.white;

//Dark
const backgroundColorDark = Color(0xFF0D1116);
const backgroundColorDarkAdd = Color(0xFF0D1118);
const socialColorDark = Color(0xFF1A222C);
const backgroundbuttonDark = Color(0xFF1A222C);
const metadataColorDark = Color(0xFFEEEEEE);
const iconColorDark = Color(0xFFEEEEEE);
const iconColorDarkAdd = Color(0xFFEEEEEE);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
      secondary: colorPrimary,
      background: backgroundColorLight,
      onBackground: backgroundColorLightAdd,
      primary: colorPrimary,
      onPrimary: metadataColorLigth,
      surfaceTint: iconColorLight,
      surface: backgroundbuttonLight,
      onSurface: iconColorLightAdd),
  textTheme: TextTheme(
    labelLarge: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 18.sp,
        color: metadataColorLigth,
        fontWeight: FontWeight.w300),
    labelMedium: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 16.sp,
        color: metadataColorLigth,
        fontWeight: FontWeight.w100),
    labelSmall: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 14.sp,
        color: metadataColorLigth,
        fontWeight: FontWeight.w100),
    titleLarge: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 18.sp,
        color: iconColorLightAdd,
        fontWeight: FontWeight.w900),
    titleMedium: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 16.sp,
        color: metadataColorLigth,
        fontWeight: FontWeight.w200),
    titleSmall: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 14.sp,
        color: metadataColorLigth,
        fontWeight: FontWeight.w100),
    bodyLarge: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 16.sp,
        color: metadataColorLigth,
        fontWeight: FontWeight.w900),
    bodyMedium: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 12.sp,
        color: metadataColorLigth,
        fontWeight: FontWeight.w500),
    bodySmall: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 11.sp,
        color: metadataColorLigth,
        fontWeight: FontWeight.normal),
  ),
);

ThemeData darkTheme = ThemeData(
  textTheme: TextTheme(
    labelLarge: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 18.sp,
        color: metadataColorDark,
        fontWeight: FontWeight.w300),
    labelMedium: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 16.sp,
        color: metadataColorDark,
        fontWeight: FontWeight.w100),
    labelSmall: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 14.sp,
        color: metadataColorDark,
        fontWeight: FontWeight.w100),
    titleLarge: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 18.sp,
        color: metadataColorDark,
        fontWeight: FontWeight.w900),
    titleMedium: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 12.sp,
        color: colorPrimary,
        fontWeight: FontWeight.w200),
    titleSmall: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 14.sp,
        color: metadataColorDark,
        fontWeight: FontWeight.w100),
    bodyLarge: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 16.sp,
        color: metadataColorDark,
        fontWeight: FontWeight.w900),
    bodyMedium: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 14.sp,
        color: metadataColorDark,
        fontWeight: FontWeight.w500),
    bodySmall: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 12.sp,
        color: metadataColorDark,
        fontWeight: FontWeight.normal),
  ),
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
      secondary: colorAppBAr,
      background: backgroundColorDark,
      onBackground: backgroundColorDarkAdd,
      primary: colorPrimary,
      onPrimary: metadataColorDark,
      surfaceTint: iconColorDark,
      surface: backgroundbuttonDark,
      onSurface: iconColorDarkAdd),
);
