import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:new_pay/blocs/theme/theme_bloc.dart';
import 'package:new_pay/data/storage.dart';
import 'package:new_pay/utils/colors.dart';

Future<dynamic> themeDialog(BuildContext context) {
  return showMaterialModalBottomSheet(
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
                onTap: () {
                  NewPayStorage.instance.setInt('themeState', 0);
                  BlocProvider.of<ThemeBloc>(context)
                      .add(ThemeManagerEvent(themeState: 0));
                },
                leading: const Icon(Icons.edit_note_sharp),
                title: Text(
                  tr('system_mode'),
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: NewPayColors.black),
                ),
                trailing: Icon(
                  state is ThemeAutoState
                      ? Icons.circle
                      : Icons.circle_outlined,
                ),
              ),
              ListTile(
                onTap: () {
                  NewPayStorage.instance.setInt('themeState', 1);
                  BlocProvider.of<ThemeBloc>(context)
                      .add(ThemeManagerEvent(themeState: 1));
                },
                leading: const Icon(Icons.dark_mode),
                title: Text(tr('dark_mode'),
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: NewPayColors.black)),
                trailing: Icon(
                  state is ThemeDarkState
                      ? Icons.circle
                      : Icons.circle_outlined,
                ),
              ),
              ListTile(
                onTap: () {
                  NewPayStorage.instance.setInt('themeState', 2);
                  BlocProvider.of<ThemeBloc>(context)
                      .add(ThemeManagerEvent(themeState: 2));
                },
                leading: const Icon(Icons.light_mode),
                title: Text(tr('light_mode'),
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: NewPayColors.black)),
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
  );
}
