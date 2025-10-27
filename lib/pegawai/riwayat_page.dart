// ============================================================================
// FILE: lib/pages/riwayat_page.dart
// Tampilan halaman History Rapat untuk PEGAWAI
// ============================================================================

import 'package:flutter/material.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({Key? key}) : super(key: key);

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  final TextEditingController _searchController = TextEditingController();
  
  // Data rapat - SEMUA rapat (termasuk yang belum selesai)
  final List<Map<String, dynamic>> _allRapat = [
    {
      'title': 'Rapat Koordinasi',
      'date': '01-02-2025',
      'time': '08:00',
      'peserta': '12 Peserta',
      'detailTitle': 'Rapat Anggaran',
      'jam': 'Hari ini, 14.00 - 16.00',
      'ruangan': 'Ruang Meeting A',
      'jumlahPeserta': '8 dari 15 peserta hadir',
      'status': 'Selesai',
      'ringkasan': 'Rapat membahas evaluasi sistem pendidikan Q4 dengan fokus pada integrasi teknologi. Keputusan utama: migrasi sistem ke cloud infrastructure, budget dialokasikan Rp 500M, dan pembentukan tim khusus IT-Education. Target go-live Maret 2025.',
      'poinPenting': [
        'Migrasi sistem ke cloud infrastructure',
        'Budget approval Rp 500 Miliar untuk Q1 2025',
        'Pembentukan task force IT-Education',
        'Timeline implementasi 3 bulan',
        'Action items'
      ],
      'actionItems': [
        'Proposal teknis cloud migration',
        'Due: 20 Des',
        'PIC: Tim IT Kominfo'
      ],
      'budgetBreakdown': [
        {'item': 'Due: 18 Des', 'days': ''},
        {'item': 'PIC: Bu Sari (Pendidikan)', 'days': ''}
      ],
    },
    {
      'title': 'Rapat Evaluasi',
      'date': '01-02-2025',
      'time': '09:00',
      'peserta': '12 Peserta',
      'detailTitle': 'Rapat Evaluasi Kinerja',
      'jam': 'Hari ini, 09:00 - 11:00',
      'ruangan': 'Ruang Rapat B',
      'jumlahPeserta': '10 dari 12 peserta hadir',
      'status': 'Selesai',
      'ringkasan': 'Evaluasi kinerja quarter terakhir dengan presentasi dari setiap departemen. Hasil menunjukkan peningkatan 15% dalam produktivitas. Diskusi fokus pada improvement untuk quarter mendatang.',
      'poinPenting': [
        'Peningkatan produktivitas 15%',
        'Pembahasan KPI departemen',
        'Rencana pengembangan SDM',
        'Alokasi budget untuk training'
      ],
      'actionItems': [
        'Training program proposal',
        'Due: 15 Des',
        'PIC: Dep. SDM'
      ],
      'budgetBreakdown': [
        {'item': 'Due: 10 Des', 'days': ''},
        {'item': 'PIC: Bapak Ahmad (SDM)', 'days': ''}
      ],
    },
    {
      'title': 'Rapat Perencanaan',
      'date': '02-02-2025',
      'time': '10:00',
      'peserta': '8 Peserta',
      'detailTitle': 'Rapat Perencanaan Strategis',
      'jam': 'Besok, 10:00 - 12:00',
      'ruangan': 'Ruang Board Room',
      'jumlahPeserta': '8 dari 8 peserta hadir',
      'status': 'Akan Datang',
      'ringkasan': 'Perencanaan strategis 2025 dengan target growth 20%. Pembahasan roadmap produk baru dan ekspansi market ke wilayah timur.',
      'poinPenting': [
        'Target growth 20% untuk 2025',
        'Launching 2 produk baru',
        'Ekspansi market wilayah timur',
        'Peningkatan market share 5%',
        'Alokasi budget marketing Rp 2 Miliar'
      ],
      'actionItems': [
        'Product roadmap',
        'Due: 25 Des',
        'PIC: Tim Produk'
      ],
      'budgetBreakdown': [
        {'item': 'Due: 20 Des', 'days': ''},
        {'item': 'PIC: Ibu Rina (Strategi)', 'days': ''}
      ],
    },
    {
      'title': 'Rapat Tim Marketing',
      'date': '03-02-2025',
      'time': '14:00',
      'peserta': '15 Peserta',
      'detailTitle': 'Rapat Tim Marketing Monthly',
      'jam': '03-02-2025, 14:00 - 15:30',
      'ruangan': 'Ruang Meeting Marketing',
      'jumlahPeserta': '13 dari 15 peserta hadir',
      'status': 'Dijadwalkan',
      'ringkasan': 'Review campaign bulan lalu dan planning campaign baru. Diskusi tentang strategi digital marketing dan ROI analytics untuk Q1 2025.',
      'poinPenting': [
        'Review campaign performance bulan lalu',
        'Strategi digital marketing Q1 2025',
        'Budget allocation untuk social media ads',
        'Analisis ROI dan conversion rate',
        'Planning campaign Valentine dan Ramadan'
      ],
      'actionItems': [
        'Campaign proposal',
        'Due: 22 Des',
        'PIC: Tim Marketing'
      ],
      'budgetBreakdown': [
        {'item': 'Due: 18 Des', 'days': ''},
        {'item': 'PIC: Pak Budi (Marketing)', 'days': ''}
      ],
    },
  ];

  // Filter untuk menampilkan HANYA rapat yang sudah selesai
  List<Map<String, dynamic>> get _filteredRapat {
    // Pertama, filter hanya rapat yang selesai
    final rapatSelesai = _allRapat.where((rapat) => rapat['status'] == 'Selesai').toList();
    
    // Jika ada search query, filter lagi berdasarkan pencarian
    if (_searchController.text.isEmpty) {
      return rapatSelesai;
    }
    
    final query = _searchController.text.toLowerCase();
    return rapatSelesai.where((rapat) {
      return rapat['title'].toLowerCase().contains(query) ||
             rapat['date'].contains(query) ||
             rapat['time'].contains(query);
    }).toList();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header dengan background biru
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2562E9), Color(0xFF1E41B2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'History Rapat',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 1,
                    color: Colors.white30,
                  ),
                ],
              ),
            ),
            
            // Content Area
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Search Bar
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.grey.shade400,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: 'Cari rapat...',
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Rapat Cards
                      if (_filteredRapat.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 48,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Tidak ada rapat ditemukan',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _filteredRapat.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final rapat = _filteredRapat[index];
                            return _buildRapatCard(
                              rapat['title'],
                              rapat['date'],
                              rapat['time'],
                              rapat['peserta'],
                              rapat,
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRapatCard(
    String title,
    String date,
    String time,
    String peserta,
    Map<String, dynamic> rapatData,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          
          // Date and Time
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 13,
                color: Colors.grey.shade700,
              ),
              const SizedBox(width: 6),
              Text(
                date,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.access_time,
                size: 13,
                color: Colors.grey.shade700,
              ),
              const SizedBox(width: 6),
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          
          // Peserta and Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.people,
                    size: 13,
                    color: Colors.grey.shade700,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    peserta,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3C80F5), Color(0xFF4E47E5)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3C80F5).withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotulensiDetail(rapat: rapatData),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.check_circle_outline,
                            size: 14,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Lihat Notulensi',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

// ============================================================================
// HALAMAN DETAIL NOTULENSI - SESUAI DENGAN GAMBAR
// ============================================================================

class NotulensiDetail extends StatelessWidget {
  final Map<String, dynamic> rapat;

  const NotulensiDetail({Key? key, required this.rapat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSelesai = rapat['status'] == 'Selesai';
    
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
          rapat['detailTitle'],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Card dengan ikon dan teks di sebelah kiri
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
                    rapat['jam'],
                    const Color(0xFF2562E9),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    Icons.location_on,
                    rapat['ruangan'],
                    const Color(0xFFFF6B6B),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    Icons.people,
                    rapat['jumlahPeserta'],
                    const Color(0xFF2562E9),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    Icons.circle,
                    rapat['status'],
                    const Color(0xFF4CAF50),
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

                    Text(
                      rapat['ringkasan'],
                      style: const TextStyle(
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

                    // List poin penting
                    ...List.generate(
                      (rapat['poinPenting'] as List).length,
                      (index) => _buildPoinItem(rapat['poinPenting'][index]),
                    ),

                    // Action items - sebagai sub poin
                    if (rapat['actionItems'] != null) ...[
                      const SizedBox(height: 4),
                      ...List.generate(
                        (rapat['actionItems'] as List).length,
                        (index) => _buildSubPoinItem(rapat['actionItems'][index]),
                      ),
                    ],

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
                    
                    ...List.generate(
                      (rapat['budgetBreakdown'] as List).length,
                      (index) => _buildPoinItem(rapat['budgetBreakdown'][index]['item']),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color iconColor) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: iconColor,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF2C3E50),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPoinItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
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
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '- ',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF999999),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF999999),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}