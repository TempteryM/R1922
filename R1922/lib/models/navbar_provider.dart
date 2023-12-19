import 'package:flutter/material.dart';
import 'package:radio1922/page/match_page.dart';
import 'package:radio1922/page/news_page.dart';
import 'package:radio1922/page/player_screens.dart';
import 'package:radio1922/page/podcast.dart';
import 'package:radio1922/page/services.dart';

class NavbarProvider with ChangeNotifier {
  List<NavbarDTD> items = [
    NavbarDTD(
        label: 'Радио',
        iconData: Icons.radio_outlined,
        widget: const PlayerScreen()),
    NavbarDTD(
        label: 'Подкасты',
        iconData: Icons.podcasts_outlined,
        widget: const PodcastViewScreen()),
    NavbarDTD(
        label: 'Новости',
        iconData: Icons.newspaper_outlined,
        widget: const NewsViewScreen()),
    NavbarDTD(
        label: 'Матчи',
        iconData: Icons.stadium_outlined,
        widget: const MatchViewScreen()),
    NavbarDTD(
        label: 'Прочее',
        iconData: Icons.auto_awesome_mosaic_outlined,
        widget: const ServicesScreen()),
  ];
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }
}

class NavbarDTD {
  Widget? widget;
  String? label;
  IconData? iconData;

  NavbarDTD({
    this.widget,
    this.iconData,
    this.label,
  });
}
