import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Café")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Ruang Rasa Café",
                style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Jl. Taman Makam Pahlawan No. 8, Purwakarta"),
            SizedBox(height: 12),
            Text("Jam Buka:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Senin - Minggu: 08.00 - 21.00"),
            SizedBox(height: 12),
            Text("Tentang Café:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "Ruang Rasa Café, tempat nongkrong yang hadir dengan menu enak, harga ramah, dan vibes yang cozy banget. Cocok buat kerja, nugas, atau sekadar healing sambil menikmati kopi favoritmu.."),
          ],
        ),
      ),
    );
  }
}
