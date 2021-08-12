import 'package:flutter/material.dart';
import 'package:movie_app/wigets/MovieList.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Movie List'),
          actions: <Widget>[
            Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.logout_rounded,
                size: 26.0,
              ),
            )
          ),
          ],
        ),
        body: SafeArea(
          child:MovieList() 
        ),
      ),
    );
  }
}
