// FILE: lib/pages/profile_page.dart
// Tampilan halaman Profile untuk PEGAWAI
// ============================================================================

import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Data profile - bisa disesuaikan atau ambil dari API
  final String name = 'John Doe';
  final String position = 'Programer Backend';
  final String employeeId = '22153540311111';
  final String email = 'johndoe@example.com';
  final String phone = '(+62) 81234122311';
  final String password = '••••••••••••••';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header dengan tombol exit
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Aksi untuk exit/logout
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.exit_to_app,
                          color: Color(0xFF2C5AA0),
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Foto Profil dengan border biru
                Container(
                  width: 165,
                  height: 165,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF7B9FD9),
                      width: 5,
                    ),
                  ),
                  child: CircleAvatar(
                        backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=33',
                    ),
                    backgroundColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 20),

                // Nama
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C5AA0),
                  ),
                ),
                const SizedBox(height: 8),

                // Posisi
                Text(
                  position,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF999999),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32),

                // Field: Nomor Induk Pegawai
                _buildTextField(
                  label: 'Nomor Induk Pegawai',
                  value: employeeId,
                  icon: Icons.badge,
                ),
                const SizedBox(height: 16),

                // Field: Email
                _buildTextField(
                  label: 'Email',
                  value: email,
                  icon: Icons.email,
                ),
                const SizedBox(height: 16),

                // Field: No. Telepon
                _buildTextField(
                  label: 'No. Telepon',
                  value: phone,
                  icon: Icons.phone,
                ),
                const SizedBox(height: 16),

                // Field: Password
                _buildTextField(
                  label: 'Password',
                  value: password,
                  icon: Icons.lock,
                  isPassword: true,
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.home_outlined,
                  label: 'Home',
                  isActive: false,
                ),
                _buildNavItem(
                  icon: Icons.crop_square,
                  label: 'Scan',
                  isActive: false,
                ),
                _buildNavItem(
                  icon: Icons.menu_book_outlined,
                  label: 'Riwayat',
                  isActive: false,
                ),
                _buildNavItem(
                  icon: Icons.person,
                  label: 'Profile',
                  isActive: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: TextField(
            readOnly: true,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: value,
              hintStyle: const TextStyle(
                color: Color(0xFF2C5AA0),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: Icon(
                icon,
                color: const Color(0xFF2C5AA0),
                size: 20,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
            ),
            style: const TextStyle(
              color: Color(0xFF2C5AA0),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFF2C5AA0) : const Color(0xFFA0A0A0),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? const Color(0xFF2C5AA0) : const Color(0xFFA0A0A0),
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}