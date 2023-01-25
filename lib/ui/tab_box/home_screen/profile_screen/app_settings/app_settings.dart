import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:new_pay/blocs/theme/theme_bloc.dart';
import 'package:new_pay/ui/tab_box/home_screen/profile_screen/widgets/option_items.dart';
import 'package:new_pay/utils/icons.dart';
import 'package:new_pay/utils/styles.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          optionItems(
            icon: NewPayIcons.language,
            title: 'Change Language',
            onTap: () {},
          ),
          optionItems(
            icon: NewPayIcons.theme,
            title: 'Theme',
            onTap: () => showMaterialModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              context: context,
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height * .3,
                child: BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          onTap: () => BlocProvider.of<ThemeBloc>(context)
                              .add(ThemeManagerEvent(themeState: 0)),
                          leading: Icon(Icons.edit_note_sharp),
                          title: Text(
                            'Auto mode',
                            style: NewPayStyles.w600,
                          ),
                          trailing: Icon(
                            state is ThemeAutoState
                                ? Icons.circle
                                : Icons.circle_outlined,
                          ),
                        ),
                        ListTile(
                          onTap: () => BlocProvider.of<ThemeBloc>(context)
                              .add(ThemeManagerEvent(themeState: 1)),
                          leading: Icon(Icons.dark_mode),
                          title: Text(
                            'Dark',
                            style: NewPayStyles.w600,
                          ),
                          trailing: Icon(
                            state is ThemeDarkState
                                ? Icons.circle
                                : Icons.circle_outlined,
                          ),
                        ),
                        ListTile(
                          onTap: () => BlocProvider.of<ThemeBloc>(context)
                              .add(ThemeManagerEvent(themeState: 2)),
                          leading: Icon(Icons.light_mode),
                          title: Text(
                            'Light mode',
                            style: NewPayStyles.w600,
                          ),
                          trailing: Icon(
                            state is ThemeLightState
                                ? Icons.circle
                                : Icons.circle_outlined,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          optionItems(
            icon: NewPayIcons.session,
            title: 'Sessions',
            onTap: () {},
          ),
          optionItems(
            icon: NewPayIcons.public,
            title: 'Public offer',
            onTap: () {},
          ),
          optionItems(
            icon: NewPayIcons.aboutApp,
            title: 'About app',
            onTap: () {},
          )
        ]),
      ),
    );
  }
}
