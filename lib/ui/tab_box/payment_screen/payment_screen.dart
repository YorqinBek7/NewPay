import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_pay/blocs/language/language_bloc.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(tr('payments')),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: List.generate(
                NewPayConstants.payments.length,
                (index) => ListTile(
                  onTap: () => {},
                  leading: Container(
                    padding: EdgeInsets.all(10.0.r),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: NewPayColors.C_C1C1C1,
                    ),
                    child: SvgPicture.asset(
                      NewPayConstants.payments[index].icon,
                      width: 20.0.w,
                      height: 22.0.h,
                    ),
                  ),
                  title: Text(
                    NewPayConstants.payments[index].title,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 14.0.sp),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
