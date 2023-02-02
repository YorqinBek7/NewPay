import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_stack_widget/card_stack_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_pay/blocs/cards/cards_bloc.dart';
import 'package:new_pay/blocs/update_image/update_image_bloc.dart';
import 'package:new_pay/models/mini_card_with_pic.dart';
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
        title: Row(
          children: [
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, NewPayConstants.profileScreen),
              child: BlocBuilder<UpdateImageBloc, UpdateImageState>(
                builder: (context, state) {
                  return NewPayConstants.user.photoURL == null
                      ? Image.asset(
                          NewPayIcons.profilePhoto,
                          fit: BoxFit.cover,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(30.0.r),
                          child: CachedNetworkImage(
                            imageUrl: NewPayConstants.user.photoURL!,
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
                  'Hi, ${NewPayConstants.user.displayName ?? ''}',
                  style: NewPayStyles.w500.copyWith(fontSize: 14.0.sp),
                ),
                Text(
                  "Let's save your money",
                  style: NewPayStyles.w700.copyWith(fontSize: 14.0.sp),
                ),
              ],
            ),
          ],
        ),
        actions: [
          SvgPicture.asset(NewPayIcons.notification),
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
              NewPayConstants.miniCard = MiniCard(
                number: state.cards[0].cardNumber,
                sum: state.cards[0].sum,
                image: NewPayIcons.humo,
              );
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
                        fontSize: 32.0.sp,
                        color: NewPayColors.C_171D33,
                      ),
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
                        onTap: () => Navigator.pushNamed(
                            context, NewPayConstants.sendMoneyScreen),
                        text: 'Send',
                      ),
                      _optionButtons(
                        icon: NewPayIcons.scan,
                        onTap: () => Navigator.pushNamed(
                            context, NewPayConstants.scannerScreen),
                        text: 'QR Code',
                      ),
                      _optionButtons(
                        icon: NewPayIcons.pay,
                        onTap: () {},
                        text: 'Pay',
                      ),
                      _optionButtons(
                        icon: NewPayIcons.more,
                        onTap: () {},
                        text: 'More',
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
              return const Center(
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
          borderRadius: BorderRadius.circular(10.0.r),
          color: NewPayColors.white,
          boxShadow: [
            BoxShadow(
                color: NewPayColors.C_828282.withOpacity(.15),
                blurRadius: 10.0.r)
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
                icon: const Icon(
                  Icons.add,
                  color: NewPayColors.white,
                ),
              ),
              Text(
                'Add bank card',
                style: NewPayStyles.w400.copyWith(
                  fontSize: 12.0.sp,
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
            style: NewPayStyles.w700.copyWith(
              fontSize: 14.0.sp,
              color: NewPayColors.C_7000FF,
            ),
          )
        ],
      ),
    );
  }
}
