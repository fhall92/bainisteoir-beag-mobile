import 'package:bainisteoir_beag/ActivityMenu.dart';
import 'package:bainisteoir_beag/ExercisesMenu.dart';
import 'package:bainisteoir_beag/NewCardsMenu.dart';
import 'package:bainisteoir_beag/ManageRotaScreen.dart';
import 'package:bainisteoir_beag/TutorialScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

//This is the main menu of the application, where users may navigate to other main
//screens and features
class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  Material menuItem(IconData icon, String title, Color color, var route) {
    return Material(
        color: Colors.yellow[300],
        elevation: 10.0,
        shadowColor: Colors.amber[500],
        borderRadius: BorderRadius.circular(24.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => route),
              );
            },
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Material(
                                    color: color,
                                    borderRadius: BorderRadius.circular(24.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(icon,
                                          color: Colors.white, size: 40.0),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                      color: color,
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    )))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[300],
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: <Widget>[
              menuItem(Icons.directions_run, "Activities", Colors.deepPurple,
                  ActivityMenu()),
              menuItem(Icons.accessibility_new, "Exercises", Colors.deepPurple,
                  ExercisesMenu()),
              menuItem(Icons.announcement, "New Cards", Colors.deepPurple,
                  NewMenu()),
              menuItem(
                  Icons.help, "Tutorial", Colors.deepPurple, TutorialScreen()),
              menuItem(Icons.assignment_ind, "Manage ROTA", Colors.deepPurple,
                  ManageRotaScreen()),
            ],
            staggeredTiles: [
              StaggeredTile.extent(2, 130.0),
              StaggeredTile.extent(2, 130.0),
              StaggeredTile.extent(2, 130.0),
              StaggeredTile.extent(1, 150.0),
              StaggeredTile.extent(1, 150.0),
            ],
          ),
        ));
  }
}
