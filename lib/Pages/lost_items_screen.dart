import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class LostItemsScreen extends StatelessWidget {
  const LostItemsScreen({super.key});

  
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lost Items"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('lost_items')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading posts'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {

              final data =
                docs[index].data() as Map<String, dynamic>;

              final imageBytes =
                data['imageData'] != null
                ? base64Decode(data['imageData'])
                : null;

              return Card(
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
                              : const Icon(
                                  Icons.image_not_supported,
                                  size: 80,
                                ),

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

                      const SizedBox(height: 10),

                      Text(
                        'Posted By: ${data['poster'] ?? 'Unknown User'}',
                      ),

                      Text(
                        'Category: ${data['category'] ?? 'Unknown'}',
                      ),

                      Text(
                        'Location: ${data['location'] ?? 'Unknown'}',
                      ),

                      Text(
                        'Contact: ${data['contact'] ?? 'No Contact'}',
                      ),

                      Text(
                        'Status: ${(data['isFound'] ?? false) ? "Found" : "Not Found"}',
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'Description:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        data['description'] ?? '',
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