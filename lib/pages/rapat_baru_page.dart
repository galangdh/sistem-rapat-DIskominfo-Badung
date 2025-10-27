import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal dan waktu

// Import model dan konstanta warna dari detail_page.dart
// Pastikan file detail_page.dart ada di lokasi yang benar
// Jika tidak, sesuaikan path importnya
// Menggunakan import relatif kembali, sesuaikan jika perlu
import './detail_page.dart'
    show
        kPrimaryBlue,
        kTextColor,
        kSubTextColor,
        kPageBackground,
        Participant,
        kModalTitleBlue; // Tambahkan kModalTitleBlue

class CreateEditMeetingPage extends StatefulWidget {
  // Komentar tentang existingMeeting dihapus karena ini halaman Buat Rapat
  const CreateEditMeetingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateEditMeetingPage> createState() => _CreateEditMeetingPageState();
}

class _CreateEditMeetingPageState extends State<CreateEditMeetingPage> {
  final _titleController = TextEditingController();
  final _agendaController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 11, minute: 30);

  // Data dummy untuk tamu undangan
  final List<Participant> _invitedGuests = [
    Participant(name: 'John Doe', role: 'Kadis IT'),
    Participant(name: 'Brookly', role: 'Anggota'),
    Participant(name: 'Steve', role: 'Programmer'),
  ];

  @override
  void initState() {
    super.initState();
    // Logika initState untuk mode edit dihapus
  }

  @override
  void dispose() {
    _titleController.dispose();
    _agendaController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      // Batasi tanggal mulai dari hari ini
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      // Tambahkan tema biru jika diinginkan
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kPrimaryBlue, // Warna header
              onPrimary: Colors.white, // Warna teks header
              onSurface: kTextColor, // Warna teks tanggal
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: kPrimaryBlue, // Warna tombol OK/Cancel
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay initialTime = isStartTime ? _startTime : _endTime;
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      // Tambahkan tema biru jika diinginkan
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kPrimaryBlue, // Warna header
              onPrimary: Colors.white, // Warna teks header
              onSurface: kTextColor, // Warna teks jam
            ),
            timePickerTheme: TimePickerThemeData(
              // Sesuaikan warna lain jika perlu
              dialHandColor: kPrimaryBlue,
              hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.selected)
                      ? Colors.white
                      : kTextColor),
              hourMinuteColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.selected)
                      ? kPrimaryBlue
                      : kPageBackground),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: kPrimaryBlue, // Warna tombol OK/Cancel
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
          // Otomatis atur waktu selesai 1.5 jam setelah mulai jika belum diubah
          // Periksa kondisi default awal (10:00 -> 11:30)
          final defaultStart = const TimeOfDay(hour: 10, minute: 0);
          final defaultEnd = const TimeOfDay(hour: 11, minute: 30);
          final currentStartTime =
              TimeOfDay(hour: _startTime.hour, minute: _startTime.minute);
          final currentEndTime =
              TimeOfDay(hour: _endTime.hour, minute: _endTime.minute);

          // Cek jika waktu mulai BUKAN 10:00 atau waktu selesai BUKAN 11:30
          // Artinya pengguna sudah pernah mengubah waktu sebelumnya ATAU waktu default berbeda
          // Dalam kasus ini, kita TIDAK otomatis mengubah waktu selesai
          bool isDefaultTimeUnchanged =
              currentStartTime.hour == defaultStart.hour &&
                  currentStartTime.minute == defaultStart.minute &&
                  currentEndTime.hour == defaultEnd.hour &&
                  currentEndTime.minute == defaultEnd.minute;

          // Hanya ubah _endTime jika waktu mulai diubah DARI 10:00
          // dan waktu selesai MASIH 11:30 (belum diubah manual)
          // ATAU jika ini adalah pertama kali waktu diubah dari default.
          // Koreksi logika: hanya update jika _endTime masih di default 11:30
          if (currentEndTime.hour == defaultEnd.hour &&
              currentEndTime.minute == defaultEnd.minute) {
            final newEndTime =
                DateTime(0, 0, 0, _startTime.hour, _startTime.minute)
                    .add(const Duration(hours: 1, minutes: 30));
            _endTime =
                TimeOfDay(hour: newEndTime.hour, minute: newEndTime.minute);
          }
        } else {
          _endTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeFormat = MaterialLocalizations.of(context).formatTimeOfDay;
    // Format tanggal sesuai contoh: Kamis, 11 September 2025
    final dateFormat = DateFormat('EEEE, d MMMM yyyy', 'id_ID');

    return Scaffold(
      backgroundColor: Colors.white, // Latar putih untuk bagian bawah
      appBar: _buildCustomAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Input Judul (di luar area scroll utama)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: TextFormField(
                controller: _titleController,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: kTextColor,
                ),
                decoration: InputDecoration(
                  hintText: 'Tambahkan Judul',
                  hintStyle: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade400,
                  ),
                  border: InputBorder.none, // Tanpa border
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            // Divider
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade200,
            ),
            // Area Konten Utama
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pemilih Tanggal
                  _buildSectionHeader(Icons.calendar_today, 'Hari'),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dateFormat.format(_selectedDate),
                          style: const TextStyle(
                            fontSize: 16,
                            color: kTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            size: 18, color: kSubTextColor),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Pemilih Waktu
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader(Icons.access_time, 'Mulai'),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () => _selectTime(context, true),
                              child: Text(
                                timeFormat(_startTime),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: kTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Divider(
                                color: Colors.grey.shade400,
                                thickness: 1.5,
                                endIndent: 10),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader(Icons.access_time, 'Selesai'),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () => _selectTime(context, false),
                              child: Text(
                                timeFormat(_endTime),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: kTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Divider(
                                color: Colors.grey.shade400,
                                thickness: 1.5,
                                endIndent: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Input Agenda
                  _buildSectionHeader(Icons.edit_note, 'Agenda'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _agendaController,
                    decoration: InputDecoration(
                        hintText: 'Tambahkan agenda',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade400,
                        ),
                        border: InputBorder.none,
                        enabledBorder: UnderlineInputBorder(
                          // Hanya garis bawah
                          borderSide: BorderSide(
                              color: Colors.grey.shade400, width: 1.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: kPrimaryBlue, width: 2.0),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 8.0)),
                    style: const TextStyle(fontSize: 16, color: kTextColor),
                    // Tambahkan maxLines untuk agenda yang lebih panjang
                    maxLines: null, // Otomatis menyesuaikan tinggi
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(height: 32),

                  // Daftar Tamu Undangan
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tamu Undangan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kSubTextColor,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          // TODO: Aksi untuk undang tamu baru (mungkin buka halaman/dialog baru)
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Fitur undang tamu belum diimplementasi')));
                        },
                        icon: const Icon(Icons.add,
                            color: kPrimaryBlue, size: 20),
                        label: const Text(
                          'Undang',
                          style: TextStyle(
                              color: kPrimaryBlue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _invitedGuests.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final guest = _invitedGuests[index];
                      // Gunakan widget baris peserta dari detail_page
                      // Anda mungkin perlu mengekstrak _buildParticipantRow ke file/widget terpisah
                      // untuk digunakan kembali di sini.
                      // Untuk sementara, kita buat versi sederhananya:
                      return _buildGuestRowSimple(guest, index);
                    },
                  ),
                  const SizedBox(height: 50), // Ruang ekstra di bawah
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // AppBar Kustom
  AppBar _buildCustomAppBar(BuildContext context) {
    return AppBar(
      // --- PERUBAHAN WARNA HEADER ---
      backgroundColor: kPrimaryBlue, // Menggunakan kPrimaryBlue
      // -----------------------------
      elevation: 0,
      automaticallyImplyLeading: false, // Tidak ada tombol back otomatis
      titleSpacing: 0, // Hapus padding default
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Aksi batal
            child: const Text(
              'Batal',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
          const Text(
            // Ganti judul AppBar jika perlu
            'Buat Meeting',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Aksi simpan rapat baru
              final title = _titleController.text;
              final agenda = _agendaController.text;
              // ... ambil data lainnya (_selectedDate, _startTime, _endTime, _invitedGuests)

              // Validasi sederhana (minimal judul)
              if (title.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Judul rapat tidak boleh kosong!'),
                  backgroundColor: Colors.red,
                ));
                return;
              }

              print('Simpan Rapat Baru:');
              print('Judul: $title');
              print('Tanggal: $_selectedDate');
              print('Mulai: $_startTime');
              print('Selesai: $_endTime');
              print('Agenda: $agenda');
              print('Tamu: ${_invitedGuests.map((g) => g.name).toList()}');

              // Kembali ke halaman sebelumnya setelah simpan
              Navigator.pop(context);
            },
            child: const Text(
              'Simpan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper untuk header bagian (Ikon + Teks)
  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: kSubTextColor, size: 20),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: kSubTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Helper Sederhana untuk Baris Tamu (Ganti dengan _buildParticipantRow jika memungkinkan)
  Widget _buildGuestRowSimple(Participant participant, int index) {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.purple,
      Colors.orange,
      Colors.green
    ];
    final color = colors[index % colors.length];

    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: color.withOpacity(0.15),
          child: Icon(Icons.person, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              participant.name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: kTextColor,
                fontSize: 15,
              ),
            ),
            Text(
              participant.role,
              style: const TextStyle(
                color: kSubTextColor,
                fontSize: 13,
              ),
            ),
          ],
        ),
        // Tambahkan tombol hapus (opsional)
        // const Spacer(),
        // IconButton(
        //   icon: Icon(Icons.remove_circle_outline, color: Colors.red.shade300, size: 20),
        //   onPressed: () {
        //     setState(() {
        //       _invitedGuests.removeAt(index);
        //     });
        //   },
        // ),
      ],
    );
  }
}
