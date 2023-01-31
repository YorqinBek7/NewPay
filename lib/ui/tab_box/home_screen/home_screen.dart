import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_stack_widget/card_stack_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_pay/blocs/cards/cards_bloc.dart';
import 'package:new_pay/ui/tab_box/cards_screen/widgets/plastic_cards.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:new_pay/utils/icons.dart';
import 'package:new_pay/utils/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0,
        leading: GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, NewPayConstants.profileScreen),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: NewPayConstants.user.photoURL == null
                  ? Image.asset(
                      NewPayIcons.profilePhoto,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: NewPayConstants.user.photoURL!,
                      fit: BoxFit.cover,
                    )),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi ${NewPayConstants.user.displayName ?? ''}',
              style: NewPayStyles.w500.copyWith(fontSize: 14.0),
            ),
            Text(
              "Let's save your money",
              style: NewPayStyles.w700.copyWith(fontSize: 14.0),
            ),
          ],
        ),
        actions: [
          SvgPicture.asset(NewPayIcons.notification),
          SizedBox(
            width: 13.0,
          )
        ],
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: BlocBuilder<CardsBloc, CardsState>(
          builder: (context, state) {
            if (state is CardsSuccessState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your balance',
                    style: NewPayStyles.w500
                        .copyWith(color: NewPayColors.C_828282),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      Helper.currenyFormat(state.allSum),
                      style: NewPayStyles.w700.copyWith(
                        fontSize: 32.0,
                        color: NewPayColors.C_171D33,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    height: 26.0,
                  ),
                  Row(
                    children: [
                      _optionButtons(
                        icon: NewPayIcons.send,
                        onTap: () => Navigator.pushNamed(
                            context, NewPayConstants.sendMoneyScreen),
                        text: 'Send',
                      ),
                      SizedBox(
                        width: 47.0,
                      ),
                      _optionButtons(
                        icon: NewPayIcons.scan,
                        onTap: () => Navigator.pushNamed(
                            context, NewPayConstants.scannerScreen),
                        text: 'QR Code',
                      ),
                      SizedBox(
                        width: 47.0,
                      ),
                      _optionButtons(
                        icon: NewPayIcons.pay,
                        onTap: () {},
                        text: 'Pay',
                      ),
                      SizedBox(
                        width: 47.0,
                      ),
                      _optionButtons(
                        icon: NewPayIcons.more,
                        onTap: () {},
                        text: 'More',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
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
                              cardsGradient: state.cards[index].gradientColor,
                              sum: state.cards[index].sum,
                            ),
                          ),
                        )
                      : _noCardsView(context),
                ],
              );
            } else if (state is CardsErrorState) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  GestureDetector _noCardsView(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, NewPayConstants.addCardScreen),
      child: Container(
        height: 188.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: NewPayColors.white,
          boxShadow: [
            BoxShadow(
                color: NewPayColors.C_828282.withOpacity(.15), blurRadius: 10.0)
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                  NewPayColors.C_7000FF,
                )),
                onPressed: () =>
                    Navigator.pushNamed(context, NewPayConstants.addCardScreen),
                icon: Icon(
                  Icons.add,
                  color: NewPayColors.white,
                ),
              ),
              Text(
                'Add bank card',
                style: NewPayStyles.w400.copyWith(
                  fontSize: 12.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _optionButtons({
    required VoidCallback onTap,
    required String icon,
    required String text,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: NewPayColors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20.0,
                    color: NewPayColors.black.withOpacity(.1),
                  )
                ]),
            child: SvgPicture.asset(icon),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            text,
            style: NewPayStyles.w700.copyWith(
              fontSize: 14.0,
              color: NewPayColors.C_7000FF,
            ),
          )
        ],
      ),
    );
  }
}
