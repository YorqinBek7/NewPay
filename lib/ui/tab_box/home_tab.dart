import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_pay/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:new_pay/ui/tab_box/cards_screen/cards_screen.dart';
import 'package:new_pay/ui/tab_box/home_screen/home_screen.dart';
import 'package:new_pay/ui/tab_box/stats_screen/stats_screen.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:new_pay/utils/icons.dart';
import 'package:new_pay/utils/styles.dart';

class BottomNavBlocProvider extends StatelessWidget {
  const BottomNavBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBloc(),
      child: const HomeTab(),
    );
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Helper.exitdialog(context),
      child: BlocBuilder<BottomNavBloc, int>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state,
              children: const [
                HomeScreen(),
                CardsScreen(),
                StatsScreen(),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      NewPayConstants.bottomNavModels[index].icon,
                      color: isActive
                          ? NewPayColors.C_7000FF
                          : NewPayColors.C_828282,
                      height: 24.0,
                      width: 24.0,
                    ),
                    Text(
                      NewPayConstants.bottomNavModels[index].label,
                      style: NewPayStyles.w400.copyWith(
                        color: isActive
                            ? NewPayColors.C_7000FF
                            : NewPayColors.C_828282,
                        fontSize: 12.0,
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
              onPressed: () => _callback(state),
              child: SvgPicture.asset(_iconChanger(state)),
            ),
          );
        },
      ),
    );
  }

  String _iconChanger(int state) {
    switch (state) {
      case 1:
        return NewPayIcons.add;
      case 2:
        return NewPayIcons.refresh;
      default:
        return NewPayIcons.sendWhite;
    }
  }

  Future _callback(int state) async {
    switch (state) {
      case 1:
        return Navigator.pushNamed(context, NewPayConstants.addCardScreen);
      case 2:
        return setState(() => print(state));
      default:
        return Navigator.pushNamed(context, NewPayConstants.sendMoneyScreen);
    }
  }
}
