import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../pages/detail.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Menu")),
      body: Obx(() {
        if (ctrl.catalog.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: ctrl.catalog.length,
          itemBuilder: (_, i) {
            final item = ctrl.catalog[i];
            return ListTile(
              leading: Image.asset(
                item.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(item.name),
              subtitle: Text("Rp ${item.price}"),
              trailing: ElevatedButton(
                onPressed: () => ctrl.addItem(item),
                child: const Text("Tambah"),
              ),
              onTap: () => Get.to(() => Detail(item: item)),
            );
          },
        );
      }),
    );
  }
}
