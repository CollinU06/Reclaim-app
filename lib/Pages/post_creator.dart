import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class PostCreatorPage extends StatefulWidget{
  const PostCreatorPage({super.key, required this.imagePath});

  // the photo taken with the camera
  final String imagePath;
  
  @override
  State<PostCreatorPage> createState() => _PostCreatorPageState();
}
  class _PostCreatorPageState extends State<PostCreatorPage> {

    final TextEditingController descriptionController =
      TextEditingController();

  final TextEditingController locationController =
      TextEditingController();

  final TextEditingController contactController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children:[
          // the photo, sized to fit the space above the text boxes
          Expanded(child: Image.file(File(widget.imagePath))),
          Column(
            children: [
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Describe the lost item here',
                ),
              ),
            ],
          )
        ]
      ),
      persistentFooterButtons: [
        TextButton(
          onPressed: postItemPlaceholder,
           child: Text('Confirm'),
           ),
        TextButton(
          onPressed: retakePhotoPlaceholder,
           child: Text('Retake Photo')
           ),
      ],
    );
    //throw UnimplementedError();
  }
  
 Future<void> postItemPlaceholder() async {
    try {
      //Reads Image File
      final imageBytes =
          await File(widget.imagePath).readAsBytes();

      //Converts the image to Base64
      final imageData =
          base64Encode(imageBytes);

      //Saves it to the firestore
      await FirebaseFirestore.instance
          .collection('lost_items')
          .add({
        'poster': 'Anonymous',
        'description': descriptionController.text,
        'imageData': imageData,
        'isFound': false,
      });

      //Returns to previous screen
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save post: $e'),
        ),
      );
    }
  }
  void retakePhotoPlaceholder(){
    
  }
}
