import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_pay/models/cards_model.dart';

class AuthService {
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

class CardsService {
  CollectionReference collection =
      FirebaseFirestore.instance.collection('yorqin');

  Stream<List<CardsModel>> getCards() {
    return collection.snapshots().map(
          (event) => event.docs
              .map((e) => CardsModel.fromJson(e.data() as Map<String, dynamic>))
              .toList(),
        );
  }

  Future<List<dynamic>> getSumAllCards() => collection
      .get()
      .then((value) => value.docs.map((e) => e['sum']).toList());
}
