import 'package:flutter/material.dart';
import 'widgets/custom_bottom_navbar.dart';
import 'pages/home_page.dart';
import 'pages/kelola_page.dart';
import 'pages/login_page.dart'; // Import LoginPage
import 'pages/profile_page.dart'; // Import LoginPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SiRapat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E5BA8)),
        useMaterial3: true,
        // Anda bisa menambahkan font family jika ada
        // fontFamily: 'Poppins',
      ),
      home: const LoginPage(), // Mulai dari LoginPage
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Pastikan Anda sudah membuat semua halaman ini
  final List<Widget> _pages = [
    const HomePage(),
    const KelolaPage(),
    const StatistikPage(),
    const ProfileScreen(), // Halaman profil yang akan kita modifikasi
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Body extend di belakang navbar
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

// ============================================================================
// STATISTIK PAGE (Tetap sama)
// ============================================================================
class StatistikPage extends StatelessWidget {
  const StatistikPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Statistik',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 24),
                const Center(
                  child: Text(
                    'Halaman Statistik',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 100), // Extra space untuk navbar
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// ============================================================================
// WIDGET BANTUAN UNTUK PROFILE PAGE (INI YANG DITAMBAHKAN)
// ============================================================================
class ProfileInfoField extends StatelessWidget {
  final String label;
  final String value;
  final IconData iconData;

  const ProfileInfoField({
    super.key,
    required this.label,
    required this.value,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                iconData,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
