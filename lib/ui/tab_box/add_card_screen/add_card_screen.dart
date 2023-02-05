import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:new_pay/data/service.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:new_pay/utils/input_formatters.dart';
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
    nameOfCardController.text = tr('my_cards');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0.r),
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
                        borderRadius: BorderRadius.circular(10.0.r),
                      ),
                      height: 200.0.h,
                      width: MediaQuery.of(context).size.width - 55.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                nameOfCardController.text,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        fontSize: 12.0.sp,
                                        color: NewPayColors.white),
                              ),
                              Text(
                                'VISA',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        fontSize: 18.0.sp,
                                        color: NewPayColors.white),
                              )
                            ],
                          ),
                          const Spacer(),
                          Text(
                            cardNumberController.text.isEmpty
                                ? '#### #### #### ####'
                                : cardNumberController.text,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    fontSize: 24.0.sp,
                                    color: NewPayColors.white),
                          ),
                          const Spacer(),
                          Text(
                            tr('expires'),
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    fontSize: 12.0.sp,
                                    color: NewPayColors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                periodController.text.isEmpty
                                    ? '##/##'
                                    : periodController.text,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        fontSize: 12.0.sp,
                                        color: NewPayColors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0.h,
                    ),
                    SizedBox(
                      height: 50.0.h,
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
                                margin:
                                    EdgeInsets.symmetric(horizontal: 10.0.w),
                                height: 42.0.h,
                                width: 71.0.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0.r),
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
                      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                      child: Column(
                        children: [
                          CustomFields(
                            controller: cardNumberController,
                            labelText: tr('card_number'),
                            onChanged: (value) => setState(() => {}),
                            formatter: CardNumberInputFormatter(),
                            inputType: TextInputType.number,
                          ),
                          CustomFields(
                            controller: periodController,
                            labelText: tr('period_card'),
                            inputType: TextInputType.number,
                            onChanged: (value) => setState(() => {}),
                            formatter: PeriodCardInputFormatter(),
                          ),
                          CustomFields(
                            onChanged: (value) => setState(() => {}),
                            controller: nameOfCardController,
                            inputType: TextInputType.text,
                            labelText: tr('name_card'),
                            formatter: NameCardInputFormatter(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            GlobalButton(
                buttonText: tr('save'),
                backgroundColor: NewPayColors.black,
                onTap: () async {
                  if (cardNumberController.text.isEmpty ||
                      periodController.text.isEmpty ||
                      nameOfCardController.text.isEmpty) {
                    return;
                  }
                  await service
                      .checkCardsLimit(
                          userId: FirebaseAuth.instance.currentUser!.uid)
                      .then((value) async {
                    if (value) {
                      await service
                          .addCardToServer(
                            cardNumber: cardNumberController.text,
                            nameOfCard: nameOfCardController.text,
                            periodCard: periodController.text,
                            userId: FirebaseAuth.instance.currentUser!.uid,
                          )
                          .then(
                            (value) => Navigator.pop(context),
                          );
                    } else {
                      Helper.showTopErrorSnackbar(
                        context: context,
                        error: tr('limit_card'),
                      );
                      return;
                    }
                  });
                }),
            SizedBox(
              height: 5.0.h,
            )
          ],
        ),
      ),
    );
  }
}
