import 'package:get/get.dart';
import '../models/menu_item.dart';

class CartController extends GetxController {
  final RxMap<int, int> items = <int, int>{}.obs;

final catalog = <MenuItemModel>[
  MenuItemModel(
    id: 1,
    name: 'Americano',
    description: 'Kopi hitam klasik dengan rasa bold.',
    price: 18000,
    imageUrl: 'assets/images/Americano.jpg',
  ),
  MenuItemModel(
    id: 2,
    name: 'Beef Teriyaki Rice Bowl',
    description: 'Nasi dengan beef teriyaki gurih manis.',
    price: 38000,
    imageUrl: 'assets/images/beef_teriyaki.jpg',
  ),
  MenuItemModel(
    id: 3,
    name: 'Cappuccino',
    description: 'Kopi susu creamy dengan foam lembut.',
    price: 25000,
    imageUrl: 'assets/images/cappuccino.jpg',
  ),
  MenuItemModel(
    id: 4,
    name: 'Caramel Macchiato',
    description: 'Kopi susu manis dengan caramel.',
    price: 32000,
    imageUrl: 'assets/images/caramel_macchiato.jpg',
  ),
  MenuItemModel(
    id: 5,
    name: 'Chicken Caesar Salad',
    description: 'Salad segar dengan ayam grilled.',
    price: 30000,
    imageUrl: 'assets/images/chiken_caesar_salad.jpg',
  ),
  MenuItemModel(
    id: 6,
    name: 'Chicken Katsu Curry',
    description: 'Nasi curry Jepang dengan katsu renyah.',
    price: 42000,
    imageUrl: 'assets/images/chicken_katsu_curry.jpg',
  ),
  MenuItemModel(
    id: 7,
    name: 'Creamy Chicken Pasta',
    description: 'Pasta creamy dengan potongan ayam.',
    price: 36000,
    imageUrl: 'assets/images/Creamy_Chicken_Pasta.jpg',
  ),
  MenuItemModel(
    id: 8,
    name: 'Croissant',
    description: 'Croissant buttery yang lembut dan flaky.',
    price: 17000,
    imageUrl: 'assets/images/croissant.jpg',
  ),
  MenuItemModel(
    id: 9,
    name: 'Grilled Sandwich',
    description: 'Sandwich panggang isi beef & cheese.',
    price: 24000,
    imageUrl: 'assets/images/Grilled_Sandwich.jpg',
  ),
  MenuItemModel(
    id: 10,
    name: 'Lemon Mint Cooler',
    description: 'Minuman lemon segar dengan mint.',
    price: 18000,
    imageUrl: 'assets/images/Lemon_Mint.jpg',
  ),
  MenuItemModel(
    id: 11,
    name: 'Matcha',
    description: 'Matcha premium creamy.',
    price: 28000,
    imageUrl: 'assets/images/matcha.jpg',
  ),
  MenuItemModel(
    id: 12,
    name: 'Smoothie',
    description: 'Smoothie buah segar dingin & lembut.',
    price: 25000,
    imageUrl: 'assets/images/smothie.jpg',
  ),
  MenuItemModel(
    id: 13,
    name: 'Strawberry Sparkling Refresher',
    description: 'Minuman soda strawberry yang segar.',
    price: 22000,
    imageUrl: 'assets/images/Strawberry_Sparkling.jpg',
  ),
  MenuItemModel(
    id: 14,
    name: 'Truffle Fries',
    description: 'Kentang goreng dengan aroma truffle.',
    price: 28000,
    imageUrl: 'assets/images/Truffle_Fries.jpg',
  ),
  MenuItemModel(
    id: 15,
    name: 'Vanilla Sweet Cream Cold Brew',
    description: 'Cold brew dengan vanilla sweet cream.',
    price: 32000,
    imageUrl: 'assets/images/vanilla_coldbrew.jpg',
  ),
];



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
