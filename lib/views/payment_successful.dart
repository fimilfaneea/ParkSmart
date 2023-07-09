import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:parksmart/views/homepage.dart';

class PaymentSuccessfull extends StatelessWidget {
  const PaymentSuccessfull({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ),
          const SizedBox(height: 80),
          Card(
            color: Colors.blue,
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: const Text("Tap here to get the QR code"),
            ),
          )
        ],
      )),
    );
  }
}
