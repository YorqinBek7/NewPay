import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_pay/models/cards_model.dart';
import 'package:new_pay/models/transfers.dart';

class CardsService {
  CollectionReference<Map<String, dynamic>> getUserCardsCollection(
          String userId) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cards');

  /// It returns a stream of a list of cards, which is a list of documents from the cards collection of
  /// the user document
  ///
  /// Args:
  ///   userId (String): The user's id
  ///
  /// Returns:
  ///   A Stream of a List of CardsModel.
  Stream<List<CardsModel>> getCards(String userId) {
    return getUserCardsCollection(userId)
        .snapshots()
        .map((event) => (event.docs).map((e) {
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
      getUserCardsCollection(userId).doc(cardnumber).set(cards.toJson());

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
    required String senderName,
    required String time,
    required bool toCard,
  }) async {
    String receiverName = '';
    try {
      var allCards = FirebaseFirestore.instance.collectionGroup('cards').get();
      await allCards.then(
        (value) => value.docs.forEach(
          (element) async {
            if (element.get('card_number') == card) {
              double initialSum = double.parse(element.get('sum'));
              double initialIncome = double.parse(element.get('incomes'));
              receiverName = element.get('user_name');
              List<dynamic> transfers = element.get('transfers');
              transfers.add(
                Transfers(
                  name: '$senderName & $receiverName',
                  desc: toCard ? 'to Friend' : 'to Services',
                  sum: sum,
                  time: time,
                ).toJson(),
              );
              await element.reference.update({
                'sum': (initialSum + double.parse(sum)).toString(),
                'incomes': (initialIncome + double.parse(sum)).toString(),
                'transfers': transfers
              });
            }
          },
        ),
      );

      var balance = await FirebaseFirestore.instance
          .collection('users')
          .doc(senderId)
          .collection('cards')
          .doc(senderCard)
          .get()
          .then(
            (value) => value.get('sum'),
          );

      var balanceCard = double.parse(balance);
      balanceCard -= double.parse(sum);

      var expenses = await FirebaseFirestore.instance
          .collection('users')
          .doc(senderId)
          .collection('cards')
          .doc(senderCard)
          .get()
          .then(
            (value) => value.get('expenses'),
          );

      var expensesCard = double.parse(expenses);
      expensesCard -= double.parse(sum);

      List transfers = await FirebaseFirestore.instance
          .collection('users')
          .doc(senderId)
          .collection('cards')
          .doc(senderCard)
          .get()
          .then(
            (value) => value.get('transfers'),
          );

      transfers.add(
        Transfers(
          name: '$senderName & $receiverName',
          desc: toCard ? 'to Friend' : 'to Services',
          sum: sum,
          time: time,
        ).toJson(),
      );

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
                'transfers': transfers,
              },
            ),
          );
    } catch (e) {
      throw Exception(e);
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
    var allSums = await getUserCardsCollection(userId)
        .get()
        .then((value) => value.docs.map((e) => e.get('sum')));
    for (var element in allSums) {
      initialSum += double.parse(element);
    }
    return initialSum;
  }

  Future<double> getExpenses(String userId) async {
    double incomes = 0.0;

    var incomesSum = await getUserCardsCollection(userId)
        .get()
        .then((value) => value.docs.map((e) => e.get('expenses')));

    for (var element in incomesSum) {
      incomes += double.parse(element);
    }
    return incomes;
  }

  Future<double> getIncomes(String userId) async {
    double expenses = 0.0;

    var expensesSum = await getUserCardsCollection(userId)
        .get()
        .then((value) => value.docs.map((e) => e.get('incomes')));

    for (var element in expensesSum) {
      expenses += double.parse(element);
    }
    return expenses;
  }

  Future getTransfers(String userId) async {
    var userTransfers = await getUserCardsCollection(userId)
        .get()
        .then((value) => value.docs.map((e) => e.get('transfers')));

    return userTransfers
        .map((json) => (json as List).map((e) => Transfers.fromJson(e)))
        .toList();
  }
}
