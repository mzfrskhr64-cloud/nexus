import 'package:flutter/material.dart';
import 'package:nexus/core/constants/app_colors.dart';

import '../../cubit/partner/partners_screen.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/balance_card.dart';
import '../archive/archive_screen.dart';

import '../settings/settings_screen.dart';
import 'home_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final List<Widget> screens = const [
    HomeContent(),
    PartnersScreen(),
    ArchiveScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: const Text('NEXUS'),


        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.settings_outlined,
            ),
            tooltip: 'الإعدادات',
          ),
        ],
      ),

       body: screens[currentIndex],
      bottomNavigationBar: NavigationBar(
        surfaceTintColor: Colors.black,

        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),

            label: 'الشركاء',
          ),
          NavigationDestination(
            icon: Icon(Icons.archive_outlined),
            selectedIcon: Icon(Icons.archive),
            label: 'الأرشيف',
          ),
        ],
        backgroundColor: AppColors.secondary,
      ),
    );
  }
}