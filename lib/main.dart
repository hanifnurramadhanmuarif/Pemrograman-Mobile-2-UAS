import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'pages/login.dart';
import 'pages/home.dart';
import 'pages/menu.dart';
import 'pages/cart.dart';
import 'pages/profile.dart';
import 'controllers/cart_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://wkwnfyywrsezxchdgaxv.supabase.co',
    anonKey: 'sb_publishable_V0fjJawlYhgc_rhYO50rhA_4xyq1k9l',
  );
  runApp(const RuangRasaApp());
}

class RuangRasaApp extends StatelessWidget {
  const RuangRasaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ruang Rasa Café',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Supabase.instance.client.auth.currentSession == null
          ? const LoginPage()
          : const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final CartController ctrl = Get.put(CartController());
  int index = 0;

  final pages = const [
    Home(),
    Menu(),
    Cart(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return pages[index];
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: index,
          onTap: (i) => setState(() => index = i),
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Home'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.restaurant_menu), label: 'Menu'),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(Icons.shopping_cart),
                  if (ctrl.totalItems > 0)
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${ctrl.totalItems}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                ],
              ),
              label: 'Cart',
            ),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Profile'),
          ],
        );
      }),
    );
  }
}
