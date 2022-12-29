
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel with ChangeNotifier {
  String id;
  String displayName;
  String photoURL;
  String email;

  UserModel({
    this.id          = "",
    this.displayName = "",
    this.photoURL    = "",
    this.email       = ""
  });


  // Extraer los datos del usuario que hemos consultado
  factory UserModel.fromFirestore(DocumentSnapshot userDoc) {
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

    return UserModel(
      id:          userDoc.id, 
      displayName: userData['displayName'], 
      photoURL:    userData['photoURL'], 
      email:       userData['email'],
    );
  }


  // Esto es solo para cuando cambian los datos de la base de datos y queremos actualizarlo
  void setFromFireStore(DocumentSnapshot userDoc) {

    if (userDoc.data() != null) {
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
    
      id          = userDoc.id;
      displayName = userData['displayName'];
      photoURL    = userData['photoURL'];
      email       = userData['email'];

      // Notificamos a todos las paginas o widgets de una app para que se cambie la vieja información con la nueva
      notifyListeners();
    }
  }
}