import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:new_pay/blocs/cards/cards_bloc.dart';
import 'package:new_pay/blocs/monitoring/monitoring_bloc.dart';
import 'package:new_pay/blocs/select_cards_to_send/select_cards_to_send_bloc.dart';
import 'package:new_pay/data/service.dart';
import 'package:new_pay/ui/tab_box/home_screen/send_money_screen/send_to_card_screen/widget/show_cards_dialog.dart';
import 'package:new_pay/ui/tab_box/home_screen/send_money_screen/send_to_card_screen/widget/show_check_dialog.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:new_pay/utils/icons.dart';
import 'package:new_pay/utils/input_formatters.dart';
import 'package:new_pay/widgets/custom_fields.dart';
import 'package:new_pay/widgets/global_button.dart';

class SendToCardScreen extends StatelessWidget {
  const SendToCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectCardsBloc(),
      child: const SendToCardView(),
    );
  }
}

class SendToCardView extends StatefulWidget {
  const SendToCardView({super.key});

  @override
  State<SendToCardView> createState() => _SendToCardViewState();
}

class _SendToCardViewState extends State<SendToCardView> {
  final TextEditingController cardController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String cardType = 'Unknown';
  CardsService service = CardsService();
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr('transfers')),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).cardColor),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25.0.h,
                      ),
                      Container(
                        height: 104.0.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0.w, vertical: 11.0.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0.r),
                          color: NewPayColors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr('sender'),
                              style: Theme.of(context).textTheme.headline5!,
                            ),
                            SizedBox(
                              height: 7.0.h,
                            ),
                            BlocBuilder<SelectCardsBloc, SelectCardsState>(
                              builder: (context, state) {
                                return BlocBuilder<CardsBloc, CardsState>(
                                  builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () async => BlocProvider.value(
                                        value: SelectCardsBloc(),
                                        child: await showCardsDialog(context),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            NewPayConstants.miniCard!.image,
                                            width: 48.0.w,
                                            height: 48.0.h,
                                          ),
                                          SizedBox(
                                            width: 10.0.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                NewPayConstants
                                                    .miniCard!.number,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .copyWith(
                                                        color:
                                                            NewPayColors.black),
                                              ),
                                              Text(
                                                Helper.currenyFormat(
                                                    NewPayConstants
                                                        .miniCard!.sum),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4!
                                                    .copyWith(
                                                        fontSize: 16.0.sp,
                                                        color:
                                                            NewPayColors.black),
                                              )
                                            ],
                                          ),
                                          const Expanded(child: Text(' ')),
                                          const Icon(
                                            Icons.arrow_downward_outlined,
                                            color: NewPayColors.C_C1C1C1,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 22.0.h,
                      ),
                      Container(
                        height: 134.0.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0.w, vertical: 11.0.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0.r),
                          color: NewPayColors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Receiver',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: NewPayColors.black),
                            ),
                            SizedBox(
                              height: 7.0.h,
                            ),
                            CustomFields(
                              onChanged: (v) {
                                setState(() {
                                  if (v.length > 3) {
                                    String cardChecker = v.substring(0, 4);
                                    switch (cardChecker) {
                                      case '8600':
                                        cardType = 'UzCard';
                                        break;
                                      case '9860':
                                        cardType = 'Humo';
                                        break;
                                      default:
                                        cardType = 'Unknown';
                                    }
                                    if (v[0] == '5') {
                                      cardType = 'MasterCard';
                                    } else if (v[0] == '3') {
                                      cardType = 'Visa';
                                    }
                                  } else {
                                    cardType = 'Unknown';
                                  }
                                });
                              },
                              controller: cardController,
                              labelText: tr('enter_card_number'),
                              inputType: TextInputType.number,
                              formatter: CardNumberInputFormatter(),
                              prefixIcon: getCardImage(),
                              suffixIcon: NewPayIcons.card,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0.h,
                      ),
                      Text(
                        tr('transfer_amount'),
                        style: Theme.of(context).textTheme.headline5!,
                      ),
                      CustomFields(
                        onChanged: (v) {},
                        controller: amountController,
                        labelText: tr('enter_amount'),
                        inputType: TextInputType.number,
                        formatter: EnterAmountFormatter(),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              GlobalButton(
                buttonText: tr('send'),
                backgroundColor: Theme.of(context).cardColor,
                onTap: () async {
                  if (cardController.text.isEmpty ||
                      amountController.text.isEmpty) {
                    Helper.showCustomErrorSnackbar(
                        context, tr('please_fill_all_fields'));
                    return;
                  }
                  if (double.parse(amountController.text) >
                      double.parse(NewPayConstants.miniCard!.sum)) {
                    Helper.showCustomErrorSnackbar(context, tr('not_money'));
                    return;
                  }
                  bool hasCard =
                      await service.checkCard(cardController.text.trim());
                  if (hasCard) {
                    if (isTapped) return;
                    isTapped = true;
                    await service
                        .sendMoneyToService(
                      sum: amountController.text,
                      senderId: FirebaseAuth.instance.currentUser!.uid,
                      senderCard: NewPayConstants.miniCard!.number,
                      senderName:
                          FirebaseAuth.instance.currentUser!.displayName!,
                      time: DateFormat.yMMMEd().format(DateTime.now()),
                      toCard: false,
                    )
                        .then((value) async {
                      BlocProvider.of<MonitoringBloc>(context).add(
                        MonitoringManagerEvent(
                          userId: FirebaseAuth.instance.currentUser!.uid,
                        ),
                      );
                      await showCheckDialog(context, cardController.text.trim(),
                              amountController.text.trim())
                          .then((value) => isTapped = false);
                    });
                  } else {
                    Helper.showTopErrorSnackbar(
                        context: context, error: tr('card_not_found'));
                  }
                },
              ),
              SizedBox(
                height: 10.0.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  String getCardImage() {
    switch (cardType) {
      case 'Unknown':
        return NewPayIcons.unknownCard;
      case 'MasterCard':
        return NewPayIcons.masterCard;
      case 'UzCard':
        return NewPayIcons.uzcard;
      case 'Visa':
        return NewPayIcons.visa;
      default:
        return NewPayIcons.humo;
    }
  }
}
