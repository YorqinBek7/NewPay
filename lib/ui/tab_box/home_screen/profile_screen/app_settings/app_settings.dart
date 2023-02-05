import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:new_pay/blocs/language/language_bloc.dart';
import 'package:new_pay/data/storage.dart';
import 'package:new_pay/ui/tab_box/home_screen/profile_screen/app_settings/widget/theme_dialog.dart';
import 'package:new_pay/ui/tab_box/home_screen/profile_screen/widgets/option_items.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/icons.dart';
import 'package:new_pay/utils/styles.dart';

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('settings')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).cardColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          optionItems(
            context: context,
            icon: NewPayIcons.language,
            title: tr('change_language'),
            onTap: () => changeLanDialog(context),
          ),
          optionItems(
            icon: NewPayIcons.theme,
            title: tr('theme'),
            onTap: () => themeDialog(context),
            context: context,
          ),
          optionItems(
            context: context,
            icon: NewPayIcons.session,
            title: tr('session'),
            onTap: () {},
          ),
          optionItems(
            context: context,
            icon: NewPayIcons.public,
            title: tr('public_offer'),
            onTap: () {},
          ),
          optionItems(
            icon: NewPayIcons.aboutApp,
            title: tr('about_app'),
            onTap: () {},
            context: context,
          )
        ]),
      ),
    );
  }

  Future<dynamic> changeLanDialog(BuildContext context) {
    return showBarModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * .2,
        padding: EdgeInsets.all(10.0.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0.r),
            topRight: Radius.circular(10.0.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Language',
              style: NewPayStyles.w600.copyWith(fontSize: 19.0.sp),
            ),
            InkWell(
              onTap: () {
                context.setLocale(const Locale('en', 'EN'));
                NewPayStorage.instance.setString('lan', 'en');
                BlocProvider.of<LanguageBloc>(context)
                    .add(LanguageManagerEvent());
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.0.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0.r),
                  color: NewPayColors.C_C1C1C1,
                ),
                child:
                    Center(child: Text('🇺🇸 ENG', style: NewPayStyles.w600)),
              ),
            ),
            SizedBox(
              height: 10.0.h,
            ),
            InkWell(
              onTap: () {
                context.setLocale(const Locale('uz', 'UZ'));
                NewPayStorage.instance.setString('lan', 'uz');
                BlocProvider.of<LanguageBloc>(context)
                    .add(LanguageManagerEvent());
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.0.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0.r),
                  color: NewPayColors.C_C1C1C1,
                ),
                child:
                    Center(child: Text('🇺🇿 UZB', style: NewPayStyles.w600)),
              ),
            ),
            SizedBox(
              height: 10.0.h,
            ),
          ],
        ),
      ),
    );
  }
}
