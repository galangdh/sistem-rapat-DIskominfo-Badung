import 'package:flutter/material.dart';
import '../pegawai/home_pegawai.dart';
import '../pegawai/scan_page.dart';
import '../pegawai/riwayat_page.dart';
import '../pegawai/profile_page.dart';

class CustomBottomNavbarPegawai extends StatefulWidget {
  const CustomBottomNavbarPegawai({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavbarPegawai> createState() =>
      _CustomBottomNavbarPegawaiState();
}

class _CustomBottomNavbarPegawaiState
    extends State<CustomBottomNavbarPegawai> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePegawaiPage(),
    ScanPage(),
    RiwayatPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // biar navbar bisa “floating”
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // warna di dalam border
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.grey.shade800,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: const Color(0xFF1E3C72),
              unselectedItemColor: Colors.grey.shade400,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 28),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.qr_code_scanner, size: 28),
                  label: 'Scan',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history, size: 28),
                  label: 'Riwayat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 28),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
