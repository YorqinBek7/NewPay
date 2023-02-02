import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:new_pay/data/service.dart';
import 'package:new_pay/models/cards_model.dart';
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
                                style: NewPayStyles.w700.copyWith(
                                    fontSize: 12.0.sp,
                                    color: NewPayColors.white),
                              ),
                              Text(
                                'VISA',
                                style: NewPayStyles.w800.copyWith(
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
                            style: NewPayStyles.w500.copyWith(
                                fontSize: 24.0.sp, color: NewPayColors.white),
                          ),
                          const Spacer(),
                          Text(
                            'Expires',
                            style: NewPayStyles.w400.copyWith(
                                fontSize: 12.0.sp, color: NewPayColors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                periodController.text.isEmpty
                                    ? '##/##'
                                    : periodController.text,
                                style: NewPayStyles.w700.copyWith(
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
            const Spacer(),
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
                      .checkCardsLimit(userId: NewPayConstants.user.uid)
                      .then((value) async {
                    if (value) {
                      await service
                          .addCardToServer(
                            cardNumber: cardNumberController.text,
                            nameOfCard: nameOfCardController.text,
                            periodCard: periodController.text,
                            userId: NewPayConstants.user.uid,
                          )
                          .then(
                            (value) => Navigator.pop(context),
                          );
                    } else {
                      Helper.showTopErrorSnackbar(
                        context: context,
                        error: 'You can add only five cards',
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
