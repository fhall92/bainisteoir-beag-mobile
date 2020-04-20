import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TeacherRegister extends StatefulWidget {
  @override
  _TeacherRegisterState createState() => _TeacherRegisterState();
}

class _TeacherRegisterState extends State<TeacherRegister> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //text field state
  String email = '';
  String password = '';
  String passwordConfirm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Register'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Teacher Register",
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
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: SizedBox(
                          height: 50.0,
                          width: 300.0,
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() => passwordConfirm = val);
                            },
                            obscureText: true,
                            decoration: new InputDecoration(
                              hintText: 'Confirm Password',
                              labelText: 'Confirm Password',
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      height: 80,
                      minWidth: 200,
                      color: Colors.deepPurple,
                      onPressed: () {
                        print(email);
                        print(password);
                        print(passwordConfirm);
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ),
                  )
                ])
          ]),
    );
  }
}
