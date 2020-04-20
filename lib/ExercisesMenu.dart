import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bainisteoir_beag/CardItem.dart';
import 'AuthFunctions.dart';
import 'CardScreen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'RotaDB.dart';
import 'RotaItem.dart';

class ExercisesMenu extends StatefulWidget {
  @override
  _ExercisesMenuState createState() => _ExercisesMenuState();
}

RotaDB db = RotaDB();
AuthFunctions _auth = AuthFunctions();
String leaderString = "";
List namesList = [];

_setChosen(name, chosen) async {
  dynamic result = await _auth.signInAnon();
  db.setChosen(result.uid, name, chosen);
}

_resetList() async {
  dynamic result = await _auth.signInAnon();
  db.setChosenAll(result.uid, false);
}

//Get Names not Chosen from Rota db
Future _getRotaItems() async {
  namesList = [];
  dynamic result = await _auth.signInAnon();

  Firestore firestore;
  firestore = Firestore.instance;

  var qn = await firestore.collection("rotaNames").getDocuments();

  for (var u in qn.documents) {
    RotaItem currentItem = RotaItem(u["uid"], u["name"], u["chosen"]);
    //Add Current card to list
    if (currentItem.uid == result.uid && currentItem.chosen == false) {
      namesList.add(currentItem);
    }
  }
  if (namesList.length == 0) {
    _resetList();
    _getRotaItems();
  }
}

//Display the next Leader and update the database
String printLeader() {
  //Init Random
  Random rand = new Random();

  //Store Current random Int
  int currentRand = rand.nextInt(namesList.length);

  //Store string to output
  String chosenName = namesList[currentRand].name;

  //Update FireStore document of current item
  _setChosen(chosenName, true);

  return chosenName;
}

class _ExercisesMenuState extends State<ExercisesMenu> {
  //----------------------------Get Cards From JSON---------------------------
  Future<List<CardItem>> _getExerciseCards() async {
    var data = await rootBundle.loadString("assets/exerciseCards.json");
    Map jsonData = json.decode(data);
    List<CardItem> cards = [];

    for (var u in jsonData['Cards']) {
      CardItem currentCard = CardItem(u["image"], u["image"], u["title"]);
      //Add Current card to list
      cards.add(currentCard);
    }

    print(cards.length);
    return cards;
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
          title: Text(
            'Exercises',
            style: TextStyle(fontSize: 50),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                constraints: const BoxConstraints(minWidth: double.infinity),
                height: 500,
                child: FutureBuilder(
                    //Future builder takes in two arguments, the future function, and
                    //the builder AsyncSnapshot
                    future: _getExerciseCards(),
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
                                color: Colors.yellow[300],
                                elevation: 14.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                height: 200,
                                minWidth: 500,
                                onPressed: () {
                                  CardItem currentCard = new CardItem(
                                      ("assets/" + snapshot.data[index].front),
                                      ("assets/" + snapshot.data[index].back),
                                      (snapshot.data[index].title));
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          CardScreen(currentCard)));
                                },
                                child: Text(snapshot.data[index].title,
                                    style: TextStyle(
                                        fontSize: 48,
                                        color: Colors.deepPurple)),
                              ),
                            );
                          },
                        );
                      }
                    })),
            Container(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 100),
                        child: Text("$leaderString",
                            style: TextStyle(
                                fontSize: 60, color: Colors.deepPurple)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: MaterialButton(
                          color: Colors.yellow[300],
                          elevation: 14.0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          height: 100,
                          minWidth: 100,
                          onPressed: () async {
                            await _getRotaItems();

                            await new Future.delayed(
                                const Duration(milliseconds: 500));
                            setState(() {
                              leaderString = printLeader();
                            });
                          },
                          child: Text("Choose Leader",
                              style: TextStyle(
                                  fontSize: 48, color: Colors.deepPurple)),
                        ),
                      ),
                    ],
                  ),
                ),
                height: 80),
          ],
        ));
  }
}
