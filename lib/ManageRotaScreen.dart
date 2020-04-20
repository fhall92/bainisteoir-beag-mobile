import 'package:bainisteoir_beag/RotaDB.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'AuthFunctions.dart';
import 'RotaItem.dart';

//This is the screen where the ROTA can be managed, that is,
//New names may be added and existing names may be removed.
class ManageRotaScreen extends StatefulWidget {
  @override
  _ManageRotaScreenState createState() => _ManageRotaScreenState();
}

class _ManageRotaScreenState extends State<ManageRotaScreen> {
  String addNameText = '';

  RotaDB db = RotaDB();
  AuthFunctions _auth = AuthFunctions();

//----------DB Functions--------------------------
  _addName(name, chosen) async {
    dynamic result = await _auth.signInAnon();
    db.addName(result.uid, name, chosen);
  }

  _removeName(name) async {
    dynamic result = await _auth.signInAnon();
    db.removeName(result.uid, name);
  }

  Future _getItems() async {
    dynamic result = await _auth.signInAnon();

    Firestore firestore;
    firestore = Firestore.instance;

    var qn = await firestore.collection("rotaNames").getDocuments();

    List<RotaItem> items = [];

    for (var u in qn.documents) {
      RotaItem currentItem = RotaItem(u["uid"], u["name"], u["chosen"]);
      //Add Current card to list
      if (currentItem.uid == result.uid) {
        items.add(currentItem);
      }
    }

    //Sort Names Alphabetically
    items.sort((RotaItem a, RotaItem b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[300],
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.purple),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Manage ROTA', style: TextStyle(fontSize: 50)),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(40.0),
                constraints: BoxConstraints(maxHeight: 500.0),
                child: FutureBuilder(
                    future: _getItems(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                            child: Center(child: Text("Loading...")));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialButton(
                                height: 100,
                                minWidth: 500,
                                color: Colors.yellow[300],
                                elevation: 14.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                                onPressed: (){},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(snapshot.data[index].name,
                                        style: TextStyle(fontSize: 48)),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: MaterialButton(
                                          height: 100,
                                          minWidth: 100,
                                          color: Colors.grey,
                                          onPressed: () async {
                                            await _removeName(
                                                snapshot.data[index].name);
                                            await new Future.delayed(
                                                const Duration(
                                                    milliseconds: 500));
                                            setState(() {});
                                            print("State set");
                                          },
                                          child: Column(
                                            children: <Widget>[
                                              Text("Remove Name",
                                                  style:
                                                      TextStyle(fontSize: 30)),
                                              Icon(Icons.delete_forever,
                                                  size: 60.0,
                                                  color: Colors.red[800]),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    })),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    height: 70.0,
                    width: 300.0,
                    child: TextField(
                      style: TextStyle(fontSize: 20),
                      onChanged: (val) {
                        setState(() => addNameText = val);
                      },
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        alignLabelWithHint: true,
                        hintText: 'Enter Name',
                        labelText: 'Enter Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    height: 80,
                    minWidth: 100,
                    color: Colors.yellow[300],
                    elevation: 14.0,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(20.0))),
                    onPressed: () async {

                      if(addNameText != "") {
                        _addName(addNameText, false);
                        await new Future.delayed(
                            const Duration(milliseconds: 500));
                        setState(() {});
                        print("State set");
                      }
                    },
                    child: Text(
                      "Add Name",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        )));
  }
}


