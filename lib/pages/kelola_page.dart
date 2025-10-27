import 'package:flutter/material.dart';
// --- PERBAIKAN: Mengembalikan ke import relatif ---
import './detail_page.dart';
// ---------------------------------------------

// --- Palet Warna Sesuai Gambar ---
const Color kPrimaryBlue = Color(0xFF2962FF); // Biru header & tombol
const Color kCardBackground = Colors.white;
const Color kPageBackground = Color(0xFFF4F7FC); // Latar belakang halaman
const Color kInfoBackground = Color(0xFFF7F9FC); // Latar info di dalam card
const Color kSearchBorderColor = Color(0xFFE0E0E0);
const Color kTextColor = Color(0xFF333333);
const Color kSubTextColor = Color(0xFF666666);

const Color kBadgeRed = Color(0xFFF44336);
const Color kBadgeOrange = Color(0xFFFF9800);
const Color kBadgeGreen = Color(0xFF4CAF50);

const Color kButtonOrange = Color(0xFFF57C00);

// --- DEFINISI ENUM DAN CLASS DIHAPUS ---
// Definisi Enum MeetingStatus dan Class Meeting sekarang
// diambil dari file './detail_page.dart'
// untuk menghindari konflik tipe.

class KelolaPage extends StatefulWidget {
  const KelolaPage({Key? key}) : super(key: key);

  @override
  State<KelolaPage> createState() => _KelolaPageState();
}

class _KelolaPageState extends State<KelolaPage> {
  // Data dummy, ganti ini dengan data asli dari state management/API Anda
  final List<Meeting> meetings = [
    Meeting(
      title: 'Rapat Koordinasi',
      status: MeetingStatus.ongoing,
      date: '01-02-2025',
      time: '09.00 - 11.00',
      participants: 12,
    ),
    Meeting(
      title: 'Rapat Evaluasi',
      status: MeetingStatus.upcoming,
      date: '01-02-2025',
      time: '09.00 - 11.00',
      participants: 12,
    ),
    Meeting(
      title: 'Rapat Anggaran',
      status: MeetingStatus.completed,
      date: '01-02-2025',
      time: '09.00 - 11.00',
      participants: 12,
    ),
    Meeting(
      title: 'Review Proyek Website',
      status: MeetingStatus.upcoming,
      date: '02-02-2025',
      time: '13.00 - 15.00',
      participants: 8,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackground,
      appBar: _buildCustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSearchBar(),
              const SizedBox(height: 20),
              // Gunakan ListView.builder untuk data dinamis
              ListView.separated(
                physics:
                    const NeverScrollableScrollPhysics(), // Biar tidak double scroll
                shrinkWrap: true,
                itemCount: meetings.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return _MeetingCard(meeting: meetings[index]);
                },
              ),
              const SizedBox(height: 100), // Extra space untuk navbar
            ],
          ),
        ),
      ),
    );
  }

  // Header Biru Kustom
  AppBar _buildCustomAppBar() {
    return AppBar(
      backgroundColor: kPrimaryBlue,
      elevation: 0,
      automaticallyImplyLeading: false, // Hapus tombol back jika tidak perlu
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10), // Padding atas
          const Text(
            'Daftar Rapat',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 3,
            width: 100, // Lebar garis bawah
            color: Colors.white.withOpacity(0.5),
          ),
        ],
      ),
      toolbarHeight: 80, // Tinggi AppBar
    );
  }

  // Search Bar
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: kCardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cari rapat...',
          hintStyle: const TextStyle(color: kSubTextColor),
          prefixIcon: const Icon(Icons.search, color: kSubTextColor),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: kInfoBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.filter_list, color: kPrimaryBlue),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kSearchBorderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kSearchBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kPrimaryBlue),
          ),
        ),
      ),
    );
  }
}

// Widget Kartu Rapat yang sudah di-refactor
class _MeetingCard extends StatelessWidget {
  final Meeting meeting;

  const _MeetingCard({Key? key, required this.meeting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget badge;
    Widget actionButton;

    // Fungsi helper untuk navigasi agar tidak duplikat kode
    void navigateToDetail() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DetailPage(meeting: meeting), // Diubah dari DetailRapatPage
        ),
      );
    }

    // Tentukan badge dan tombol aksi berdasarkan status
    switch (meeting.status) {
      case MeetingStatus.ongoing:
        badge = _buildBadge('Sedang Berlangsung', kBadgeRed, Icons.sensors);
        actionButton = _buildActionButton(
          'Gabung Sekarang',
          kPrimaryBlue,
          Colors.white,
          navigateToDetail, // Aksi navigasi
        );
        break;
      case MeetingStatus.upcoming:
        badge = _buildBadge('Mendatang', kBadgeOrange, Icons.timelapse);
        actionButton = _buildActionButton(
          'Lihat Detail',
          kButtonOrange,
          Colors.white,
          navigateToDetail, // Aksi navigasi
        );
        break;
      case MeetingStatus.completed:
        badge = _buildBadge('Selesai', kBadgeGreen, Icons.check_circle);
        actionButton = _buildActionButton(
          'Lihat Detail',
          kButtonOrange, // Tetap orange sesuai gambar
          Colors.white,
          navigateToDetail, // Aksi navigasi
        );
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: kCardBackground,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Baris Judul dan Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  // Ditambahkan Flexible di sini untuk judul yang panjang
                  child: Text(
                    meeting.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                ),
                const SizedBox(
                    width: 8), // Memberi jarak antara judul dan badge
                badge,
              ],
            ),
            const SizedBox(height: 16),
            // Blok Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kInfoBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _buildInfoRow(
                      Icons.calendar_today, meeting.date, meeting.time),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.people_outline,
                      '${meeting.participants} Peserta', null),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Tombol Aksi
            actionButton,
          ],
        ),
      ),
    );
  }

  // Helper untuk Badge (Status)
  Widget _buildBadge(String text, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Helper untuk baris info (Tanggal, Waktu, Peserta)
  Widget _buildInfoRow(IconData icon, String textLeft, String? textRight) {
    return Row(
      children: [
        Icon(icon, color: kSubTextColor, size: 16),
        const SizedBox(width: 8),
        // --- FIX DIMULAI ---
        // Dibungkus Flexible agar bisa menyusut jika textRight ada
        Flexible(
          child: Text(
            textLeft,
            style: const TextStyle(color: kSubTextColor, fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis, // Hindari overflow
            softWrap: false, // Hindari wrapping
          ),
        ),
        // --- FIX SELESAI ---
        if (textRight != null) ...[
          const Spacer(), // Dorong ke kanan
          Icon(Icons.access_time, color: kSubTextColor, size: 16),
          const SizedBox(width: 8),
          Text(
            textRight,
            style: const TextStyle(color: kSubTextColor, fontSize: 13),
          ),
        ],
      ],
    );
  }

  // Helper untuk Tombol Aksi
  Widget _buildActionButton(
      String text, Color color, Color textColor, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
