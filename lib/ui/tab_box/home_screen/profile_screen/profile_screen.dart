import 'package:flutter/material.dart';
import 'package:new_pay/ui/tab_box/home_screen/profile_screen/widgets/option_items.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/icons.dart';
import 'package:new_pay/utils/styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 90.0,
                height: 90.0,
                child: Stack(
                  children: [
                    Image.asset(
                      NewPayIcons.profilePhoto,
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () => {},
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: NewPayColors.C_7000FF,
                            border: Border.all(
                              color: NewPayColors.white,
                              width: 2.0,
                            ),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: NewPayColors.white,
                            size: 12.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'YorqinBek Yuldashev',
                style: NewPayStyles.w600.copyWith(fontSize: 24.0),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            optionItems(
              icon: NewPayIcons.verify,
              onTap: () {},
              title: 'Update NM Information',
            ),
            optionItems(
              icon: NewPayIcons.shield,
              onTap: () {},
              title: 'Verify NewPay pay',
            ),
            Divider(),
            optionItems(
              icon: NewPayIcons.bank,
              onTap: () {},
              title: 'Connection with bank',
            ),
            optionItems(
              icon: NewPayIcons.appSettings,
              onTap: () =>
                  Navigator.pushNamed(context, NewPayConstants.appSettings),
              title: 'Application settings',
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(left: 16.0),
              child: Text(
                'SECURITY',
                style: NewPayStyles.w500.copyWith(color: NewPayColors.C_828282),
              ),
            ),
            optionItems(
              icon: NewPayIcons.lockCircle,
              title: 'Change PIN',
              onTap: () {},
            ),
            optionItems(
              icon: NewPayIcons.fingerScan,
              title: 'Touch ID',
              trailingIcon: Switch(
                value: false,
                onChanged: (value) => {},
              ),
              onTap: () {},
            ),
            optionItems(
              icon: NewPayIcons.headphone,
              title: 'Help & support',
              onTap: () {},
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: NewPayColors.white,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: Text(
                  'Log Out',
                  style: NewPayStyles.w600
                      .copyWith(fontSize: 16.0, color: NewPayColors.C_F90000),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
