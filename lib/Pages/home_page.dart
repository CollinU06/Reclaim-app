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
      backgroundColor: const Color.fromARGB(255, 64, 56, 56),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 221, 105, 10),
        shape: const Border(bottom: BorderSide(color: Colors.black)),

        title: const Center(
          child: Text(
            'Reclaim',
            style: TextStyle(color: Color.fromARGB(255, 39, 33, 33)),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                side: const BorderSide(color: Colors.black),
              ),
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
                              AuthStateChangeAction<UserCreated>((
                                context,
                                state,
                              ) {
                                _signedIn();
                                Navigator.pop(context);
                              }),
                            ],
                          ),
                        ),
                      );
                    },
              child: const Text(
                'Login',
                style: TextStyle(color: Color.fromARGB(255, 52, 48, 43)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // you have to be logged in to post
                if (!_isUserSignedIn) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please log in first',
                        style: TextStyle(color: Colors.orangeAccent),
                      ),
                    ),
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
                    builder: (context) =>
                        PostCreatorPage(imagePath: photo.path),
                  ),
                );
              },
              child: const Text('Post'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: const Color.fromARGB(255, 52, 48, 43),
                side: const BorderSide(color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LostItemsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                side: const BorderSide(color: Colors.black),
              ),
              child: const Text(
                'Lost Items',
                style: TextStyle(color: Color.fromARGB(255, 52, 48, 43)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
