import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:new_pay/blocs/cards/cards_bloc.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:new_pay/utils/icons.dart';
import 'package:new_pay/utils/styles.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  int timer = 30;
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (v) {
      setState(() {
        timer--;
        if (timer == 0) v.cancel();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay with NFC'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              NewPayIcons.nfc,
              width: 230.0.w,
              height: 230.0.h,
            ),
            Text(
              'Session finished in 30 seconds',
              style: NewPayStyles.w500,
            ),
            SizedBox(
              height: 20.0.h,
            ),
            Text(timer > 10 ? '0:$timer' : '0:0$timer'),
            SizedBox(
              height: 40.0.h,
            ),
            BlocBuilder<CardsBloc, CardsState>(
              builder: (context, state) {
                if (state is CardsSuccessState) {
                  return SizedBox(
                    height: 104.0.h,
                    child: Swiper(
                      itemCount: state.cards.length,
                      loop: false,
                      itemBuilder: (context, index) => ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0.r)),
                        tileColor: NewPayColors.C_203354,
                        title: Text(
                          state.cards[index].cardName,
                          style: NewPayStyles.w500.copyWith(
                            color: NewPayColors.white,
                          ),
                        ),
                        subtitle: Text(
                          state.cards[index].cardNumber,
                          style: NewPayStyles.w400.copyWith(
                            color: NewPayColors.white,
                          ),
                        ),
                      ),
                      viewportFraction: 0.8,
                      scale: 0.9,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
