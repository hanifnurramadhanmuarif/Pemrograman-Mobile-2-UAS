import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/menu_item.dart';

class CartController extends GetxController {
  final supabase = Supabase.instance.client;

  final RxMap<int, int> items = <int, int>{}.obs;
  final RxList<MenuItemModel> catalog = <MenuItemModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    fetchMenus();
    super.onInit();
  }

  // ===== READ =====
  Future<void> fetchMenus() async {
    try {
      isLoading.value = true;
      final data = await supabase.from('menus').select() as List;

      catalog.value = data.map((e) => MenuItemModel(
        id: e['id'],
        name: e['name'],
        description: e['description'],
        price: (e['price'] as num).toInt(),
        imageUrl: e['image_url'],
      )).toList();
    } catch (e) {
      print("ERROR FETCH MENU: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ===== CREATE =====
  Future<void> addMenu(MenuItemModel item) async {
    await supabase.from('menus').insert({
      'name': item.name,
      'description': item.description,
      'price': item.price,
      'image_url': item.imageUrl,
    });
    fetchMenus();
  }

  // ===== UPDATE =====
  Future<void> updateMenu(MenuItemModel item) async {
    await supabase.from('menus').update({
      'name': item.name,
      'description': item.description,
      'price': item.price,
      'image_url': item.imageUrl,
    }).eq('id', item.id);
    fetchMenus();
  }

  // ===== DELETE =====
  Future<void> deleteMenu(int id) async {
    await supabase.from('menus').delete().eq('id', id);
    fetchMenus();
  }

  // ===== CART =====

  void addItem(MenuItemModel item) {
    items[item.id] = (items[item.id] ?? 0) + 1;
    items.refresh();
  }

  void removeSingle(MenuItemModel item) {
    if (!items.containsKey(item.id)) return;

    if (items[item.id]! <= 1) {
      items.remove(item.id);
    } else {
      items[item.id] = items[item.id]! - 1;
    }
    items.refresh();
  }

  int qtyFor(int id) => items[id] ?? 0;

  int get totalItems =>
      items.values.fold(0, (sum, element) => sum + element);

  int get totalPrice {
    int total = 0;
    for (var entry in items.entries) {
      final menu =
          catalog.firstWhere((e) => e.id == entry.key);
      total += menu.price * entry.value;
    }
    return total;
  }

  void clearCart() {
    items.clear();
    items.refresh();
  }
}
