import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

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

  // the item's name
  final TextEditingController itemNameController =
      TextEditingController();

  // the category picked from the dropdown
  String? selectedCategory;

  // the kinds of items a post can be filed under
  final List<String> categories = [
    'Electronics',
    'Clothing',
    'Keys',
    'Bags',
    'ID & Cards',
    'Other',
  ];

  @override
  void dispose() {
    descriptionController.dispose();
    locationController.dispose();
    contactController.dispose();
    itemNameController.dispose();
    super.dispose();
  }

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
                controller: itemNameController,
                decoration: const InputDecoration(
                  hintText: 'Item name',
                ),
              ),
              // picks from the list so the finder screen can sort by category
              DropdownButton<String>(
                value: selectedCategory,
                isExpanded: true,
                hint: const Text('Category'),
                items: categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState((){
                    selectedCategory = value;
                  });
                },
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  hintText: 'Where was the item lost?',
                ),
              ),
              TextField(
                controller: contactController,
                decoration: const InputDecoration(
                  hintText: 'How can the finder contact you?',
                ),
              ),
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
  // stops if a required box is empty
    if (itemNameController.text.trim().isEmpty ||
        locationController.text.trim().isEmpty ||
        contactController.text.trim().isEmpty ||
        selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in the name, category, location, and contact info'),
        ),
      );
      return;
    }
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
        'itemName': itemNameController.text.trim(),
        'category': selectedCategory,
        'location': locationController.text.trim(),
        'contact': contactController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
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
    _retakePhoto();
    
  }

  //opens the camera again and swaps this screen for one with the new photo
  Future<void> _retakePhoto() async {
    // has the same settings as the home screen so the photo stays small enough for firestore
    final photo = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 800,
      imageQuality: 50,
    );
    // keeps the old photo if the user closed the camera without taking a new one
    if (photo == null) return;
    // stops if the user left this screen while the camera was open
    if(!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PostCreatorPage(imagePath: photo.path),
      ),
    );
  }
}
