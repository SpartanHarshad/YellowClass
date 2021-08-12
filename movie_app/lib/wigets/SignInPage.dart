import 'package:flutter/material.dart';
import 'package:movie_app/service/AuthenticationService.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  late String uEmail;
  late String uPwd;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    return MaterialApp(
      title: 'Sign In',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'SignIn Screen',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal),
                ),
              ),
              emailTextFieldItem(),
              passwordTextFieldItem(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Expanded(
                        child: ElevatedButton(
                      onPressed: () async {
                        int valideteUser = await authService
                            .signInWithEmailAndPassword(uEmail, uPwd);
                        if (valideteUser == 0) {
                          Navigator.pushNamed(context, '/home');
                        } else {
                          _showAlertDialog(
                              'Login Fail',
                              'may be you are not register with our app or you enter wrrong credential',
                              context);
                        }
                      },
                      child: Text("Sign in"),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text("Sign Up"),
                    )),
                  ),
                ],
              ),
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

  void _showAlertDialog(String title, String message, BuildContext context) {
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
