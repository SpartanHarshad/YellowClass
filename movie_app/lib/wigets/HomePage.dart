import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Home"),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Log out"),
            ),
          ],
        ),
      ),
    );
  }
}
