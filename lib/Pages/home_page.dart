import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

// the first screen, with buttons for login, post, and finder
class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              onPressed: () {
                // open the firebase sign in screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(
                      providers: [EmailAuthProvider()],
                      actions: [
                        // go back to the home screen after signing in
                        AuthStateChangeAction<SignedIn>((context, state) {
                          Navigator.pop(context);
                        }),
                        // go back to the home screen after making an account
                        AuthStateChangeAction<UserCreated>((context, state) {
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
              onPressed: () {
                // TODO: open the post screen
              },
              child: const Text('Post'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: open the lost items screen
              },
              child: const Text('Finder'),
            ),
          ],
        ),
      ),
    );
  }
}