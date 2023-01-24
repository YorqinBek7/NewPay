import 'package:flutter/material.dart';
import 'package:new_pay/ui/tab_box/home_screen/profile_screen/widgets/option_items.dart';
import 'package:new_pay/utils/icons.dart';

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
            onTap: () {},
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
