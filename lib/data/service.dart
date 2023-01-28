import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_pay/models/cards_model.dart';

class AuthService {
  /// It takes an email and password, and returns a UserCredential object
  ///
  /// Args:
  ///   email (String): The email address of the user.
  ///   password (String): The password for the new account.
  ///
  /// Returns:
  ///   A Future<UserCredential>
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// `logIn` is an asynchronous function that takes in an email and password, and then signs the user in
  /// with Firebase
  ///
  /// Args:
  ///   email (String): The email address of the user.
  ///   password (String): The user's password.
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
  /// It returns a stream of a list of cards, which is a list of documents from the cards collection of
  /// the user document
  ///
  /// Args:
  ///   userId (String): The user's id
  ///
  /// Returns:
  ///   A Stream of a List of CardsModel.
  Stream<List<CardsModel>> getCards(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cards')
        .snapshots()
        .map((event) => (event.docs).map((e) {
              print(e.data());
              return CardsModel.fromJson(e.data());
            }).toList());
  }

  /// It takes in a CardsModel object, a cardnumber string, and a userId string, and then it adds the
  /// CardsModel object to the user's cards collection in the database
  ///
  /// Args:
  ///   cards (CardsModel): is the object of the CardsModel class
  ///   cardnumber (String): is the card number
  ///   userId (String): The user's id
  Future<void> addCardToServer(
          CardsModel cards, String cardnumber, String userId) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cards')
          .doc(cardnumber)
          .set(cards.toJson());

  /// It takes two strings as arguments, one is the sum of money to be sent, the other is the card
  /// number of the recipient
  ///
  /// Args:
  ///   sum (String): the sum of money that is being sent
  ///   card (String): the card number of the receiver
  Future<void> sendMoney(String sum, String card) async {
    double initialSum = 0;

    try {
      var allCards = FirebaseFirestore.instance.collectionGroup('cards').get();
      await allCards.then(
        (value) => value.docs.forEach(
          (element) async {
            if (element.get('card_number') == card) {
              initialSum = double.parse(element.get('sum'));
              await element.reference
                  .update({'sum': (initialSum + double.parse(sum)).toString()});
            }
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
