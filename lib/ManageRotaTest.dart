import 'package:bainisteoir_beag/ManageRotaScreen.dart';
import 'package:flutter/material.dart';
import 'package:bainisteoir_beag/RotaDB.dart';
import 'AuthFunctions.dart';

//This screen is unused in the application but was created to test that the
//functions created in RotaDB were functioning correctly

class ManageRotaTest extends StatefulWidget {
  @override
  _ManageRotaTestState createState() => _ManageRotaTestState();
}

class _ManageRotaTestState extends State<ManageRotaTest> {
  //Text Field State
  String textFieldName = '';

  RotaDB db = RotaDB();
  AuthFunctions _auth = AuthFunctions();

  _addName(name, chosen) async {
    dynamic result = await _auth.signInAnon();
    db.addName(result.uid, name, chosen);
  }

  _printAll() async {
    dynamic result = await _auth.signInAnon();
    print(result.uid);
    db.getNames(result.uid);
  }

  _printAllNotChosen() async {
    dynamic result = await _auth.signInAnon();
    print(result.uid);
    db.getNamesNotChosen(result.uid);
  }

  _printAllChosen() async {
    dynamic result = await _auth.signInAnon();
    print(result.uid);
    db.getNamesChosen(result.uid);
  }

  _setChosen(name, chosen) async {
    dynamic result = await _auth.signInAnon();
    db.setChosen(result.uid, name, chosen);
  }

  _setChosenAll(chosen) async {
    dynamic result = await _auth.signInAnon();
    db.setChosenAll(result.uid, chosen);
  }

  _removeName(name) async {
    dynamic result = await _auth.signInAnon();
    db.removeName(result.uid, name);
  }

  _removeAll() async {
    dynamic result = await _auth.signInAnon();
    db.removeAllNames(result.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage ROTA'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                Widget>[
              Text(
                "Manage Rota Menu",
                style: TextStyle(fontSize: 24.0),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () {
                    _printAll();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  height: 80,
                  minWidth: 200,
                  color: Colors.deepPurple,
                  child: Text(
                    "Print All",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () {
                    _printAllNotChosen();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  height: 80,
                  minWidth: 200,
                  color: Colors.deepPurple,
                  child: Text(
                    "Print All Not Chosen",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    onPressed: () {
                      _printAllChosen();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    height: 80,
                    minWidth: 200,
                    color: Colors.deepPurple,
                    child: Text(
                      "Print All Chosen",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: SizedBox(
                      height: 50.0,
                      width: 300.0,
                      child: TextFormField(
                        onChanged: (val) {
                          setState(() => textFieldName = val);
                        },
                        decoration: new InputDecoration(
                          hintText: 'Add Name',
                          labelText: 'Add Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      )),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    onPressed: () {
                      _addName(textFieldName, false);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    height: 80,
                    minWidth: 200,
                    color: Colors.deepPurple,
                    child: Text(
                      "Add Name",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    onPressed: () {
                      _setChosen(textFieldName, true);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    height: 80,
                    minWidth: 200,
                    color: Colors.deepPurple,
                    child: Text(
                      "Set Chosen",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    onPressed: () {
                      _setChosenAll(true);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    height: 80,
                    minWidth: 200,
                    color: Colors.deepPurple,
                    child: Text(
                      "Set All True",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    onPressed: () {
                      _setChosenAll(false);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    height: 80,
                    minWidth: 200,
                    color: Colors.deepPurple,
                    child: Text(
                      "Set All False",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    onPressed: () {
                      _removeName(textFieldName);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    height: 80,
                    minWidth: 200,
                    color: Colors.deepPurple,
                    child: Text(
                      "Remove Selected",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    onPressed: () {
                      _removeAll();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    height: 80,
                    minWidth: 200,
                    color: Colors.deepPurple,
                    child: Text(
                      "Remove All Names",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ManageRotaScreen()));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    height: 80,
                    minWidth: 200,
                    color: Colors.deepPurple,
                    child: Text(
                      "Rota Screen",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )),
            ])
          ])),
    );
  }
}
