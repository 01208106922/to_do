import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:route_flutter_todo/screens/register/register_connector.dart';

import '../../models/user_model.dart';

class RegisterViewModel extends ChangeNotifier {
  RegisterConnector? registerConnector;

   CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, options) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, options) {
        return task.toJson();
      },
    );
  }

  Future<void> addUser(UserModel user) {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    return docRef.set(user);
  }


  Future<void> createAccount(String name, String emailAddress, String password) async {
    try {
      registerConnector!.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      credential.user!.sendEmailVerification();
      UserModel userModel = UserModel(
          id: credential.user!.uid,
          name: name,
          email: emailAddress,
          createdAt: DateTime.now().millisecondsSinceEpoch);
      addUser(userModel);
      registerConnector!.showSuccessMessage();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        registerConnector!.showErrorMessage(error : e.message);
      } else if (e.code == 'email-already-in-use') {
        registerConnector!.showErrorMessage(error : e.message);

      }
    } catch (e) {
      registerConnector!.showErrorMessage(error : "Something went wrong");
      print(e);
    }
  }
}
