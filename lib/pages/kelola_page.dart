// ============================================================================
// FILE: lib/pages/kelola_page.dart
// Buat file baru atau ganti KelolaPage di main.dart
// ============================================================================

import 'package:flutter/material.dart';

class KelolaPage extends StatefulWidget {
  const KelolaPage({Key? key}) : super(key: key);

  @override
  State<KelolaPage> createState() => _KelolaPageState();
}

class _KelolaPageState extends State<KelolaPage> {
  int _selectedTab = 0; // 0: Aktif, 1: Terjadwal, 2: Selesai

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
                // Header
                const Text(
                  'Kelola Rapat',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3C72),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 1,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 24),

                // Tab Buttons
                Row(
                  children: [
                    _buildTabButton('Aktif', 0),
                    const SizedBox(width: 12),
                    _buildTabButton('Terjadwal', 1),
                    const SizedBox(width: 12),
                    _buildTabButton('Selesai', 2),
                  ],
                ),
                const SizedBox(height: 24),

                // Meeting Cards
                _buildMeetingCard(
                  'Rapat\nkoordinasi IT',
                  '14.00-16.00',
                  'Ruang A',
                  '8/15 Hadir',
                  'LIVE',
                  const Color(0xFF1E3C72),
                ),
                const SizedBox(height: 16),

                _buildMeetingCard(
                  'Review\nProyek Website',
                  '10.00-12.00',
                  'Ruang B',
                  '12/12 Hadir',
                  'LIVE',
                  const Color(0xFF1E3C72),
                ),
                const SizedBox(height: 16),

                _buildMeetingCard(
                  'Evaluasi\nKinerja Tim',
                  '16.00-18.00',
                  'Ruang C',
                  '5/10 Hadir',
                  'LIVE',
                  const Color(0xFF1E3C72),
                ),
                const SizedBox(height: 16),

                _buildMeetingCard(
                  'Planning\nBudget 2025',
                  '09.00-11.00',
                  'Ruang Meeting',
                  '3/8 Hadir',
                  'LIVE',
                  const Color(0xFF1E3C72),
                ),
                const SizedBox(height: 100), // Extra space untuk navbar
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMeetingCard(
    String title,
    String time,
    String room,
    String attendance,
    String badge,
    Color badgeColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3C72),
                    height: 1.3,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '$time  |',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            room,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.people,
                size: 18,
                color: Colors.grey.shade700,
              ),
              const SizedBox(width: 6),
              Text(
                attendance,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.red.shade400,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E3C72) : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
