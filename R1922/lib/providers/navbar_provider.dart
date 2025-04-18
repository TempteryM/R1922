import 'package:flutter/material.dart';
import '../page/match_page.dart';
import '../page/news_page.dart';
import '../page/player_screens.dart';

class NavbarProvider with ChangeNotifier {
  List<NavbarDTD> items = [
    NavbarDTD(
        label: 'Радио',
        iconData: Icons.radio_outlined,
        widget: const PlayerScreen()),
    NavbarDTD(
        label: 'Новости',
        iconData: Icons.newspaper_outlined,
        widget: const NewsViewScreen()),
    NavbarDTD(
        label: 'Матчи',
        iconData: Icons.stadium_outlined,
        widget: const MatchViewScreen()),
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
