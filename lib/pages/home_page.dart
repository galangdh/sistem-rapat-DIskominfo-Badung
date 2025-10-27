import 'package:flutter/material.dart';
// --- TAMBAHAN: Import halaman buat rapat baru ---
import './rapat_baru_page.dart';
// ---------------------------------------------

// --- Palet Warna Biru ---
const Color kPrimaryBlue = Color(0xFF1E3C72); // Biru tua untuk teks/header
const Color kLightBlueBg = Color(0xFFEAF2FF); // Biru muda untuk latar CTA
const Color kPageBg =
    Color(0xFFF7F9FC); // Biru sangat muda untuk latar scaffold
const Color kBorderColor = Color(0xFFDDE6F0); // Biru abu-abu muda untuk border
final Color kSubtitleColor = Colors.blueGrey.shade700; // Warna subjudul
const Color kLiveBadgeColor =
    Color.fromARGB(255, 255, 68, 68); // Merah untuk 'LIVE' (disesuaikan)
const Color kScheduleBadgeColor = Colors.lightBlue; // Biru untuk 'Schedule'
// -------------------------

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBg, // Latar belakang baru
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dashboard Admin',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryBlue, // Tetap
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Dinas Komunikasi & Informatika',
                          style: TextStyle(
                            fontSize: 14,
                            color: kSubtitleColor, // Warna baru
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: kSubtitleColor, // Warna baru
                      size: 28,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // --- PERUBAHAN: Bungkus dengan InkWell untuk navigasi ---
                InkWell(
                  onTap: () {
                    // Navigasi ke halaman Buat Rapat Baru
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateEditMeetingPage()),
                    );
                  },
                  borderRadius:
                      BorderRadius.circular(15), // Agar ripple sesuai bentuk
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: kLightBlueBg, // Latar biru muda
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // --- PERBAIKAN: Hapus 'const' dari Row ---
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                // Text ini bisa tetap const
                                '+ Buat Rapat Baru',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryBlue, // Teks biru tua
                                ),
                              ),
                              const SizedBox(
                                  height: 8), // SizedBox bisa tetap const
                              Text(
                                // Text ini tidak bisa const karena TextStyle-nya
                                'Mulai rapat dan undang\npeserta dari berbagai\norganisasi',
                                // --- PERBAIKAN: Hapus 'const' dari TextStyle ---
                                style: TextStyle(
                                  fontSize: 14,
                                  color: kSubtitleColor, // Penyebab error
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16), // SizedBox bisa tetap const
                        const Icon(
                          // Icon bisa tetap const
                          Icons.video_call_rounded, // Tambahan ikon
                          color: kPrimaryBlue,
                          size: 50,
                        )
                      ],
                    ),
                    // --- PERBAIKAN SELESAI ---
                  ),
                ),
                // --- PERUBAHAN SELESAI ---
                const SizedBox(height: 24), // Tambah spasi

                // --- Daftar Rapat (Refactored) ---

                // Card 1
                const _MeetingCard(
                  title: 'Rapat\nkoordinasi IT',
                  time: 'Hari ini, 14:00',
                  status: 'LIVE', // Status 'LIVE'
                ),
                const SizedBox(height: 16),

                // Card 2
                const _MeetingCard(
                  title: 'Rapat\nkoordinasi IT',
                  time: 'Hari ini, 14:00',
                  status: 'LIVE',
                ),
                const SizedBox(height: 16),

                // Card 3
                const _MeetingCard(
                  title: 'Rapat\nkoordinasi IT',
                  time: 'Hari ini, 14:00',
                  status: 'LIVE',
                ),
                const SizedBox(height: 16),

                // Card 4
                const _MeetingCard(
                  title: 'Rapat\nkoordinasi IT',
                  time: 'Hari ini, 14:00',
                  status: 'LIVE',
                ),
                const SizedBox(height: 16),

                // Review Sistem Card
                const _MeetingCard(
                  title: 'Review\nSistem',
                  time: 'Besok, 10:00', // Tambahkan waktu agar konsisten
                  status: 'Schedule', // Status 'Schedule'
                ),

                const SizedBox(
                    height: 100), // Extra space di bawah untuk navbar
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget private yang di-refactor untuk menampilkan kartu rapat
class _MeetingCard extends StatelessWidget {
  final String title;
  final String? time;
  final String? status; // Bisa 'LIVE', 'Schedule', atau null

  const _MeetingCard({
    Key? key,
    required this.title,
    this.time,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? badge;

    // Logika untuk menentukan badge
    if (status == 'LIVE') {
      badge = _buildBadge('LIVE', kLiveBadgeColor);
    } else if (status == 'Schedule') {
      badge = _buildBadge('Schedule', kScheduleBadgeColor);
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, // Latar kartu tetap putih
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: kBorderColor, // Border biru muda
          width: 1.5,
        ),
        boxShadow: [
          // Efek shadow biru halus
          BoxShadow(
            color: Colors.blueGrey.shade50.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryBlue,
                    height: 1.3,
                  ),
                ),
                if (time != null) ...[
                  // Tampilkan waktu jika ada
                  const SizedBox(height: 8),
                  Text(
                    time!,
                    style: TextStyle(
                      fontSize: 13,
                      color: kSubtitleColor,
                    ),
                  ),
                ]
              ],
            ),
          ),
          if (badge != null) badge, // Tampilkan badge jika ada
        ],
      ),
    );
  }

  // Helper widget untuk membangun badge
  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text.toUpperCase(), // Teks badge uppercase
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
