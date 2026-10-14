import 'package:flutter/material.dart';
import 'package:reclaim/Widgets/lost_item.dart';

class LostItemsScreen extends StatelessWidget {
  LostItemsScreen({super.key});

  final List<LostItem> items = [
    LostItem(
      poster: "Mark",
      imagePath: "assets/wallet.jpg",
      description: "Black wallet",
      isCompleted: false,
    ),
    LostItem(
      poster: "Collin",
      imagePath: "assets/keys.jpg",
      description: "Set of keys",
      isCompleted: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lost Items"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return ListTile(
            title: Text(item.description),
            subtitle: Text(item.poster),
            trailing: Icon(
              item.isCompleted
                  ? Icons.check_circle
                  : Icons.help_outline,
            ),
          );
        },
      ),
    );
  }
}