import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reclaim/Pages/lost_items_screen.dart';
import 'package:reclaim/Pages/post_creator.dart';

// the first screen, with buttons for login, post, and finder
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isUserSignedIn = false;

  // call this after the user signs in to grey out the login button
  void _signedIn() {
    setState(() {
      _isUserSignedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reclaim'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              // onPressed is null when signed in, which greys out the button
              onPressed: _isUserSignedIn
                  ? null
                  : () {
                      // open the firebase sign in screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(
                            providers: [EmailAuthProvider()],
                            actions: [
                              // go back to the home screen after signing in
                              AuthStateChangeAction<SignedIn>((context, state) {
                                _signedIn();
                                Navigator.pop(context);
                              }),
                              // go back to the home screen after making an account
                              AuthStateChangeAction<UserCreated>((context, state) {
                                _signedIn();
                                Navigator.pop(context);
                              }),
                            ],
                          ),
                        ),
                      );
                    },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // you have to be logged in to post
                if (!_isUserSignedIn) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please log in first')),
                  );
                  return;
                }
                // open the phone's camera
                // the photo is shrunk so it can be saved in firestore
                final photo = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                  maxWidth: 800,
                  imageQuality: 50,
                );
                // stop if the user closed the camera without taking a photo
                if (photo == null) return;
                // stop if the user left this screen while the camera was open
                if (!mounted) return;
                // open the post screen with the photo
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostCreatorPage(imagePath: photo.path),
                  ),
                );
              },
              child: const Text('Post'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LostItemsScreen(),));
              },
              child: const Text('Lost Items'),
            ),
          ],
        ),
      ),
    );
  }
}
