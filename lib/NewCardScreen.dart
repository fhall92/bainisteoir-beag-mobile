import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:bainisteoir_beag/CardItem.dart';

// This screen functions similarly to CardScreen.dart, except that the images
// are loaded in as network images (from the Firebase Storage bucket) instead of
// from local assets.
class NewCardScreen extends StatefulWidget {
  final CardItem currentCard;

  NewCardScreen(this.currentCard);

  @override
  State<StatefulWidget> createState() {
    return NewCardScreenState(this.currentCard);
  }
}

class NewCardScreenState extends State<NewCardScreen> {

  // This function creates a url based on how firebase storage viewable urls are
  // named. The static parts of the url are concatenated with the file name passed into the
  // function, effectively "guessing" the url for the images uploaded to the storage bucket.
  static String constructUrl(var image) {
    String first =
        "https://firebasestorage.googleapis.com/v0/b/bainisteoir-beag.appspot.com/o/cards%2F";
    String second = image;
    String third = "?alt=media";

    String finalUrl = first + second + third;

    return finalUrl;
  }

  CardItem currentCard;

  NewCardScreenState(this.currentCard);

  @override
  Widget build(BuildContext context) {
    String frontUrl = constructUrl(currentCard.getFront());
    String backUrl = constructUrl(currentCard.getBack());
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
                        title: Text(currentCard.getTitle()),
                      ),
                      body: Image.network(
                        frontUrl,
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
                        title: Text(currentCard.getTitle()),
                      ),
                      body: Image.network(
                        backUrl,
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
