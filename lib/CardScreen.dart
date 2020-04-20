//This is the screen on which the chosen card is displayed.
//It utilizes the flip_card library to display the front and back image
//of a specific card when the image is tapped

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:bainisteoir_beag/CardItem.dart';

class CardScreen extends StatefulWidget {
  final CardItem currentCard;

  CardScreen(this.currentCard);

  @override
  State<StatefulWidget> createState() {
    return CardScreenState(this.currentCard);
  }
}

class CardScreenState extends State<CardScreen> {
  CardItem currentCard;

  CardScreenState(this.currentCard);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, top: 0.0, right: 0.0, bottom: 0.0),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: FlipCard(
                  direction: FlipDirection.VERTICAL, // default
                  front: MaterialApp(
                    home: Scaffold(
                      appBar: AppBar(
                        leading: new IconButton(
                          icon:
                              new Icon(Icons.arrow_back, color: Colors.purple),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        title: Text(
                          currentCard.getTitle(),
                          style: TextStyle(fontSize: 50),
                        ),
                      ),
                      body: Image.asset(
                        currentCard.getFront(),
                        fit: BoxFit.fill,
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.center,
                      ), //   <-- image
                    ),
                  ),
                  back: MaterialApp(
                    home: Scaffold(
                      appBar: AppBar(
                        leading: new IconButton(
                          icon:
                              new Icon(Icons.arrow_back, color: Colors.purple),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        title: Text(currentCard.getTitle(),
                            style: TextStyle(fontSize: 50)),
                      ),
                      body: Image.asset(
                        currentCard.getBack(),
                        fit: BoxFit.fill,
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.center,
                      ), //   <-- image
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
