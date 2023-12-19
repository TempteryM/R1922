import 'dart:async';
import 'package:flutter/material.dart';
import 'package:radio1922/widgets/icon_social_card.dart';
import '../models/socialnetworks_models.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialNetworkUrl extends StatefulWidget {
  const SocialNetworkUrl({super.key});

  @override
  State<SocialNetworkUrl> createState() => _SocialNetworkUrlState();
}

class _SocialNetworkUrlState extends State<SocialNetworkUrl> {
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void>? launched;

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
                  launched = _launchInBrowser(toYoutube);
                },
                icon: Image.asset('assets/icons/youtube.png',
                    color: Theme.of(context).colorScheme.surfaceTint),
                splashColor: Theme.of(context).colorScheme.surface),
          ),
          IconSocialCard(
            iconCard: IconButton(
                onPressed: () async {
                  launched = _launchInBrowser(toVk);
                },
                icon: Image.asset('assets/icons/vk.png',
                    color: Theme.of(context).colorScheme.surfaceTint),
                splashColor: Theme.of(context).colorScheme.surface),
          ),
          IconSocialCard(
            iconCard: IconButton(
                onPressed: () async {
                  launched = _launchInBrowser(toTg);
                },
                icon: Image.asset('assets/icons/telegram.png',
                    color: Theme.of(context).colorScheme.surfaceTint),
                splashColor: Theme.of(context).colorScheme.surface),
          ),
          IconSocialCard(
            iconCard: IconButton(
                onPressed: () async {
                  launched = _launchInBrowser(toZen);
                },
                icon: Image.asset('assets/icons/zen.png',
                    color: Theme.of(context).colorScheme.surfaceTint),
                splashColor: Theme.of(context).colorScheme.surface),
          ),
          IconSocialCard(
            iconCard: IconButton(
                onPressed: () async {
                  launched = _launchInBrowser(toSite);
                },
                icon: Image.asset('assets/icons/site.png',
                    color: Theme.of(context).colorScheme.surfaceTint),
                splashColor: Theme.of(context).colorScheme.surface),
          ),
          // IconSocialCard(
          //   iconCard: IconButton(
          //       onPressed: () async {
          //         launched = _launchInBrowser(toSite);
          //       },
          //       icon: Icon(Icons.nightlight_outlined,
          //           color: Theme.of(context).colorScheme.surfaceTint),
          //       splashColor: Theme.of(context).colorScheme.surface),
          // ),
        ],
      ),
    );
  }
}
