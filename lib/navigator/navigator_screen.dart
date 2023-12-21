import 'package:rambo/views/screen/cart/cart_screen.dart';

import 'package:rambo/views/screen/profile/profile_screen.dart';

import 'package:flutter/material.dart';

import '../theme.dart';
import '../views/screen/dashboard/dashboard_screen.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({Key? key}) : super(key: key);

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const CartScreen(),

    // const KeranjangScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    Widget _customButtomNav() {
      return BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: bg2Color,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(top: 10),
              child: Icon(
                Icons.home_filled,
                size: 24.0,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(top: 10),
              child: Icon(
                Icons.shopping_cart,
                size: 24.0,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(top: 10),
              child: Icon(
                Icons.person,
                size: 24.0,
              ),
            ),
            label: '',
          ),
        ],
        selectedItemColor: bg1Color, // Warna teks item yang dipilih
        unselectedItemColor:
            Colors.grey[800], // Warna teks item yang tidak dipilih
      );
    }

    return Scaffold(
      backgroundColor: bg1Color,
      body: _screens[_currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: _customButtomNav(),
      ),
    );
  }
}
