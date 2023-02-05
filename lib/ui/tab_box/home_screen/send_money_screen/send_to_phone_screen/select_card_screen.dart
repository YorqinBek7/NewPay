import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:new_pay/blocs/cards/cards_bloc.dart';
import 'package:new_pay/blocs/monitoring/monitoring_bloc.dart';
import 'package:new_pay/blocs/select_cards_to_send/select_cards_to_send_bloc.dart';
import 'package:new_pay/data/service.dart';
import 'package:new_pay/ui/tab_box/home_screen/send_money_screen/send_to_card_screen/widget/show_cards_dialog.dart';
import 'package:new_pay/ui/tab_box/home_screen/send_money_screen/send_to_card_screen/widget/show_check_dialog.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:new_pay/utils/input_formatters.dart';
import 'package:new_pay/widgets/custom_fields.dart';
import 'package:new_pay/widgets/global_button.dart';

class SelectCardScreen extends StatelessWidget {
  const SelectCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SelectCardsBloc(),
      child: SelectCardScreenView(),
    );
  }
}

class SelectCardScreenView extends StatelessWidget {
  SelectCardScreenView({super.key});
  final TextEditingController amountController = TextEditingController();
  final CardsService service = CardsService();
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).cardColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Transfers'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select card',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontSize: 11.0.sp),
            ),
            SizedBox(
              height: 10.0.h,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                NewPayConstants.miniCard!.number,
                                style: Theme.of(context).textTheme.headline5!,
                              ),
                              Text(
                                Helper.currenyFormat(
                                    NewPayConstants.miniCard!.sum),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(fontSize: 16.0.sp),
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
            SizedBox(
              height: 40.0.h,
            ),
            CustomFields(
              onChanged: (v) {},
              controller: amountController,
              labelText: 'Enter amount',
              inputType: TextInputType.number,
              formatter: EnterAmountFormatter(),
            ),
            GlobalButton(
                buttonText: 'Send',
                backgroundColor: Theme.of(context).cardColor,
                onTap: () async {
                  if (amountController.text.isEmpty) {
                    Helper.showCustomErrorSnackbar(
                        context, 'Please enter amount');
                    return;
                  }
                  if (double.parse(amountController.text) >
                      double.parse(NewPayConstants.miniCard!.sum)) {
                    Helper.showCustomErrorSnackbar(context, 'Not enough money');
                    return;
                  }
                  if (isTapped) return;
                  isTapped = true;
                  await service
                      .sendMoneyToService(
                    sum: amountController.text,
                    senderId: FirebaseAuth.instance.currentUser!.uid,
                    senderCard: NewPayConstants.miniCard!.number,
                    senderName: FirebaseAuth.instance.currentUser!.displayName!,
                    time: DateFormat.yMMMEd().format(DateTime.now()),
                    toCard: false,
                  )
                      .then((value) async {
                    BlocProvider.of<MonitoringBloc>(context).add(
                      MonitoringManagerEvent(
                        userId: FirebaseAuth.instance.currentUser!.uid,
                      ),
                    );
                    await showCheckDialog(
                            context,
                            NewPayConstants.miniCard!.number,
                            amountController.text.trim())
                        .then((value) => isTapped = false);
                  });
                })
          ],
        ),
      ),
    );
  }
}
