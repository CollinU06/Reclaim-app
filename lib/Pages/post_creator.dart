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
      body: Column(
        children:[
          // the photo, sized to fit the space above the text boxes
          Expanded(child: Image.file(File(widget.imagePath))),
          Column(
            children: [
              TextField(decoration: InputDecoration(
                hintText:'Describe the lost item here'
              ),),
              TextField(decoration: InputDecoration(
                hintText:'Describe where you found the lost item'
              ),),
              TextField(decoration: InputDecoration(
                hintText:'Input your contact information here'
              ),),
            ],
          )
        ]
      ),
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
