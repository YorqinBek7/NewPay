import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_pay/data/service.dart';

class SendMoneyScreen extends StatelessWidget {
  SendMoneyScreen({super.key});
  CardsService service = CardsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async => {
                await service.sendMoney(
                  sum: '5000',
                  card: '6588 9900 8855 5223',
                  senderId: FirebaseAuth.instance.currentUser!.uid,
                  senderCard: '5999 8885 6223 3695',
                ),
              },
              child: Text('Change moeny'),
            )
          ],
        ),
      ),
    );
  }
}
