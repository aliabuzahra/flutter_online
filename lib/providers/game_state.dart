import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GameState with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final int mapSize = 25;

  Map<int, String> areaOwners = {}; // index => gang name

  GameState() {
    _listenToAreas();
  }

  void _listenToAreas() {
    _firestore.collection('areas').snapshots().listen((snapshot) {
      Map<int, String> newOwners = {};
      for (var doc in snapshot.docs) {
        newOwners[int.parse(doc.id)] = doc['owner'];
      }
      areaOwners = newOwners;
      notifyListeners();
    });
  }

  void claimArea(int index, String gangName) {
    _firestore.collection('areas').doc(index.toString()).set({
      'owner': gangName,
    });
  }

  void resetAreas() {
    for (int i = 0; i < 25; i++) {
      _firestore.collection('areas').doc(i.toString()).delete();
    }
  }

  String? selectedAreaOwner(int index) => areaOwners[index];
}
