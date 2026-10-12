import 'package:flutter/material.dart';

class PostCreatorPage extends StatefulWidget{
  const PostCreatorPage({super.key});
  
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
          //Add image here,
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