import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentSuccessfull extends StatelessWidget {
  const PaymentSuccessfull({super.key});

  @override
  Widget build(BuildContext context) {
     Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset("assets/car_loading.json"),
          const SizedBox(height: 10),
          const Text(
            "Payment Successfull",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      )),
    );
    return const Text('Redirecting to homepage..');
  }
}