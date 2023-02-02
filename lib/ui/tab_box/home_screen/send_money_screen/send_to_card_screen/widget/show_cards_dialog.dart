import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:new_pay/blocs/cards/cards_bloc.dart';
import 'package:new_pay/blocs/select_cards_to_send/select_cards_to_send_bloc.dart';
import 'package:new_pay/models/mini_card_with_pic.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/icons.dart';

Future<dynamic> showCardsDialog(BuildContext _) {
  return showBarModalBottomSheet(
    context: _,
    builder: (context) => BlocBuilder<CardsBloc, CardsState>(
      builder: (context, state) {
        if (state is CardsSuccessState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              state.cards.length,
              (index) => ListTile(
                onTap: () {
                  NewPayConstants.miniCard = MiniCard(
                    number: state.cards[index].cardNumber,
                    sum: state.cards[index].sum,
                    image: NewPayIcons.humo,
                  );
                  BlocProvider.of<SelectCardsBloc>(_)
                      .add(SelectCardsManagerEvent(index: index));
                  Navigator.pop(context);
                },
                leading: Image.asset(
                  NewPayIcons.humo,
                ),
                trailing: BlocProvider.of<SelectCardsBloc>(_).index == index
                    ? const Icon(
                        Icons.check,
                        color: NewPayColors.C_FF6770,
                      )
                    : null,
                title: Text(state.cards[index].cardNumber),
                subtitle: Text(state.cards[index].sum),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    ),
  );
}
