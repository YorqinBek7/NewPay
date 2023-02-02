import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_pay/models/cards_model.dart';
import 'package:new_pay/models/transfers.dart';
import 'package:new_pay/utils/constants.dart';

class CardsService {
  CollectionReference<Map<String, dynamic>> getUserCardsCollection(
          String userId) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cards');

  /// It returns a stream of a list of cards, which is a list of documents from the cards collection of
  /// the user document

  Stream<List<CardsModel>> getCards(String userId) {
    return getUserCardsCollection(userId)
        .snapshots()
        .map((event) => (event.docs).map((e) {
              return CardsModel.fromJson(e.data());
            }).toList());
  }

  /// It takes in a CardsModel object, a cardnumber string, and a userId string, and then it adds the
  /// CardsModel object to the user's cards collection in the database

  Future<void> addCardToServer({
    required String cardNumber,
    required String userId,
    required String nameOfCard,
    required String periodCard,
  }) =>
      getUserCardsCollection(userId).doc(cardNumber).set(CardsModel(
            cardName: nameOfCard,
            cardNumber: cardNumber,
            cardPeriod: periodCard,
            cardStatus: 'Expires',
            sum: '100000.0',
            typeCard: 'Visa',
            gradientColor: {
              'first_color':
                  '0xff${NewPayConstants.selectedCardsGradient[0].substring(4, 10)}',
              'second_color':
                  '0xff${NewPayConstants.selectedCardsGradient[1].substring(4, 10)}',
            },
            expenses: '0.0',
            income: '0.0',
            transfers: [],
            userName: NewPayConstants.user.displayName!,
          ).toJson());

  Future<bool> checkCardsLimit({
    required String userId,
  }) async {
    await getUserCardsCollection(userId).get().then((value) {
      if (value.docs.length > 5) return false;
    });
    return true;
  }

  sendMoneyToService({
    required String sum,
    required String senderId,
    required String senderCard,
    required String senderName,
    required String time,
    required bool toCard,
  }) async {
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
    expensesCard += double.parse(sum);

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
        name: senderName,
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
  }

  Future<void> sendMoneyToCard({
    required String sum,
    required String reciverCard,
    required String senderId,
    required String senderCard,
    required String senderName,
    required String time,
    required bool toCard,
  }) async {
    String receiverName = '';
    try {
      var allCards =
          await FirebaseFirestore.instance.collectionGroup('cards').get();
      allCards.docs.forEach((element) async {
        if (element.get('card_number') == reciverCard) {
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
      });

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
      expensesCard += double.parse(sum);

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

  Future<double> getAllSumFromCards(String userId) async {
    try {
      double initialSum = 0;
      var allSums = await getUserCardsCollection(userId)
          .get()
          .then((value) => value.docs.map((e) => e.get('sum')));
      for (var element in allSums) {
        initialSum += double.parse(element);
      }
      return initialSum;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<double> getExpenses(String userId) async {
    try {
      double incomes = 0.0;

      var incomesSum = await getUserCardsCollection(userId)
          .get()
          .then((value) => value.docs.map((e) => e.get('expenses')));

      for (var element in incomesSum) {
        incomes += double.parse(element);
      }
      return incomes;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<double> getIncomes(String userId) async {
    try {
      double expenses = 0.0;

      var expensesSum = await getUserCardsCollection(userId)
          .get()
          .then((value) => value.docs.map((e) => e.get('incomes')));

      for (var element in expensesSum) {
        expenses += double.parse(element);
      }
      return expenses;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getTransfers(String userId) async {
    try {
      var userTransfers = await getUserCardsCollection(userId)
          .get()
          .then((value) => value.docs.map((e) => e.get('transfers')));
      return userTransfers
          .map((json) => (json as List).map((e) => Transfers.fromJson(e)))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  /// will check card is available or not
  Future<bool> checkCard(String cardNumber) async {
    try {
      var allCards =
          await FirebaseFirestore.instance.collectionGroup('cards').get();
      bool checker = false;
      allCards.docs.forEach((element) {
        if (element.get('card_number') == cardNumber) {
          checker = true;
        }
      });
      return checker;
    } catch (e) {
      throw Exception(e);
    }
  }
}
