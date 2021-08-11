
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/service/AuthenticationService.dart';
import 'package:movie_app/wigets/HomePage.dart';
import 'package:movie_app/wigets/SignInPage.dart';
import 'package:movie_app/wigets/SignUpPage.dart';
import 'package:movie_app/wigets/UserAuthenticate.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(),
        ),
      ],
      child: MaterialApp(
        title: 'Movie App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => UserAuthenticate(),
          '/login': (context) => SignInPage(),
          '/signup': (context) => SignUpPage(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}

