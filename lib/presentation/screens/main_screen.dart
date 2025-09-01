import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:municipality_app/presentation/screens/employees/employees_list_screen.dart';
import 'package:municipality_app/presentation/screens/home/home_screen.dart';
import 'package:municipality_app/presentation/screens/notice/notice_list_screen.dart';
import 'package:municipality_app/presentation/screens/notice/scrolling_news_list_screen.dart';
import 'package:municipality_app/presentation/screens/services/services_list_screen.dart';
import 'package:municipality_app/presentation/widgets/common/bottom_nav_bar.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    NoticeListScreen(),
    ScrollingNewsListScreen(),
    EmployeesListScreen(),
    ServicesListScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: _selectedIndex, onItemTapped:_onItemTapped)
    );
  }
}
