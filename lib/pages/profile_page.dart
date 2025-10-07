import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ganti warna latar belakang sesuai tema aplikasi Anda
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Tombol kembali atau aksi lainnya
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.logout, color: Colors.black54),
                    onPressed: () {
                      // Tambahkan aksi disini, misal: Navigator.pop(context) atau fungsi logout
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Avatar Pengguna
                const CircleAvatar(
                  radius: 60,
                  // Ganti dengan gambar dari assets atau network
                  backgroundImage:
                      NetworkImage('https://i.pravatar.cc/150?img=32'),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 16),

                // Nama dan Jabatan
                const Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Programer Backend',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 32),

                // Menampilkan informasi pengguna menggunakan widget kustom
                const ProfileInfoField(
                  label: 'Nomor Induk Pegawai',
                  value: '221535403111',
                  iconData: Icons.badge_outlined,
                ),
                const SizedBox(height: 16),
                const ProfileInfoField(
                  label: 'Email',
                  value: 'johndoe@example.com',
                  iconData: Icons.email_outlined,
                ),
                const SizedBox(height: 16),
                const ProfileInfoField(
                  label: 'No. Telpon',
                  value: '(+62) 81234122311',
                  iconData: Icons.phone_outlined,
                ),
                const SizedBox(height: 16),
                const ProfileInfoField(
                  label: 'Password',
                  value: '***************',
                  iconData: Icons.lock_outline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget kustom untuk setiap baris informasi
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
