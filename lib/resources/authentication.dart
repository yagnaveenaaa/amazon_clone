import 'dart:async';

import 'package:amazon_clone/model/user_models.dart';
import 'package:amazon_clone/resources/cloudfirestore_class.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CloudFirestoreClass cloudFirestoreMethods = CloudFirestoreClass();
  Future<String> signUpUser(
      {required String name,
      required String address,
      required String email,
      required String password}) async {
    String output = "";

    if (name != "" && address != "" && email != "" && password != "") {
      try {
        UserCredential currentUser = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        UserDetailsModel user =
            UserDetailsModel(name: name, email: email, address: address);

        await cloudFirestoreMethods.uploadNameAndAddressToDatabase(user: user);

        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up every thing";
    }
    return output;
  }

  Future<String> signIpUser(
      {required String email, required String password}) async {
    email = email.trim();
    password = password.trim();
    String output = "";

    if (email != "" && password != "") {
      try {
        UserCredential currentUser = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up every field";
    }
    return output;
  }
}
