import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/navbar_provider.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});
  static const routeName = '/navbar';

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  @override
  void initState() {
    super.initState();
    // Здесь не инициализируем ScreenUtil
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Инициализация ScreenUtil здесь
    ScreenUtil.init(context, designSize: const Size(360, 690));
  }

  void onItemTapped(int index) {
    setState(() {
      Provider.of<NavbarProvider>(context, listen: false).selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mp = Provider.of<NavbarProvider>(context);

    return Scaffold(
      body: mp.items[mp.selectedIndex].widget,
      bottomNavigationBar: Container(
        constraints: BoxConstraints(
          maxHeight: 50.w,
          maxWidth: 50.w,
          minHeight: 20.w,
          minWidth: 20.w,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          gradient: LinearGradient(
            tileMode: TileMode.clamp,
            colors: [
              Theme.of(context).colorScheme.onBackground,
              Theme.of(context).colorScheme.onBackground,
              Theme.of(context).colorScheme.surface,
            ],
            stops: [0.03.h, 0.5.h, 0.5.h],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              blurRadius: 5,
            ),
          ],
        ),
        child: BottomNavigationBar(
          unselectedItemColor: const Color(0xFFD6D6D6),
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          fixedColor: Theme.of(context).colorScheme.primary,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          iconSize: 10.sp,
          elevation: 3,
          currentIndex: mp.selectedIndex,
          onTap: onItemTapped,
          items: mp.items
              .map((e) => BottomNavigationBarItem(
                    icon: Icon(
                      e.iconData,
                      size: 20.sp,
                    ),
                    label: e.label,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
