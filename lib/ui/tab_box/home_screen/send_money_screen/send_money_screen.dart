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
                await service.sendMoney('5000', '8600 1234 5678 9012'),
              },
              child: Text('Change moeny'),
            )
          ],
        ),
      ),
    );
  }
}
