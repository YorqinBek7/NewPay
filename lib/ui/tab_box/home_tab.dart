import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pay/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:new_pay/ui/tab_box/cards_screen/cards_screen.dart';
import 'package:new_pay/ui/tab_box/home_screen/home_screen.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:new_pay/utils/styles.dart';

class BottomNavBlocProvider extends StatelessWidget {
  const BottomNavBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBloc(),
      child: HomeTab(),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Helper.exitdialog(context),
      child: BlocBuilder<BottomNavBloc, int>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state,
              children: [
                HomeScreen(),
                CardsScreen(),
              ],
            ),
            bottomNavigationBar: AnimatedBottomNavigationBar.builder(
              activeIndex: state,
              gapLocation: GapLocation.center,
              onTap: (index) {
                BlocProvider.of<BottomNavBloc>(context)
                    .add(BottomNavManagerEvent(index: index));
              },
              itemCount: NewPayConstants.bottomNavModels.length,
              tabBuilder: (int index, bool isActive) {
                return Column(
                  children: [
                    Icon(
                      NewPayConstants.bottomNavModels[index].icon,
                      color: isActive
                          ? NewPayColors.C_7000FF
                          : NewPayColors.C_828282,
                    ),
                    Text(
                      NewPayConstants.bottomNavModels[index].label,
                      style: NewPayStyles.w500.copyWith(
                        color: isActive
                            ? NewPayColors.C_7000FF
                            : NewPayColors.C_828282,
                      ),
                    ),
                  ],
                );
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0)),
              onPressed: () => {},
              child: Icon(state == 1 ? Icons.add : Icons.send),
            ),
          );
        },
      ),
    );
  }
}
