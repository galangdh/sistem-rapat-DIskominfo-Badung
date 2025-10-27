// ============================================================================
// FILE: lib/pages/scan_page.dart
// Tampilan halaman Scan untuk PEGAWAI (Dengan Kamera Asli)
// ============================================================================

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart'; // BARU: Import package

class ScanPage extends StatefulWidget {
  // UBAH: Menjadi StatefulWidget
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  // BARU: Controller untuk mobile scanner
  final MobileScannerController cameraController = MobileScannerController();

  // BARU: State untuk mengontrol apakah pemindaian aktif
  bool _isScanning = false;

  @override
  void dispose() {
    // BARU: Pastikan untuk dispose controller saat widget ditutup
    cameraController.dispose();
    super.dispose();
  }

  // BARU: Fungsi untuk menangani hasil scan
  void _handleQRCode(BarcodeCapture capture) {
    if (capture.barcodes.isNotEmpty) {
      final String? code = capture.barcodes.first.rawValue;

      if (code != null) {
        // Hentikan pemindaian setelah kode ditemukan
        setState(() {
          _isScanning = false;
        });

        // Tampilkan dialog dengan hasil scan
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('QR Code Terdeteksi'),
            content: Text('Data: $code'),
            actions: [
              TextButton(
                child: const Text('Tutup'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );

        // Di sini Anda bisa tambahkan logika lain,
        // misalnya navigasi ke halaman lain atau mengirim data ke server
        print('QR Code ditemukan! Data: $code');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                // UBAH: Menghapus 'const'
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  // 'const' di sini tidak masalah
                  Text(
                    'Scan QR Code',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Arahkan kamera ke kode QR',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // UBAH: Area kamera / scan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2332),
                  borderRadius: BorderRadius.circular(20),
                ),
                // BARU: ClipRRect agar tampilan kamera sesuai borderRadius
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: _isScanning
                      ? Stack(
                          // BARU: Gunakan Stack untuk menumpuk overlay
                          alignment: Alignment.center, // Pusatkan overlay
                          children: [
                            // Layer 1: Tampilan Kamera
                            MobileScanner(
                              controller: cameraController,
                              onDetect:
                                  _handleQRCode, // Panggil fungsi saat terdeteksi
                              // HAPUS: Parameter 'overlay:' sudah tidak ada
                            ),

                            // Layer 2: Widget Overlay (Bingkai)
                            Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white54, width: 2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          // Tampilan placeholder saat kamera mati
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code_scanner, // Icon diubah
                              size: 80,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Tekan "Start Scanning" untuk mulai', // Teks diubah
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Tombol Start/Stop Scanning
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // BARU: Toggle status scanning
                    setState(() {
                      _isScanning = !_isScanning;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2762EB), Color(0xFF4D47E5)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        // UBAH: Menghapus 'const'
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            // UBAH: Icon berubah sesuai status
                            _isScanning
                                ? Icons.stop_circle_outlined
                                : Icons.qr_code_scanner,
                            color: Colors.white,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            // UBAH: Teks berubah sesuai status
                            _isScanning ? 'Stop Scanning' : 'Start Scanning',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
