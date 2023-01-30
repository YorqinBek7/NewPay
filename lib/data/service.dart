import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_pay/models/cards_model.dart';

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
  Future<void> sendMoney({
    required String sum,
    required String card,
    required String senderId,
    required String senderCard,
  }) async {
    try {
      var allCards = FirebaseFirestore.instance.collectionGroup('cards').get();
      await allCards.then(
        (value) => value.docs.forEach(
          (element) async {
            if (element.get('card_number') == card) {
              double initialSum = double.parse(element.get('sum'));
              double initialIncome = double.parse(element.get('incomes'));
              await element.reference.update({
                'sum': (initialSum + double.parse(sum)).toString(),
                'incomes': (initialIncome + double.parse(sum)).toString(),
              });
            }
          },
        ),
      );
      //
      var balance = await FirebaseFirestore.instance
          .collection('users')
          .doc(senderId)
          .collection('cards')
          .doc(senderCard)
          .get()
          .then(
            (value) => value.get('sum'),
          );
      var expenses = await FirebaseFirestore.instance
          .collection('users')
          .doc(senderId)
          .collection('cards')
          .doc(senderCard)
          .get()
          .then(
            (value) => value.get('expenses'),
          );
      var balanceCard = double.parse(balance);
      balanceCard -= double.parse(sum);

      var expensesCard = double.parse(expenses);
      expensesCard -= double.parse(sum);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(senderId)
          .collection('cards')
          .doc(senderCard)
          .get()
          .then(
            (value) => value.reference.update(
              {
                'sum': balanceCard.toString(),
                'expenses': expensesCard.toString(),
              },
            ),
          );
    } catch (e) {
      print(e);
    }
  }

  /// It gets all the sums from the cards collection and returns the sum of all the sums
  ///
  /// Args:
  ///   userId (String): the user's id
  ///
  /// Returns:
  ///   A Future of a double.
  Future<double> getAllSumFromCards(String userId) async {
    double initialSum = 0;
    var allSums = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cards')
        .get()
        .then((value) => value.docs.map((e) => e.get('sum')));
    for (var element in allSums) {
      initialSum += double.parse(element);
    }
    return initialSum;
  }

  Future<double> getExpenses(String userId) async {
    double incomes = 0.0;

    var incomesSum = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cards')
        .get()
        .then((value) => value.docs.map((e) => e.get('incomes')));

    for (var element in incomesSum) {
      incomes += double.parse(element);
    }
    return incomes;
  }

  Future<double> getIncomes(String userId) async {
    double expenses = 0.0;

    var expensesSum = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cards')
        .get()
        .then((value) => value.docs.map((e) => e.get('incomes')));

    for (var element in expensesSum) {
      expenses += double.parse(element);
    }
    return expenses;
  }
}
