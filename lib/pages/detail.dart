import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/menu_item.dart';

class Detail extends StatelessWidget {
  final MenuItemModel item;

  const Detail({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              item.imageUrl,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12),

            Text(item.name,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),

            const SizedBox(height: 8),

            Text("Rp ${item.price}",
                style: const TextStyle(
                    fontSize: 18, color: Colors.brown)),

            const SizedBox(height: 12),

            Text(item.description),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () => ctrl.addItem(item),
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text("Tambah ke Keranjang"),
            ),
          ],
        ),
      ),
    );
  }
}
