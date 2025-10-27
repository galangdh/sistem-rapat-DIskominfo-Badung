import 'package:flutter/material.dart';
// --- TAMBAHAN IMPORT ---
import 'package:intl/date_symbol_data_local.dart';
// -----------------------
import 'widgets/custom_bottom_navbar.dart';
import 'pages/home_page.dart';
import 'pages/kelola_page.dart';
import 'pages/login_page.dart'; // Import LoginPage
import 'pages/profile_page.dart'; // Import ProfileScreen (seharusnya profile_page.dart)

// --- PERUBAHAN: Jadikan main async ---
Future<void> main() async {
  // --- TAMBAHAN INISIALISASI ---
  WidgetsFlutterBinding.ensureInitialized(); // Pastikan binding siap
  await initializeDateFormatting('id_ID', null); // Inisialisasi locale
  // -----------------------------
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
      // --- PERBAIKAN: Jika login berhasil, arahkan ke MainScreen ---
      // Anda perlu logika autentikasi di sini. Untuk sementara,
      // kita anggap mulai dari MainScreen setelah setup locale.
      // Jika ingin mulai dari login, biarkan home: const LoginPage(),
      // tapi pastikan LoginPage mengarahkan ke MainScreen setelah login berhasil.
      home: const MainScreen(),
      // home: const LoginPage(), // Mulai dari LoginPage jika diinginkan
      // -----------------------------------------------------------
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
    const StatistikPage(), // Pastikan file StatistikPage ada
    const ProfileScreen(), // Pastikan file ProfileScreen ada
  ];

  @override
  Widget build(BuildContext context) {
    // --- PERBAIKAN: Pastikan CustomBottomNavBar diimpor dengan benar ---
    // Jika CustomBottomNavBar ada di 'widgets/custom_bottom_navbar.dart',
    // import di atas sudah benar.
    // -------------------------------------------------------------
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
// STATISTIK PAGE (Placeholder)
// ============================================================================
// Pastikan Anda membuat file terpisah untuk StatistikPage (misal: pages/statistik_page.dart)
// dan mengimpornya di atas jika diperlukan.
class StatistikPage extends StatelessWidget {
  const StatistikPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          AppBar(title: const Text('Statistik')), // Tambahkan AppBar sederhana
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- PERBAIKAN: Gunakan Center untuk konten placeholder ---
                Center(
                  child: Text(
                    'Halaman Statistik',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                // ---------------------------------------------------
                SizedBox(height: 100), // Extra space untuk navbar
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
// Sebaiknya ini juga dipindah ke file terpisah (misal: widgets/profile_info_field.dart)
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



// kalau mau coba akses punya pewagai pakai ini komen yang atas dan buka komen yang bawah

// ___________________________PEGAWAIII_____________________________
// import 'package:flutter/material.dart';
// import 'widgets/custom_bottom_navbar_pegawai.dart';

// void main() {
//   runApp(const PegawaiApp());
// }

// class PegawaiApp extends StatelessWidget {
//   const PegawaiApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CustomBottomNavbarPegawai(),
//     );
//   }
// }