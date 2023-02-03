import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pay/blocs/update_image/update_image_bloc.dart';
import 'package:new_pay/data/storage.dart';
import 'package:new_pay/ui/tab_box/home_screen/profile_screen/widgets/option_items.dart';
import 'package:new_pay/ui/tab_box/home_screen/profile_screen/widgets/select_photo_dialog.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/icons.dart';
import 'package:new_pay/utils/styles.dart';

class UpdateImage extends StatelessWidget {
  const UpdateImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateImageBloc(),
      child: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 90.0.w,
                height: 90.0.h,
                child: BlocBuilder<UpdateImageBloc, UpdateImageState>(
                  builder: (context, state) {
                    return Stack(
                      children: [
                        FirebaseAuth.instance.currentUser!.photoURL == null
                            ? Image.asset(
                                NewPayIcons.profilePhoto,
                                width: 80.0.w,
                                height: 80.0.h,
                                fit: BoxFit.cover,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100.0.r),
                                child: CachedNetworkImage(
                                  imageUrl: FirebaseAuth
                                      .instance.currentUser!.photoURL!,
                                  width: 80.0.w,
                                  height: 80.0.h,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                ),
                              ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () async => BlocProvider.value(
                                value: UpdateImageBloc(),
                                child: await selectPhotoDialog(context)),
                            child: Container(
                              padding: EdgeInsets.all(10.0.r),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: NewPayColors.C_7000FF,
                                border: Border.all(
                                  color: NewPayColors.white,
                                  width: 2.0.w,
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: NewPayColors.white,
                                size: 12.0.w,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10.0.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                FirebaseAuth.instance.currentUser!.displayName!,
                style: NewPayStyles.w600.copyWith(fontSize: 24.0.sp),
              ),
            ),
            SizedBox(
              height: 40.0.h,
            ),
            optionItems(
              context: context,
              icon: NewPayIcons.verify,
              onTap: () {},
              title: 'Update NM Information',
            ),
            optionItems(
              context: context,
              icon: NewPayIcons.shield,
              onTap: () {},
              title: 'Verify NewPay pay',
            ),
            const Divider(),
            optionItems(
              context: context,
              icon: NewPayIcons.bank,
              onTap: () {},
              title: 'Connection with bank',
            ),
            optionItems(
              context: context,
              icon: NewPayIcons.appSettings,
              onTap: () =>
                  Navigator.pushNamed(context, NewPayConstants.appSettings),
              title: 'Application settings',
            ),
            const Divider(),
            Container(
              margin: EdgeInsets.only(left: 16.0.w),
              child: Text(
                'SECURITY',
                style: NewPayStyles.w500.copyWith(color: NewPayColors.C_828282),
              ),
            ),
            optionItems(
              context: context,
              icon: NewPayIcons.lockCircle,
              title: 'Change PIN',
              onTap: () {},
            ),
            optionItems(
              context: context,
              icon: NewPayIcons.fingerScan,
              title: 'Touch ID',
              trailingIcon: Switch(
                value: false,
                onChanged: (value) => {},
              ),
              onTap: () {},
            ),
            optionItems(
              context: context,
              icon: NewPayIcons.headphone,
              title: 'Help & support',
              onTap: () {},
            ),
            SizedBox(
              height: 5.0.h,
            ),
            GestureDetector(
              onTap: () async {
                NewPayStorage.instance.setBool('isLogged', false);
                await FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(context,
                        NewPayConstants.loginScreen, (route) => false));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0.h),
                margin: EdgeInsets.symmetric(horizontal: 15.0.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0.r),
                  border: Border.all(
                    color: NewPayColors.white,
                    width: 2.0.w,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Log Out',
                    style: NewPayStyles.w600.copyWith(
                        fontSize: 16.0.sp, color: NewPayColors.C_F90000),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
