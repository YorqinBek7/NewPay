class CardsModel {
  final String cardName;
  final String cardNumber;
  final String cardPeriod;
  final String cardStatus;
  final String sum;
  final String typeCard;
  CardsModel({
    required this.cardName,
    required this.cardNumber,
    required this.cardPeriod,
    required this.cardStatus,
    required this.sum,
    required this.typeCard,
  });

  factory CardsModel.fromJson(Map<String, dynamic> json) => CardsModel(
        cardName: json['card_name'] as String,
        cardNumber: json['card_number'] as String,
        cardPeriod: json['card_period'] as String,
        cardStatus: json['card_status'] as String,
        sum: json['sum'] as String,
        typeCard: json['type_card'] as String,
      );
}
