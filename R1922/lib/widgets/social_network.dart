import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/icon_social_card.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialNetworkUrl extends StatefulWidget {
  const SocialNetworkUrl({super.key});

  @override
  State<SocialNetworkUrl> createState() => _SocialNetworkUrlState();
}

class _SocialNetworkUrlState extends State<SocialNetworkUrl> {
  Future<void> _launchInAppOrBrowser(Uri url, {String? appScheme}) async {
    // Попробуем сначала открыть в указанном приложении (если есть)
    if (appScheme != null && await canLaunch(appScheme)) {
      try {
        await launchUrl(Uri.parse(appScheme),
            mode: LaunchMode.inAppBrowserView);
        return; // Если приложение открылось, выходим из функции
      } catch (e) {
        // Если есть ошибка при открытии, продолжаем ниже
      }
    }

    // Пытаемся открыть URL в браузере
    await _launchInBrowser(url);
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconSocialCard(
            iconCard: IconButton(
                onPressed: () async {
                  Uri toYoutube = Uri.parse(
                      'https://www.youtube.com/channel/UCo6q0vPPUNJauqzqzwrCiMw'); // замените 'example' на действительный ID
                  String youtubeScheme =
                      'vnd.youtube:channel/UCo6q0vPPUNJauqzqzwrCiMw'; // используйте нужный идентификатор
                  await _launchInAppOrBrowser(toYoutube,
                      appScheme: youtubeScheme);
                },
                icon: Image.asset('assets/icons/youtube.png',
                    color: Theme.of(context).colorScheme.surfaceTint),
                splashColor: Theme.of(context).colorScheme.surface),
          ),
          IconSocialCard(
            iconCard: IconButton(
                onPressed: () async {
                  Uri toVk = Uri.parse(
                      'https://vk.com/kbvolna'); // замените на нужный URL
                  String vkScheme = 'vk://vk.com/kbvolna';
                  await _launchInAppOrBrowser(toVk, appScheme: vkScheme);
                },
                icon: Image.asset('assets/icons/vk.png',
                    color: Theme.of(context).colorScheme.surfaceTint),
                splashColor: Theme.of(context).colorScheme.surface),
          ),
          IconSocialCard(
            iconCard: IconButton(
                onPressed: () async {
                  Uri toTg = Uri.parse(
                      'https://telegram.me/kbvolna'); // замените на нужный URL
                  String tgScheme =
                      'tg://msg?text=kbvolna'; // замените на нужный формат
                  await _launchInAppOrBrowser(toTg, appScheme: tgScheme);
                },
                icon: Image.asset('assets/icons/telegram.png',
                    color: Theme.of(context).colorScheme.surfaceTint),
                splashColor: Theme.of(context).colorScheme.surface),
          ),
          IconSocialCard(
            iconCard: IconButton(
                onPressed: () async {
                  Uri toZen = Uri.parse(
                      'https://zen.yandex.ru/kbvolna.com'); // замените на нужный URL
                  String zenScheme =
                      'yandexzen://kbvolna.com'; // замените на нужную схему
                  await _launchInAppOrBrowser(toZen, appScheme: zenScheme);
                },
                icon: Image.asset('assets/icons/zen.png',
                    color: Theme.of(context).colorScheme.surfaceTint),
                splashColor: Theme.of(context).colorScheme.surface),
          ),
          IconSocialCard(
            iconCard: IconButton(
                onPressed: () async {
                  Uri toSite = Uri.parse(
                      'https://kbvolna.com/'); // замените на нужный URL
                  await _launchInAppOrBrowser(
                      toSite); // здесь можно обойтись без схемы, если просто браузер
                },
                icon: Image.asset('assets/icons/site.png',
                    color: Theme.of(context).colorScheme.surfaceTint),
                splashColor: Theme.of(context).colorScheme.surface),
          ),
        ],
      ),
    );
  }
}
