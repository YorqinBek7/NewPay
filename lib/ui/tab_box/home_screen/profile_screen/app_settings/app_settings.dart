import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:new_pay/blocs/theme/theme_bloc.dart';
import 'package:new_pay/ui/tab_box/home_screen/profile_screen/widgets/option_items.dart';
import 'package:new_pay/utils/icons.dart';
import 'package:new_pay/utils/styles.dart';

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          optionItems(
            context: context,
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
                  topLeft: Radius.circular(10.0.r),
                  topRight: Radius.circular(10.0.r),
                ),
              ),
              context: context,
              builder: (context) => SizedBox(
                height: MediaQuery.of(context).size.height * .3,
                child: BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          onTap: () => BlocProvider.of<ThemeBloc>(context)
                              .add(ThemeManagerEvent(themeState: 0)),
                          leading: const Icon(Icons.edit_note_sharp),
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
                          leading: const Icon(Icons.dark_mode),
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
                          leading: const Icon(Icons.light_mode),
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
            context: context,
          ),
          optionItems(
            context: context,
            icon: NewPayIcons.session,
            title: 'Sessions',
            onTap: () {},
          ),
          optionItems(
            context: context,
            icon: NewPayIcons.public,
            title: 'Public offer',
            onTap: () {},
          ),
          optionItems(
            icon: NewPayIcons.aboutApp,
            title: 'About app',
            onTap: () {},
            context: context,
          )
        ]),
      ),
    );
  }
}
