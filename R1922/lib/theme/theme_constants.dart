import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const colorPrimary = Color(0xFFE62A4D);
const colorAppBAr = Color(0xFFE62A4D);
//Ligth
const backgroundColorLight = Color(0xFFE4E4E4);
const backgroundColorLightAdd = Color(0xFFE4E4E4);
const socialColorlight = Color(0xFFE3183F);
const backgroundbuttonLight = Color(0xFFE4E4E4);
const metadataColorLigth = Colors.black;
const iconColorLight = Color(0xFFE3183F);
const iconColorLightAdd = Color(0xFFE4E4E4);

//Dark
const backgroundColorDark = Color(0xFF16191F);
const backgroundColorDarkAdd = Color(0xFF13161B);
const socialColorDark = Color(0xFF1A222C);
const backgroundbuttonDark = Color(0xFF1A222C);
const metadataColorDark = Color(0xFFE4E4E4);
const iconColorDark = Color(0xFFE4E4E4);
const iconColorDarkAdd = Color(0xFFE4E4E4);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
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
        fontWeight: FontWeight.w500),
    labelMedium: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 16.sp,
        color: metadataColorLigth,
        fontWeight: FontWeight.w500),
    labelSmall: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 14.sp,
        color: metadataColorLigth,
        fontWeight: FontWeight.w500),
    titleLarge: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 18.sp,
        color: iconColorLightAdd,
        fontWeight: FontWeight.w500),
    titleMedium: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 16.sp,
        color: metadataColorLigth,
        fontWeight: FontWeight.w500),
    titleSmall: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 14.sp,
        color: metadataColorLigth,
        fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 16.sp,
        color: metadataColorLigth,
        fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 12.sp,
        color: metadataColorLigth,
        fontWeight: FontWeight.w500),
    bodySmall: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 11.sp,
        color: metadataColorLigth,
        fontWeight: FontWeight.w400),
  ),
);

ThemeData darkTheme = ThemeData(
  textTheme: TextTheme(
    labelLarge: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 18.sp,
        color: metadataColorDark,
        fontWeight: FontWeight.w500),
    labelMedium: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 16.sp,
        color: metadataColorDark,
        fontWeight: FontWeight.w500),
    labelSmall: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 14.sp,
        color: metadataColorDark,
        fontWeight: FontWeight.w500),
    titleLarge: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 16.sp,
        color: colorPrimary,
        fontWeight: FontWeight.w500),
    titleMedium: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 12.sp,
        color: colorPrimary,
        fontWeight: FontWeight.w500),
    titleSmall: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 14.sp,
        color: metadataColorDark,
        fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 16.sp,
        color: metadataColorDark,
        fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 14.sp,
        color: metadataColorDark,
        fontWeight: FontWeight.w500),
    bodySmall: TextStyle(
        fontFamily: 'Oswald',
        fontSize: 12.sp,
        color: metadataColorDark,
        fontWeight: FontWeight.w500),
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
