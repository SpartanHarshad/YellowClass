import 'package:flutter/material.dart';
import 'package:movie_app/model/User.dart';
import 'package:movie_app/service/AuthenticationService.dart';
import 'package:movie_app/wigets/HomePage.dart';
import 'package:movie_app/wigets/SignInPage.dart';
import 'package:movie_app/wigets/SignUpPage.dart';
import 'package:provider/provider.dart';

class UserAuthenticate extends StatelessWidget {
  const UserAuthenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    return StreamBuilder<User?>(
        stream: authService.user,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            return user == null ? SignUpPage() : SignInPage() ;
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
