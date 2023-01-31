import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:new_pay/data/service.dart';
import 'package:new_pay/models/cards_model.dart';
import 'package:new_pay/models/transfers.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:new_pay/utils/input_formatters.dart';
import 'package:new_pay/utils/styles.dart';
import 'package:new_pay/widgets/custom_fields.dart';
import 'package:new_pay/widgets/global_button.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController cardNumberController = TextEditingController();

  final TextEditingController periodController = TextEditingController();

  final TextEditingController nameOfCardController = TextEditingController();
  CardsService service = CardsService();

  @override
  void initState() {
    nameOfCardController.text = 'My Card';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.0,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: List.from(
                            <Color>[
                              Helper.hexToColor(
                                  NewPayConstants.selectedCardsGradient[0]),
                              Helper.hexToColor(
                                  NewPayConstants.selectedCardsGradient[1])
                            ],
                          ),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height: 200.0,
                      width: MediaQuery.of(context).size.width - 55.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                nameOfCardController.text,
                                style: NewPayStyles.w700.copyWith(
                                    fontSize: 12.0, color: NewPayColors.white),
                              ),
                              Text(
                                'VISA',
                                style: NewPayStyles.w800.copyWith(
                                    fontSize: 18.0, color: NewPayColors.white),
                              )
                            ],
                          ),
                          const Spacer(),
                          Text(
                            cardNumberController.text.isEmpty
                                ? '#### #### #### ####'
                                : cardNumberController.text,
                            style: NewPayStyles.w500.copyWith(
                                fontSize: 24.0, color: NewPayColors.white),
                          ),
                          const Spacer(),
                          Text(
                            'Expires',
                            style: NewPayStyles.w400.copyWith(
                                fontSize: 12.0, color: NewPayColors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                periodController.text.isEmpty
                                    ? '##/##'
                                    : periodController.text,
                                style: NewPayStyles.w700.copyWith(
                                    fontSize: 12.0, color: NewPayColors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                            4,
                            (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  NewPayConstants.selectedCardsGradient[0] =
                                      NewPayConstants
                                          .cardsGradient[index].firstColor;
                                  NewPayConstants.selectedCardsGradient[1] =
                                      NewPayConstants
                                          .cardsGradient[index].secondColor;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                height: 42.0,
                                width: 71.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  gradient: LinearGradient(
                                    colors: List.from([
                                      Helper.hexToColor(NewPayConstants
                                          .cardsGradient[index].firstColor),
                                      Helper.hexToColor(NewPayConstants
                                          .cardsGradient[index].secondColor),
                                    ]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          CustomFields(
                            controller: cardNumberController,
                            labelText: 'Card Number',
                            onChanged: (value) => setState(() => {}),
                            formatter: CardNumberInputFormatter(),
                            inputType: TextInputType.number,
                          ),
                          CustomFields(
                            controller: periodController,
                            labelText: 'Period Card',
                            inputType: TextInputType.number,
                            onChanged: (value) => setState(() => {}),
                            formatter: PeriodCardInputFormatter(),
                          ),
                          CustomFields(
                            onChanged: (value) => setState(() => {}),
                            controller: nameOfCardController,
                            inputType: TextInputType.text,
                            labelText: 'Name Card',
                            formatter: NameCardInputFormatter(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            GlobalButton(
                buttonText: 'Save',
                backgroundColor: NewPayColors.black,
                onTap: () async {
                  if (cardNumberController.text.isEmpty ||
                      periodController.text.isEmpty ||
                      nameOfCardController.text.isEmpty) {
                    return;
                  }
                  await service
                      .addCardToServer(
                        CardsModel(
                          cardName: nameOfCardController.text,
                          cardNumber: cardNumberController.text,
                          cardPeriod: periodController.text,
                          cardStatus: 'Expires',
                          sum: '0.0',
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
                        ),
                        cardNumberController.text,
                        NewPayConstants.user.uid,
                      )
                      .then(
                        (value) => Navigator.pop(context),
                      );
                }),
            SizedBox(
              height: 5.0,
            )
          ],
        ),
      ),
    );
  }
}
