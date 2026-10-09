import 'package:flutter/material.dart';

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
                // TODO: open the firebase sign in screen
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