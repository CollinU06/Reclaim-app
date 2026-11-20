import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:convert';

class LostItemsScreen extends StatefulWidget {
  const LostItemsScreen({super.key});

  @override
  State<LostItemsScreen> createState() => _LostItemsScreenState(); //object tosae the state
}

enum ItemsSorted {
  alphabetical,
  oldest,
  newest,
} // 3 options asked in the issue

class _LostItemsScreenState extends State<LostItemsScreen> {
  //to save the options and to build the screen

  ItemsSorted _selectedSort = ItemsSorted.newest; //save it

  final Stream<QuerySnapshot> _itemsStream = FirebaseFirestore
      .instance //save it outside the build and receive updated from Firestore
      .collection('lost_items')
      .orderBy('timestamp', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 64, 56, 56),
      appBar: AppBar(
        title: const Text("Lost Items"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 221, 105, 10),

        actions: [
          //added the action and the popupMenuButton

          PopupMenuButton<ItemsSorted>(
            icon: const Icon(Icons.sort),
            initialValue: _selectedSort,
            onSelected: (value) {
              setState(() {
                _selectedSort = value;
              });
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: ItemsSorted.alphabetical,
                child: Text('Alphabetical (A–Z)'),
              ),
              PopupMenuItem(
                value: ItemsSorted.oldest,
                child: Text('Oldest first'),
              ),
              PopupMenuItem(
                value: ItemsSorted.newest,
                child: Text('Most recent'),
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _itemsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading posts'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // Basically copy the doc from FireSStore to a list where I can sort it
          final docs = snapshot.data!.docs.toList();

          if (_selectedSort == ItemsSorted.alphabetical) {
            //verifying if user selected the alphabetical order
            docs.sort((a, b) {
              final itemA = a.data() as Map<String, dynamic>;
              final itemB = b.data() as Map<String, dynamic>;

              String nameA = itemA['itemName'];
              String nameB = itemB['itemName'];

              return nameA.toLowerCase().compareTo(
                nameB.toLowerCase(),
              ); //to avoid issues
            });
          } else if (_selectedSort == ItemsSorted.oldest) {
            final reversedDocs = docs.reversed
                .toList(); //because firestore already shows the most recent
            docs.clear();
            docs.addAll(reversedDocs);
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;

              final imageBytes = data['imageData'] != null
                  ? base64Decode(data['imageData'])
                  : null;

              return Card(
                color: const Color.fromARGB(255, 155, 135, 135),
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          imageBytes != null
                              ? Image.memory(
                                  imageBytes,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.image_not_supported, size: 80),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              data['itemName'] ?? 'Unnamed Item',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Icon(
                            (data['isFound'] ?? false)
                                ? Icons.check_circle
                                : Icons.help_outline,
                            color: (data['isFound'] ?? false)
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ],
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(221, 105, 10, 0.7),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Posted By: ${data['poster'] ?? 'Unknown User'}',
                            ),
                            Text('Category: ${data['category'] ?? 'Unknown'}'),
                            Text('Location: ${data['location'] ?? 'Unknown'}'),
                            Text('Contact: ${data['contact'] ?? 'No Contact'}'),
                            Text(
                              'Status: ${(data['isFound'] ?? false) ? "Found" : "Not Found"}',
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Description:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(data['description'] ?? ''),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
