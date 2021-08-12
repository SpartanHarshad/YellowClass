import 'package:flutter/material.dart';
import 'package:movie_app/service/AuthenticationService.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String uEmail;
  late String uPwd;
  late AuthenticationService authService;

  @override
  Widget build(BuildContext context) {
    authService = Provider.of<AuthenticationService>(context);
    String msg = "user";
    return MaterialApp(
      title: 'Sign Up',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Registration',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal),
                ),
              ),
              emailTextFieldItem(),
              passwordTextFieldItem(),
              ElevatedButton(
                  onPressed: () async {
                    int Msg =
                        await authService.signUp(email: uEmail, password: uPwd);
                    if (Msg == 0) {
                      Navigator.pushNamed(context, '/login');
                    } else {
                      _showAlertDialog('Login Fail',
                          'Please check your internet connection');
                    }
                  },
                  child: Text('SignUp')),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailTextFieldItem() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ListTile(
        subtitle: TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
            hintText: 'Enter Email',
            fillColor: Colors.black,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onSubmitted: (String value) => uEmail = value,
        ),
      ),
    );
  }

  Widget passwordTextFieldItem() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ListTile(
        subtitle: TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
            hintText: 'Enter Password',
            fillColor: Colors.black,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onSubmitted: (String value) => uPwd = value,
        ),
      ),
    );
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
