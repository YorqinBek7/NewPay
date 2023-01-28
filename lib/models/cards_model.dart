class CardsModel {
  final String cardName;
  final String cardNumber;
  final String cardPeriod;
  final String cardStatus;
  final String sum;
  final String typeCard;
  final Map<String, dynamic> gradientColor;
  final String income;
  final String expenses;
  CardsModel({
    required this.cardName,
    required this.cardNumber,
    required this.cardPeriod,
    required this.cardStatus,
    required this.sum,
    required this.typeCard,
    required this.gradientColor,
    required this.income,
    required this.expenses,
  });

  factory CardsModel.fromJson(Map<String, dynamic> json) => CardsModel(
        cardName: json['card_name'] as String,
        cardNumber: json['card_number'] as String,
        cardPeriod: json['card_period'] as String,
        cardStatus: json['card_status'] as String,
        sum: json['sum'] as String,
        typeCard: json['card_type'] as String,
        gradientColor: json['gradient_color'] as Map<String, dynamic>,
        expenses: json['expenses'] as String,
        income: json['incomes'] as String,
      );
  Map<String, dynamic> toJson() => {
        'card_name': cardName,
        'card_number': cardNumber,
        'card_period': cardPeriod,
        'card_status': cardStatus,
        'sum': sum,
        'card_type': typeCard,
        'gradient_color': gradientColor,
        'expenses': expenses,
        'incomes': income,
      };
}
