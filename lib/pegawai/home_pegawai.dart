import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePegawaiPage(),
    );
  }
}

class HomePegawaiPage extends StatelessWidget {
  const HomePegawaiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dengan dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Halo, user",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Staff IT - dinas pendidikan",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF999999),
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Card: Scan QR dengan gradient
              Center(
                child: Container(
                  width: 200,
                  height: 170,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3980F5), Color(0xFF2C6DEE)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Scan QR",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        "Scan kode QR Rapat",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Input kode rapat dengan label dan shadow
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Masukkan Kode Rapat",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFFE8E8E8),
                                width: 1,
                              ),
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Contoh: MTG-12345",
                                hintStyle: TextStyle(
                                  color: Color(0xFFC0C0C0),
                                  fontSize: 13,
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 12),
                              ),
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2562E9),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 26,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Ikuti",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // List Rapat Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "List Rapat",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DaftarRapatPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Lihat Semua",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF2562E9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // List Rapat Items
              Column(
                children: List.generate(4, (index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDDE9FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.calendar_month,
                            color: Color(0xFF2462EA),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Pembahasan Anggaran",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF2C3E50),
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "📅 01-02-2025  08.30",
                                style: TextStyle(
                                  color: Color(0xFF999999),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DaftarRapatPage extends StatefulWidget {
  const DaftarRapatPage({Key? key}) : super(key: key);

  @override
  State<DaftarRapatPage> createState() => _DaftarRapatPageState();
}

class _DaftarRapatPageState extends State<DaftarRapatPage> {
  final TextEditingController searchController = TextEditingController();
  final List<Map<String, dynamic>> rapats = [
    {
      'title': 'Rapat Koordinasi',
      'status': 'Sedang Berlangsung',
      'statusColor': const Color(0xFFFF6B6B),
      'date': '01-02-2025',
      'time': '09.00 - 11.00',
      'peserta': '12 Peserta',
    },
    {
      'title': 'Rapat Evaluasi',
      'status': 'Mendatang',
      'statusColor': const Color(0xFFFFA500),
      'date': '01-02-2025',
      'time': '09.00 - 11.00',
      'peserta': '12 Peserta',
    },
    {
      'title': 'Rapat Anggaran',
      'status': 'Selesai',
      'statusColor': const Color(0xFF4CAF50),
      'date': '01-02-2025',
      'time': '09.00 - 11.00',
      'peserta': '12 Peserta',
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredRapat = rapats
        .where((rapat) =>
            rapat['title'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2562E9),
        elevation: 0,
        leading: IconButton(  
        icon: const Icon(Icons.arrow_back, color: Colors.white),  
        onPressed: () => Navigator.pop(context),  
      ),
        title: const Text(
          'Daftar Rapat',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: "Cari rapat...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list, color: Colors.grey),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),

            // List Rapat
            ...filteredRapat.map((rapat) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE8E8E8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title dan status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          rapat['title'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: rapat['statusColor'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: rapat['statusColor'], width: 1),
                          ),
                          child: Text(
                            rapat['status'],
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: rapat['statusColor'],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Info waktu dan peserta
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            color: Color(0xFF999999), size: 16),
                        const SizedBox(width: 6),
                        Text(rapat['date'],
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xFF999999))),
                        const SizedBox(width: 16),
                        const Icon(Icons.access_time,
                            color: Color(0xFF999999), size: 16),
                        const SizedBox(width: 6),
                        Text(rapat['time'],
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xFF999999))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.person,
                            color: Color(0xFF999999), size: 16),
                        const SizedBox(width: 6),
                        Text(rapat['peserta'],
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xFF999999))),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Tombol bagian bawah
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate ke halaman detail rapat
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailRapatPage(
                                rapatData: rapat,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: rapat['status'] == 'Sedang Berlangsung'
                              ? const Color(0xFF2562E9)
                              : (rapat['status'] == 'Selesai'
                                  ? const Color(0xFF4CAF50)
                                  : const Color(0xFFD97706)),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          rapat['status'] == 'Sedang Berlangsung'
                              ? 'Gabung Sekarang'
                              : 'Lihat Detail',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// Halaman Detail Rapat
class DetailRapatPage extends StatelessWidget {
  final Map<String, dynamic> rapatData;

  const DetailRapatPage({Key? key, required this.rapatData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String status = rapatData['status'] ?? '';
    final bool isSelesai = status == 'Selesai';
    final bool isMendatang = status == 'Mendatang';
    final bool isBerlangsung = status == 'Sedang Berlangsung';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2562E9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          rapatData['title'] ?? 'Detail Rapat',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info Card dengan border radius
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        Icons.calendar_today,
                        'Hari ini, 14.00 - 16.00',
                        const Color(0xFF2562E9),
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        Icons.location_on,
                        'Ruang Meeting A',
                        const Color(0xFFFF6B6B),
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        Icons.people,
                        '8 dari 15 peserta hadir',
                        const Color(0xFF2562E9),
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        Icons.circle,
                        status,
                        rapatData['statusColor'] ?? const Color(0xFFFF6B6B),
                      ),
                    ],
                  ),
                ),

                // Ringkasan Hasil Rapat Card - Hanya muncul jika Selesai
                if (isSelesai)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Ringkasan Hasil Rapat',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C3E50),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F5E9),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'FINAL',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4CAF50),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        const Text(
                          'Rapat membahas evaluasi sistem pendidikan Q4 dengan fokus pada integrasi teknologi. Keputusan utama: migrasi sistem ke cloud infrastructure, budget dialokasikan Rp 500M, dan pembentukan tim khusus IT-Education. Target go-live Maret 2025.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF666666),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Poin Penting
                        Row(
                          children: const [
                            Icon(Icons.check_circle,
                                size: 16, color: Color(0xFF4CAF50)),
                            SizedBox(width: 6),
                            Text(
                              'Poin Penting',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2C3E50),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        _buildPoinItem(
                            'Migrasi sistem ke cloud infrastructure'),
                        _buildPoinItem(
                            'Budget approval Rp 500 Miliar untuk Q1 2025'),
                        _buildPoinItem('Pembentukan task force IT-Education'),
                        _buildPoinItem('Timeline implementasi 3 bulan'),
                        _buildPoinItem('Action items'),
                        const SizedBox(height: 4),
                        _buildSubPoinItem('Proposal teknis cloud migration'),
                        _buildSubPoinItem('Due: 20 Des'),
                        _buildSubPoinItem('PIC: Tim IT Kominfo'),

                        const SizedBox(height: 16),

                        // Budget breakdown & timeline
                        const Text(
                          'Budget breakdown & timeline',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildPoinItem('Due: 18 Des'),
                        _buildPoinItem('PIC: Bu Sari (Pendidikan)'),
                      ],
                    ),
                  ),

                // Empty State untuk Mendatang
                if (isMendatang)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.event_available,
                          size: 64,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Rapat Belum Dimulai',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ringkasan hasil rapat akan tersedia setelah rapat selesai',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Empty State untuk Sedang Berlangsung
                if (isBerlangsung)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 64,
                          color: Colors.orange[300],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Rapat Sedang Berlangsung',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Notulensi sedang dibuat. Ringkasan akan tersedia setelah rapat selesai',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 16),
              ],
            ),
          ),

          // Floating Action Button di kanan bawah - Hanya untuk Sedang Berlangsung
          if (isBerlangsung)
            Positioned(
              right: 18,
              bottom: 18,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF2C5282),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    _showChatBottomSheet(context);
                  },
                  icon: const Icon(
                    Icons.chat,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color iconColor) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF2C3E50),
          ),
        ),
      ],
    );
  }

  Widget _buildPoinItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, left: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF666666),
              height: 1.4,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF666666),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubPoinItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3, left: 20),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          color: Color(0xFF666666),
          height: 1.4,
        ),
      ),
    );
  }

  void _showChatBottomSheet(BuildContext context) {
    final TextEditingController messageController = TextEditingController();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChatBottomSheet(
        rapatTitle: rapatData['title'] ?? 'Rapat Koordinasi',
        rapatPeserta: rapatData['peserta'] ?? '8 Peserta',
        messageController: messageController,
      ),
    );
  }
}

// Widget Chat Bottom Sheet
class ChatBottomSheet extends StatefulWidget {
  final String rapatTitle;
  final String rapatPeserta;
  final TextEditingController messageController;

  const ChatBottomSheet({
    Key? key,
    required this.rapatTitle,
    required this.rapatPeserta,
    required this.messageController,
  }) : super(key: key);

  @override
  State<ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends State<ChatBottomSheet> {
  final List<Map<String, dynamic>> messages = [
    {
      'user': 'user A',
      'message': 'Lorem ipsum dolor sit amet, consectetur adipiscing do tempor incididunt ulamco quis nostrud exercitation',
      'isMe': false,
    },
    {
      'user': 'Me',
      'message': 'Lorem ipsum dolor sit amet, consectetur adipiscing do tempor incididunt ulamco quis nostrud exercitation',
      'isMe': true,
    },
    {
      'user': 'Me',
      'message': 'Lorem ipsum dolor sit amet, consectetur adipiscing do tempor incididunt ulamco quis nostrud exercitation',
      'isMe': true,
    },
    {
      'user': 'user B',
      'message': 'Lorem ipsum dolor sit amet, consectetur adipiscing do tempor incididunt ulamco quis nostrud exercitation',
      'isMe': false,
    },
    {
      'user': 'Me',
      'message': 'Lorem ipsum dolor sit amet, consectetur adipiscing do tempor incididunt ulamco quis nostrud exercitation',
      'isMe': true,
    },
    {
      'user': 'user B',
      'message': 'Lorem ipsum dolor sit amet, consectetur adipiscing do tempor incididunt ulamco quis nostrud exercitation',
      'isMe': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Drag indicator
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Title and back button
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                          color: const Color(0xFF2C3E50),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.rapatTitle,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2C3E50),
                                ),
                              ),
                              Text(
                                widget.rapatPeserta,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF999999),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Messages List
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/background.jpg'),
                      fit: BoxFit.cover,
                      opacity: 0.32,
                    ),
                  ),
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      final isMe = msg['isMe'] ?? false;
                      
                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          child: Column(
                            crossAxisAlignment: isMe 
                                ? CrossAxisAlignment.end 
                                : CrossAxisAlignment.start,
                            children: [
                              if (!isMe)
                                Padding(
                                  padding: const EdgeInsets.only(left: 4, bottom: 4),
                                  child: Text(
                                    msg['user'],
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2C3E50),
                                    ),
                                  ),
                                ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: isMe 
                                      ? const Color(0xFF2C5282)
                                      : Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(12),
                                    topRight: const Radius.circular(12),
                                    bottomLeft: isMe 
                                        ? const Radius.circular(12)
                                        : const Radius.circular(4),
                                    bottomRight: isMe 
                                        ? const Radius.circular(4)
                                        : const Radius.circular(12),
                                  ),
                                  border: !isMe
                                      ? Border.all(
                                          color: const Color(0xFFE0E0E0),
                                          width: 1,
                                        )
                                      : null,
                                ),
                                child: Text(
                                  msg['message'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isMe ? Colors.white : const Color(0xFF2C3E50),
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Input Field
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: const Color(0xFFE0E0E0),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: widget.messageController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Ketik notulensi",
                            hintStyle: TextStyle(
                              color: Color(0xFFCCCCCC),
                              fontSize: 13,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2C5282),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          // Logic untuk mengirim pesan
                          if (widget.messageController.text.isNotEmpty) {
                            setState(() {
                              messages.add({
                                'user': 'Me',
                                'message': widget.messageController.text,
                                'isMe': true,
                              });
                            });
                            widget.messageController.clear();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}