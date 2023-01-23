import 'package:flutter/material.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/styles.dart';
import 'package:new_pay/widgets/global_button.dart';

class VerifiedScreen extends StatefulWidget {
  const VerifiedScreen({super.key});

  @override
  State<VerifiedScreen> createState() => _VerifiedScreenState();
}

class _VerifiedScreenState extends State<VerifiedScreen> {
  bool istouchIdOn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 90.0,
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: NewPayColors.C_7000FF.withOpacity(.5),
                  ),
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 29.0,
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: NewPayColors.white,
                  ),
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 50.0,
                child: Icon(
                  Icons.check_outlined,
                  color: NewPayColors.C_7000FF,
                  size: 32.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 32.0,
          ),
          Text(
            'Your account created',
            style: NewPayStyles.w500.copyWith(fontSize: 24.0),
            textAlign: TextAlign.center,
          ),
          Text(
            'Now you can use all the features. Welcome on board',
            style: NewPayStyles.w500.copyWith(fontSize: 14.0),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          ListTile(
            title: Text('Allow touch ID'),
            subtitle: Text('Use Touch ID to entr into the app'),
            trailing: Switch(
              onChanged: (value) => setState(() => istouchIdOn = !istouchIdOn),
              value: istouchIdOn,
            ),
          ),
          GlobalButton(
            buttonText: 'Start',
            backgroundColor: NewPayColors.black,
            onTap: () => Navigator.pushReplacementNamed(
                context, NewPayConstants.homeTab),
          ),
        ],
      ),
    );
  }
}
