import 'package:bainisteoir_beag/AuthFunctions.dart';
import 'package:flutter/material.dart';

class TeacherLogin extends StatefulWidget {
  @override
  _TeacherLoginState createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  final AuthFunctions _auth = AuthFunctions();

  //text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Login'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Text(
              "Teacher Login",
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 40.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: SizedBox(
                  height: 50.0,
                  width: 300.0,
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: new InputDecoration(
                      hintText: 'you@example.com',
                      labelText: 'E-mail Address',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: SizedBox(
                  height: 50.0,
                  width: 300.0,
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    obscureText: true,
                    decoration: new InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              height: 80,
              minWidth: 200,
              color: Colors.deepPurple,
              onPressed: () async {
                print(email);
                print(password);
              },
              child: Text(
                "Login",
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              height: 80,
              minWidth: 200,
              color: Colors.deepPurple,
              onPressed: () async {
                dynamic result = await _auth.signInAnon();
                if (result == null) {
                  print("Error signing in");
                } else {
                  print("signed in");
                  print(result.uid);
                }
              },
              child: Text(
                "Login Anon",
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          )
        ])
      ]),
    );
  }
}
