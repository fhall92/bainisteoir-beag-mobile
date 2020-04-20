import 'package:cloud_firestore/cloud_firestore.dart';
import 'RotaItem.dart';

class RotaDB {
  Firestore firestore = Firestore.instance;

  //Add name to database
  addName(uid, name, chosen) {
    Firestore.instance.runTransaction((transaction) async {
      await transaction
          .set(Firestore.instance.collection("rotaNames").document(), {
        'uid': uid,
        'name': name,
        'chosen': chosen,
      });
    });
    print("Document added");
  }

  //Return all names with specified User Id
  Future getNames(uid) async {
    Firestore firestore;
    firestore = Firestore.instance;

    var qn = await firestore.collection("rotaNames").getDocuments();

    List<RotaItem> names = [];

    for (var u in qn.documents) {
      RotaItem currentItem = RotaItem(u["uid"], u["name"], u["chosen"]);
      //Add Current card to list

      //Add Only names from current user to list
      if (uid == u["uid"]) {
        names.add(currentItem);
      }
    }

    for (var u in names) {
      print(u);
    }

    print("names in set: " + (names.length).toString());

    return names;
  }

  //Return all names that have not been chosen already
  Future getNamesNotChosen(uid) async {
    Firestore firestore;
    firestore = Firestore.instance;

    var qn = await firestore.collection("rotaNames").getDocuments();

    List<RotaItem> names = [];

    for (var u in qn.documents) {
      RotaItem currentItem = RotaItem(u["uid"], u["name"], u["chosen"]);
      //Add Current card to list

      //Add Only names from current user to list
      if (uid == u["uid"] && u["chosen"] == false) {
        names.add(currentItem);
      }
    }

    for (var u in names) {
      print(u);
    }

    print("names in set: " + (names.length).toString());

    return names;
  }

  //Return all names that have been chosen already
  Future getNamesChosen(uid) async {
    Firestore firestore;
    firestore = Firestore.instance;

    var qn = await firestore.collection("rotaNames").getDocuments();

    List<RotaItem> names = [];

    for (var u in qn.documents) {
      RotaItem currentItem = RotaItem(u["uid"], u["name"], u["chosen"]);
      //Add Only names from current user to list
      if (uid == u["uid"] && u["chosen"] == true) {
        names.add(currentItem);
      }
    }

    for (var u in names) {
      print(u);
    }

    print("names in set: " + (names.length).toString());

    return names;
  }

  //Set value of Chosen for specific document
  Future setChosen(uid, name, chosen) async {
    Firestore firestore;
    firestore = Firestore.instance;

    var qn = await firestore.collection("rotaNames").getDocuments();

    List<RotaItem> names = [];

    //For each document in rotaNames
    for (var u in qn.documents) {
      //If Uid and Name match, change value of 'chosen'
      if (uid == u["uid"] && name == u["name"]) {
        Firestore.instance
            .collection("rotaNames")
            .document(u.documentID)
            .updateData(
                {"uid": uid, "name": name, "chosen": chosen}).catchError((e) {
          print(e);
        });
      }
    }
    for (var u in names) {
      print(u);
    }

    print("Document updated");

    return names;
  }

//Set value of Chosen for specific document
  Future setChosenAll(uid, chosen) async {
    Firestore firestore;
    firestore = Firestore.instance;

    var qn = await firestore.collection("rotaNames").getDocuments();

    List<RotaItem> names = [];

    //For each document in rotaNames

    for (var u in qn.documents) {
      if (uid == u["uid"]) {
        Firestore.instance
            .collection("rotaNames")
            .document(u.documentID)
            .updateData({
          "uid": u["uid"],
          "name": u["name"],
          "chosen": chosen
        }).catchError((e) {
          print(e);
        });
      }
    }
    for (var u in names) {
      print(u);
    }

    print("All documents updated");

    return names;
  }

  //Remove specific document by name
  Future removeName(uid, name) async {
    Firestore firestore;
    firestore = Firestore.instance;

    var qn = await firestore.collection("rotaNames").getDocuments();

    //For each document in rotaNames
    for (var u in qn.documents) {
      if (uid == u["uid"] && name == u["name"]) {
        Firestore.instance
            .collection("rotaNames")
            .document(u.documentID)
            .delete()
            .catchError((e) {
          print(e);
        });
      }
    }
    print("Document Deleted: $name");
  }

  //Remove All documents with matching Uid
  Future removeAllNames(uid) async {
    Firestore firestore;
    firestore = Firestore.instance;

    var qn = await firestore.collection("rotaNames").getDocuments();

    //For each document in rotaNames
    for (var u in qn.documents) {
      if (uid == u["uid"]) {
        Firestore.instance
            .collection("rotaNames")
            .document(u.documentID)
            .delete()
            .catchError((e) {
          print(e);
        });
      }
    }
    print("All Documents Removed");
  }
}
