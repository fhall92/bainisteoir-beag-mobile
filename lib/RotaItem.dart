// This class represents an object which will be stored in the rotaNames
// FireStore Database and managed by the application.
// Each RotaItem has three attributes as follows:
// uid:    the user id, linked to the current device. This is used when polling the
//         database to ensure that only names entered on the current device will be
//         viewable and manageable.
// name:   A string representing the name of a user. This will be displayed when
//         managing the ROTA and also when a leader is being chosen via the button
//         in the card menus.
// chosen: A boolean value to denote whether a name has been chosen already in the
//         card menus. This helps to enforce a system where every potential leader
//         will get a turn and is not at the mercy of a completely random selection
//         each time.
//         ie. The pool of potential leaders will only include RotaItems which have
//         a chosen value of false. Once a RotaItem is selected by the random
//         generator, its chosen value is updated to true, and it will not be chosen
//         again until the pool is exhausted and the chosen values are reset to false.

class RotaItem {
  String uid;
  String name;
  bool chosen;

  RotaItem(uid, name, chosen) {
    this.uid = uid;
    this.name = name;
    this.chosen = chosen;
  }

  void setUid(String uid) {
    this.uid = uid;
  }

  void setName(String name) {
    this.name = name;
  }

  void setChosen(bool chosen) {
    this.chosen = chosen;
  }

  String getUid() {
    return uid;
  }

  String getName() {
    return name;
  }

  bool getChosen() {
    return chosen;
  }
}
