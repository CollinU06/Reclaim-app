import 'dart:io';
import 'package:flutter/material.dart';

class PostCreatorPage extends StatefulWidget{
  const PostCreatorPage({super.key, required this.imagePath});

  // the photo taken with the camera
  final String imagePath;
  
  @override
  State<PostCreatorPage> createState() => _PostCreatorPageState();
}
class _PostCreatorPageState extends State<PostCreatorPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Image.file(File(widget.imagePath))),
      persistentFooterButtons: [
        TextButton(onPressed: () => postItemPlaceholder, child: Text('Confirm'),),
        TextButton(onPressed: () => retakePhotoPlaceholder, child: Text('Retake Photo')),
      ],
    );
    //throw UnimplementedError();
  }
  
  postItemPlaceholder(){

  }
  retakePhotoPlaceholder(){
    
  }
}