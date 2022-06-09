import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_group_on/data/models/user_model.dart';

class LoginService {
  Future postUserCredentials(String userName, String password) async {
    print("$userName  $password");
    if (!userName.contains("@")) return "error";
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userName,
        password: password,
      );

      if (userCredential != null) {
        CollectionReference users =
            await FirebaseFirestore.instance.collection('users');
        var snapShots =
            await users.doc(userCredential.user!.uid).snapshots().first;
        AppUser().init(snapShots["userName"], userCredential!.user!.uid,
            snapShots["userImage"]);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("buraya girdi");
        return e.code;
      } else if (e.code == 'wrong-password') {
        print("yanlış şifre ");
        return e.code;
      }
    }
  }

  Future saveUserCredentials(
      String userEmail, String password, String userName) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: userEmail,
        password: password,
      )
          .then((credentials) {
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');
        FirebaseAuth auth = FirebaseAuth.instance;
        String uid = credentials!.user!.uid.toString();
        users.doc(credentials!.user!.uid).set({
          'userEmail': userEmail,
          'uid': uid,
          'userName': userName,
          'userImage':
              "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmFuZG9tJTIwcGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80"
        });
        //  users.add({'userEmail': userEmail, 'uid': uid, 'userName': userName});
        return credentials;
      });
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }
}
