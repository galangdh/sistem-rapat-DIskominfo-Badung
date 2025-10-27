import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk haptic feedback
// import 'package:flutter/painting.dart'; // <-- DIHAPUS untuk mengatasi error analyzer

// --- Palet Warna Sesuai Gambar (dari kelola_page.dart) ---
const Color kPrimaryBlue = Color(0xFF2962FF); // Biru header & tombol
// --- TAMBAHAN WARNA UNTUK MODAL BARU ---
const Color kModalButtonBlue = Color(0xFF304FFE); // Biru tua tombol Simpan
const Color kModalTitleBlue = Color(0xFF1A237E); // Biru sangat tua untuk Judul
// ------------------------------------
const Color kCardBackground = Colors.white;
const Color kPageBackground = Color(0xFFF4F7FC); // Latar belakang halaman
const Color kInfoBackground = Color(0xFFF7F9FC); // Latar info di dalam card
const Color kSearchBorderColor = Color(0xFFE0E0E0);
const Color kTextColor = Color(0xFF333333);
const Color kSubTextColor = Color(0xFF666666);
const Color kBadgeRed = Color(0xFFF44336);
const Color kBadgeOrange = Color(0xFFFF9800);
const Color kBadgeGreen = Color(0xFF4CAF50);
// ---------------------------------------------------

// Enum dan Model ini disalin dari kelola_page.dart
// Idealnya, ini ada di file model terpisah
enum MeetingStatus { ongoing, upcoming, completed }

class Meeting {
  final String title;
  final MeetingStatus status;
  final String date;
  final String time;
  final int participants;

  Meeting({
    required this.title,
    required this.status,
    required this.date,
    required this.time,
    required this.participants,
  });
}
// ---------------------------------------------------

// --- CLASS BARU UNTUK MODEL PESERTA ---
class Participant {
  final String name;
  final String role;
  // Anda bisa tambahkan field untuk avatar, dll.

  Participant({required this.name, required this.role});
}
// ---------------------------------------------------

class DetailPage extends StatefulWidget {
  final Meeting meeting;

  const DetailPage({Key? key, required this.meeting}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Widget? _currentFab; // <-- State untuk FAB dinamis

  // --- DATA DUMMY UNTUK PESERTA ---
  final List<Participant> participants = [
    Participant(name: 'John Doe', role: 'Kadis IT'),
    Participant(name: 'Brookly', role: 'Anggota'),
    Participant(name: 'Steve', role: 'Programmer'),
    Participant(name: 'John Doe', role: 'Kadis IT'),
    Participant(name: 'Brookly', role: 'Anggota'),
    Participant(name: 'Steve', role: 'Programmer'),
    Participant(name: 'John Doe', role: 'Kadis IT'),
    Participant(name: 'Brookly', role: 'Anggota'),
  ];
  // ---------------------------------

  // --- DATA DUMMY UNTUK SUMMARY ---
  String _summaryText =
      'Rapat membahas evaluasi sistem pendidikan Q4 dengan fokus pada integrasi teknologi. Keputusan utama: migrasi sistem ke cloud dalam 3 bulan, budget dialokasikan Rp 500M, dan pembentukan tim khusus IT-Education. Target go-live Maret 2025.';
  bool _isSummaryFinal = false;
  // ---------------------------------

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Tambahkan listener untuk mengubah FAB
    _tabController.addListener(_handleTabSelection);
    // Inisialisasi FAB pertama kali
    _currentFab = _buildChatFab();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  // --- FUNGSI BARU UNTUK MENGGANTI FAB ---
  void _handleTabSelection() {
    // Hanya update jika tab selesai berpindah
    if (!_tabController.indexIsChanging) {
      setState(() {
        if (_tabController.index == 2) {
          // Tab Summary
          _currentFab = _buildEditFab();
        } else {
          // Tab Info atau Peserta
          _currentFab = _buildChatFab();
        }
      });
    }
  }

  // --- FAB UNTUK EDIT SUMMARY ---
  Widget _buildEditFab() {
    return FloatingActionButton(
      onPressed: () {
        // --- PERUBAHAN: Panggil modal edit summary ---
        _showEditSummaryModal(context);
        // -----------------------------------------
      },
      backgroundColor: kPrimaryBlue, // Warna biru tua sesuai gambar
      child: const Icon(Icons.edit, color: Colors.white),
    );
  }

  // --- FAB UNTUK CHAT ---
  Widget _buildChatFab() {
    return FloatingActionButton(
      onPressed: () {
        // Aksi untuk FAB Chat
      },
      backgroundColor: kPrimaryBlue,
      child: const Icon(Icons.chat_bubble_rounded, color: Colors.white),
    );
  }
  // --------------------------------------

  String _getStatusText(MeetingStatus status) {
    switch (status) {
      case MeetingStatus.ongoing:
        return 'Sedang Berlangsung';
      case MeetingStatus.upcoming:
        return 'Mendatang';
      case MeetingStatus.completed:
        return 'Selesai';
    }
  }

  Color _getStatusColor(MeetingStatus status) {
    switch (status) {
      case MeetingStatus.ongoing:
        return kBadgeRed;
      case MeetingStatus.upcoming:
        return kBadgeOrange;
      case MeetingStatus.completed:
        return kBadgeGreen;
    }
  }

  IconData _getStatusIcon(MeetingStatus status) {
    switch (status) {
      case MeetingStatus.ongoing:
        return Icons.sensors; // Ikon untuk 'live'
      case MeetingStatus.upcoming:
        return Icons.timelapse; // Ikon untuk 'mendatang'
      case MeetingStatus.completed:
        return Icons.check_circle; // Ikon untuk 'selesai'
    }
  }

  // --- FUNGSI BARU UNTUK MENAMPILKAN MODAL EDIT SUMMARY ---
  void _showEditSummaryModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        // Kirim data saat ini ke dialog
        return _EditSummaryDialog(
          initialText: _summaryText,
          isFinal: _isSummaryFinal,
          onSave: (newText, newIsFinal) {
            // Callback untuk menyimpan data
            setState(() {
              _summaryText = newText;
              _isSummaryFinal = newIsFinal;
            });
          },
        );
      },
    );
  }
  // ----------------------------------------------------

  // --- FUNGSI BARU UNTUK MENAMPILKAN MODAL UNDANG TAMU ---
  void _showInviteGuestModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return const _InviteGuestDialog(); // Panggil widget dialog kustom
      },
    );
  }
  // ----------------------------------------------------

  // --- FUNGSI UNTUK MENAMPILKAN MODAL OPSI ---
  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle (garis abu-abu di atas)
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),
              _buildModalOption(
                context,
                icon: Icons.update,
                title: 'Update Status',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implementasi update status
                },
              ),
              _buildModalOption(
                context,
                icon: Icons.person_add_alt_1,
                title: 'Undang Tamu',
                onTap: () {
                  // --- PERUBAHAN DI SINI ---
                  Navigator.pop(context); // Tutup modal opsi
                  _showInviteGuestModal(context); // Buka modal undang tamu
                },
              ),
              _buildModalOption(
                context,
                icon: Icons.edit_note,
                title: 'Ubah Rapat',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implementasi ubah rapat
                },
              ),
              _buildModalOption(
                context,
                icon: Icons.delete_outline,
                title: 'Hapus Rapat',
                color: kBadgeRed, // Warna merah untuk aksi hapus
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implementasi hapus rapat
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // Helper widget untuk opsi di modal
  Widget _buildModalOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    Color? color,
    required VoidCallback onTap,
  }) {
    final optionColor = color ?? kTextColor;
    return ListTile(
      leading: Icon(icon, color: optionColor),
      title: Text(
        title,
        style: TextStyle(
          color: optionColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
  // ------------------------------------------

  // --- WIDGET BARU UNTUK TAB PESERTA ---
  Widget _buildParticipantTab() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      itemCount: participants.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final participant = participants[index];
        return _buildParticipantRow(participant, index);
      },
    );
  }

  // Helper widget untuk satu baris peserta
  Widget _buildParticipantRow(Participant participant, int index) {
    // Daftar warna sederhana untuk avatar placeholder
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.purple,
      Colors.orange,
      Colors.green
    ];
    final color = colors[index % colors.length];

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: color.withOpacity(0.15), // Latar belakang avatar
        child: Icon(
          Icons.person,
          color: color, // Ikon dengan warna
          size: 30,
        ),
      ),
      title: Text(
        participant.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: kTextColor,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        participant.role,
        style: const TextStyle(
          color: kSubTextColor,
          fontSize: 14,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert, color: kSubTextColor),
        onPressed: () {
          // TODO: Aksi untuk peserta (misal: hapus, jadikan host)
        },
      ),
    );
  }
  // ---------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBackground,
      appBar: AppBar(
        backgroundColor: kPageBackground,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kTextColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.meeting.title,
          style: const TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: kTextColor),
            onPressed: () {
              // --- PANGGIL FUNGSI MODAL DI SINI ---
              _showOptionsMenu(context);
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: kPrimaryBlue,
          unselectedLabelColor: kSubTextColor,
          indicatorColor: kPrimaryBlue,
          indicatorWeight: 3,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          tabs: const [
            Tab(text: 'Info'),
            Tab(text: 'Peserta'),
            Tab(text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildInfoTab(context), // Tab Info
          _buildParticipantTab(), // Tab Peserta
          // --- PERUBAHAN: Mengganti placeholder dengan widget baru ---
          _buildSummaryTab(), // Tab Summary
          // ----------------------------------------------------
        ],
      ),
      // --- PERUBAHAN: Menggunakan FAB dinamis ---
      floatingActionButton: _currentFab,
      // ----------------------------------------
    );
  }

  // --- Widget untuk Tab Info ---
  Widget _buildInfoTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kartu Info Rapat
          _buildInfoCard(),
          const SizedBox(height: 24),
          // Judul QR Code
          const Row(
            children: [
              Icon(Icons.qr_code_scanner, color: kTextColor),
              SizedBox(width: 8),
              Text(
                'QR Code Meeting',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Bagian QR Code
          _buildQrCodeSection(context),
        ],
      ),
    );
  }

  // Kartu Info (sesuai gambar)
  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCardBackground,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow(
            Icons.calendar_today_rounded,
            kSubTextColor,
            '${widget.meeting.date}, ${widget.meeting.time}',
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            Icons.location_on_rounded, // <-- PERBAIKAN
            kSubTextColor,
            'Ruang Meeting A', // Hardcoded sesuai gambar
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            Icons.people_alt_rounded,
            kSubTextColor,
            '8 dari ${widget.meeting.participants} peserta hadir', // Hardcoded 8
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            _getStatusIcon(widget.meeting.status),
            _getStatusColor(widget.meeting.status), // Warna ikon
            _getStatusText(widget.meeting.status), // Teks status
          ),
        ],
      ),
    );
  }

  // Baris info di dalam kartu
  Widget _buildInfoRow(IconData icon, Color iconColor, String text) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: kTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // Bagian QR Code
  Widget _buildQrCodeSection(BuildContext context) {
    const String meetingCode = 'SIRAPAT202501'; // Hardcoded
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: kCardBackground,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Placeholder untuk QR Code
          const Icon(
            Icons.qr_code_2_rounded,
            size: 250,
            color: Colors.black87,
          ),
          const SizedBox(height: 20),
          // Teks Kode Rapat
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Kode : $meetingCode',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kTextColor,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 8),
              // --- PERBAIKAN DIMULAI ---
              // Bungkus dengan Builder untuk mendapatkan context baru (builderContext)
              // yang berada di bawah Scaffold.
              Builder(
                builder: (BuildContext builderContext) {
                  return GestureDetector(
                    onTap: () {
                      Clipboard.setData(const ClipboardData(text: meetingCode));
                      // Gunakan 'builderContext' baru, bukan 'context' lama.
                      ScaffoldMessenger.of(builderContext).showSnackBar(
                        const SnackBar(
                          content: Text('Kode disalin ke clipboard!'),
                          backgroundColor: kPrimaryBlue,
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.copy_all_rounded,
                      color: kPrimaryBlue,
                      size: 20,
                    ),
                  );
                },
              ),
              // --- PERBAIKAN SELESAI ---
            ],
          ),
        ],
      ),
    );
  }

  // --- WIDGET BARU UNTUK TAB SUMMARY ---
  Widget _buildSummaryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul dan Badge "draft"
          Row(
            children: [
              const Text(
                'Ringkasan hasil rapat',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kTextColor,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  // --- PERUBAHAN: Ganti badge berdasarkan status final ---
                  color: (_isSummaryFinal ? kBadgeGreen : kBadgeOrange)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _isSummaryFinal ? '● final' : '● draft',
                  style: TextStyle(
                    color: _isSummaryFinal ? kBadgeGreen : kBadgeOrange,
                    // -------------------------------------------------
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Kartu Summary
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: kCardBackground,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: kPrimaryBlue.withOpacity(0.3)), // Border biru muda
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // --- PERUBAHAN: Tampilkan teks dari state ---
                  _summaryText,
                  // ---------------------------------------
                  style: const TextStyle(
                      color: kTextColor, fontSize: 15, height: 1.5),
                ),
                const SizedBox(height: 20),

                // Poin Penting
                const Text(
                  '🔑 Poin Penting',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kTextColor,
                  ),
                ),
                const SizedBox(height: 8),
                _buildSummaryListItem('Migrasi sistem ke cloud infrastructure'),
                _buildSummaryListItem(
                    'Budget approval Rp 500 Miliar untuk Q1 2025'),
                _buildSummaryListItem('Pembentukan task force IT-Education'),
                _buildSummaryListItem('Timeline implementasi 3 bulan'),

                const SizedBox(height: 20),

                // Action Items
                const Text(
                  '⚡️ Action Items',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kTextColor,
                  ),
                ),
                const SizedBox(height: 8),
                _buildSummaryActionItem(
                  'Proposal teknis cloud migration',
                  'Due: 20 Des',
                  'PIC: Tim IT Kominfo',
                ),
                _buildSummaryActionItem(
                  'Budget breakdown & timeline',
                  'Due: 18 Des',
                  'PIC: Bu Sari (Pendidikan)',
                ),
              ],
            ),
          ),
          const SizedBox(height: 100), // Space untuk bottom nav bar
        ],
      ),
    );
  }

  // Helper untuk list item Poin Penting
  Widget _buildSummaryListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ',
              style: TextStyle(color: kSubTextColor, fontSize: 15)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  color: kSubTextColor, fontSize: 15, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  // Helper untuk list item Action Items
  Widget _buildSummaryActionItem(String title, String due, String pic) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ',
              style: TextStyle(color: kSubTextColor, fontSize: 15)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // --- PERBAIKAN GALAT SINTAKS DARI VERSI SEBELUMNYA ---
                  title,
                  // ----------------------------------------------------
                  style: const TextStyle(
                      color: kTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  due,
                  style: const TextStyle(color: kSubTextColor, fontSize: 13),
                ),
                Text(
                  pic,
                  style: const TextStyle(color: kSubTextColor, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // ------------------------------------
} // --- AKHIR DARI _DetailPageState ---

// --- WIDGET BARU UNTUK DIALOG UNDANG TAMU ---
class _InviteGuestDialog extends StatefulWidget {
  const _InviteGuestDialog({Key? key}) : super(key: key);

  @override
  __InviteGuestDialogState createState() => __InviteGuestDialogState();
}

class __InviteGuestDialogState extends State<_InviteGuestDialog> {
  late TextEditingController _nameController;
  late TextEditingController _positionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _positionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          // Konten Utama
          Container(
            padding: const EdgeInsets.all(24.0),
            margin: const EdgeInsets.only(top: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Agar modal tidak fullscreen
              children: <Widget>[
                const Text(
                  'Buat Undangan',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: kModalTitleBlue,
                  ),
                ),
                const SizedBox(height: 24.0),
                _buildTextField(
                  controller: _nameController,
                  hintText: 'Nama lengkap',
                ),
                const SizedBox(height: 16.0),
                _buildTextField(
                  controller: _positionController,
                  hintText: 'Jabatan',
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kModalButtonBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      // TODO: Implementasi logika simpan
                      // final name = _nameController.text;
                      // final position = _positionController.text;
                      Navigator.of(context).pop(); // Tutup dialog
                    },
                  ),
                ),
              ],
            ),
          ),
          // Tombol Close (X)
          Positioned(
            right: 0.0,
            top: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.close,
                  color: kTextColor,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- PERBAIKAN: Memindahkan _buildTextField ke dalam __InviteGuestDialogState ---
  // Helper untuk text field
  Widget _buildTextField(
      {required TextEditingController controller, required String hintText}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: kSubTextColor),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kSearchBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kSearchBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kPrimaryBlue, width: 2.0),
        ),
      ),
    );
  }
  // --- PERBAIKAN SELESAI ---
} // --- AKHIR DARI __InviteGuestDialogState ---

// --- WIDGET BARU UNTUK DIALOG EDIT SUMMARY ---
class _EditSummaryDialog extends StatefulWidget {
  final String initialText;
  final bool isFinal;
  final Function(String, bool) onSave;

  const _EditSummaryDialog({
    Key? key,
    required this.initialText,
    required this.isFinal,
    required this.onSave,
  }) : super(key: key);

  @override
  __EditSummaryDialogState createState() => __EditSummaryDialogState();
}

class __EditSummaryDialogState extends State<_EditSummaryDialog> {
  late TextEditingController _summaryController;
  late bool _isFinal;

  @override
  void initState() {
    super.initState();
    _summaryController = TextEditingController(text: widget.initialText);
    _isFinal = widget.isFinal;
  }

  @override
  void dispose() {
    _summaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      // --- PERBAIKAN: Bungkus Stack dengan SingleChildScrollView ---
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            // Konten Utama
            Container(
              padding: const EdgeInsets.all(24.0),
              margin: const EdgeInsets.only(
                  top: 16.0, bottom: 16.0), // Tambah margin bawah
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                // --- PERBAIKAN: Hapus mainAxisSize ---
                // mainAxisSize: MainAxisSize.min,
                // -------------------------------------
                children: <Widget>[
                  const Text(
                    'Edit Ringkasan',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: kModalTitleBlue,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  // Text Field Multi-line
                  TextField(
                    controller: _summaryController,
                    maxLines: 8, // Teks area
                    decoration: InputDecoration(
                      hintText: 'Tulis ringkasan rapat...',
                      hintStyle: const TextStyle(color: kSubTextColor),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: kSearchBorderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: kSearchBorderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: kPrimaryBlue, width: 2.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Checkbox "Final"
                  CheckboxListTile(
                    title: const Text(
                      'Final',
                      style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    value: _isFinal,
                    onChanged: (bool? value) {
                      setState(() {
                        _isFinal = value ?? false;
                      });
                    },
                    controlAffinity:
                        ListTileControlAffinity.leading, // Checkbox di kiri
                    contentPadding: EdgeInsets.zero,
                    activeColor: kPrimaryBlue,
                  ),
                  const SizedBox(height: 24.0),
                  // Tombol Simpan
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kModalButtonBlue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Simpan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        // Panggil callback onSave
                        widget.onSave(
                          _summaryController.text,
                          _isFinal,
                        );
                        Navigator.of(context).pop(); // Tutup dialog
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Tombol Close (X)
            Positioned(
              right: 0.0,
              top: 0.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding:
                      const EdgeInsets.all(4), // Padding agar X lebih besar
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: kTextColor,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // --- PERBAIKAN SELESAI ---
    );
  }
}
