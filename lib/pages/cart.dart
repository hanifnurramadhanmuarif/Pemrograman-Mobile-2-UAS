import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang")),
      body: Obx(() {
        if (ctrl.items.isEmpty) {
          return const Center(
            child: Text("Keranjang kosong"),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView(
                children: ctrl.items.entries.map((e) {
                  final menu = ctrl.catalog.firstWhere(
                      (item) => item.id == e.key);
                  final qty = e.value;

                  return ListTile(
                    leading: Image.asset(menu.imageUrl, 
                    width: 60, height: 60),
                    title: Text(menu.name),
                    subtitle: Text(
                        "Rp ${menu.price} x $qty = Rp ${menu.price * qty}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.remove_circle_outline),
                          onPressed: () => ctrl.removeSingle(menu),
                        ),
                        Text("$qty"),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () => ctrl.addItem(menu),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Total
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Text("Rp ${ctrl.totalPrice}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.brown,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),

                  ElevatedButton(
                    onPressed: () {
                      ctrl.clearCart();
                      Get.snackbar("Checkout",
                          "Pesanan berhasil (demo)");
                    },
                    child: const Text("Checkout"),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
