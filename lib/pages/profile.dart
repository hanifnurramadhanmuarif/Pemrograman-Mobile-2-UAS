import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.person, size: 30),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Login sebagai:",
                        style: TextStyle(fontSize: 14)),
                    Text(
                      user?.email ?? "-",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),

            const SizedBox(height: 30),

            // About Cafe
            const Text(
              "Tentang Ruang Rasa Café",
              style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Ruang Rasa Café adalah café modern yang "
              "menyajikan berbagai minuman kopi premium "
              "dan makanan ringan dengan suasana nyaman "
              "untuk belajar, bekerja, dan bersantai. "
              "Kami mengutamakan kualitas rasa dan "
              "pelayanan terbaik untuk setiap pelanggan.",
              textAlign: TextAlign.justify,
            ),

            const Spacer(),

            // Logout
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                onPressed: () async {
                  await Supabase.instance.client.auth.signOut();
                  Get.offAll(() => const LoginPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
