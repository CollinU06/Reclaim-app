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
                child: ListTile(
                  leading: imageBytes != null 
                  ? Image.memory(
                      imageBytes,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                  )
                  : const Icon(Icons.image_not_supported),
                  title: Text(
                    data['description'] ?? 'No Description',
                  ),
                  subtitle: Text(
                    data['poster'] ?? 'Unknown User',
                  ),
                  trailing: Icon(
                    (data['isFound'] ?? false)
                        ? Icons.check_circle
                        : Icons.help_outline,
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