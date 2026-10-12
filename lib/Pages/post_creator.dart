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
      appBar: AppBar(),
      body: Center(),
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