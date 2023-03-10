import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_stack_widget/card_stack_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_pay/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:new_pay/blocs/cards/cards_bloc.dart';
import 'package:new_pay/blocs/language/language_bloc.dart';
import 'package:new_pay/blocs/update_image/update_image_bloc.dart';
import 'package:new_pay/models/mini_card_with_pic.dart';
import 'package:new_pay/ui/tab_box/cards_screen/widgets/plastic_cards.dart';
import 'package:new_pay/ui/tab_box/home_screen/widget/no_cards_widget.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:new_pay/utils/icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, NewPayConstants.profileScreen),
                  child: BlocBuilder<UpdateImageBloc, UpdateImageState>(
                    builder: (context, state) {
                      return FirebaseAuth.instance.currentUser!.photoURL == null
                          ? Image.asset(
                              NewPayIcons.profilePhoto,
                              width: 33.05.w,
                              height: 33.05.h,
                              fit: BoxFit.cover,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(30.0.r),
                              child: CachedNetworkImage(
                                imageUrl: FirebaseAuth
                                    .instance.currentUser!.photoURL!,
                                width: 33.05.w,
                                height: 33.05.h,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                              ),
                            );
                    },
                  ),
                ),
                SizedBox(
                  width: 8.0.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${tr('hi')}, ${FirebaseAuth.instance.currentUser!.displayName ?? ''}',
                        style: Theme.of(context).textTheme.headline4!),
                    Text(
                      tr('save_your_money'),
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontSize: 14.0.sp),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, NewPayConstants.notifScreen),
                child: SvgPicture.asset(
                  NewPayIcons.notification,
                  color: Theme.of(context).cardColor,
                ),
              ),
              SizedBox(
                width: 13.0.w,
              )
            ],
            centerTitle: false,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: BlocBuilder<CardsBloc, CardsState>(
              builder: (context, state) {
                if (state is CardsSuccessState) {
                  if (state.cards.isNotEmpty) {
                    NewPayConstants.miniCard = MiniCard(
                      number: state.cards[0].cardNumber,
                      sum: state.cards[0].sum,
                      image: NewPayIcons.humo,
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('your_balance'),
                          style: Theme.of(context).textTheme.headline4!),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          Helper.currenyFormat(state.allSum),
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(fontSize: 32.0.sp),
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        height: 26.0.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _optionButtons(
                            icon: NewPayIcons.send,
                            onTap: () {
                              if (state.cards.isEmpty) {
                                Navigator.pushNamed(
                                    context, NewPayConstants.addCardScreen);
                              } else {
                                Navigator.pushNamed(
                                    context, NewPayConstants.sendMoneyScreen);
                              }
                            },
                            text: tr('send'),
                            context: context,
                          ),
                          _optionButtons(
                            icon: NewPayIcons.scan,
                            onTap: () {
                              if (state.cards.isEmpty) {
                                Navigator.pushNamed(
                                    context, NewPayConstants.addCardScreen);
                              } else {
                                Navigator.pushNamed(
                                    context, NewPayConstants.scannerScreen);
                              }
                            },
                            text: tr('qr_code'),
                            context: context,
                          ),
                          _optionButtons(
                            icon: NewPayIcons.pay,
                            onTap: () {
                              if (state.cards.isEmpty) {
                                Navigator.pushNamed(
                                    context, NewPayConstants.addCardScreen);
                              } else {
                                Navigator.pushNamed(
                                    context, NewPayConstants.payScreen);
                              }
                            },
                            text: tr('pay'),
                            context: context,
                          ),
                          _optionButtons(
                            icon: NewPayIcons.more,
                            onTap: () {
                              if (state.cards.isEmpty) {
                                Navigator.pushNamed(
                                    context, NewPayConstants.addCardScreen);
                              } else {
                                BlocProvider.of<BottomNavBloc>(context)
                                    .add(BottomNavManagerEvent(index: 3));
                              }
                            },
                            text: tr('payments'),
                            context: context,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0.h,
                      ),
                      state.cards.isNotEmpty
                          ? Expanded(
                              child: CardStackWidget.builder(
                                swipeOrientation: CardOrientation.down,
                                count: state.cards.length,
                                builder: (index) => plasticCards(
                                  context,
                                  cardName: state.cards[index].cardName,
                                  cardNumber: state.cards[index].cardNumber,
                                  cardPeriod: state.cards[index].cardPeriod,
                                  cardStatus: state.cards[index].cardStatus,
                                  cardType: state.cards[index].typeCard,
                                  cardsGradient:
                                      state.cards[index].gradientColor,
                                  sum: state.cards[index].sum,
                                ),
                              ),
                            )
                          : noCardsView(context),
                    ],
                  );
                } else if (state is CardsErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  GestureDetector _optionButtons(
      {required VoidCallback onTap,
      required String icon,
      required String text,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(15.0.r),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0.r),
                color: NewPayColors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20.0,
                    color: NewPayColors.black.withOpacity(.1),
                  )
                ]),
            child: SvgPicture.asset(
              icon,
              height: 20.0.h,
              width: 20.0.w,
            ),
          ),
          SizedBox(
            height: 10.0.h,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  fontSize: 14.0.sp,
                  color: NewPayColors.C_7000FF,
                ),
          )
        ],
      ),
    );
  }
}
