import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:parksmart/views/homepage.dart';
import 'package:parksmart/views/ticket.dart';
import 'package:pay/pay.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:developer';
import 'package:parksmart/views/ticket.dart';

import 'package:parksmart/views/payment_successful.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  double calculateParkingCharge(String duration) {
    switch (duration) {
      case '1 Hour':
        return 20.0;
      case '2 Hours':
        return 30.0;
      case '3 Hours':
        return 40.0;
      case '4 Hours':
        return 50.0;
      default:
        return 0.0;
    }
  }
  
  final paymentItem = <PaymentItem>[];

  var _razorpay = Razorpay();
  @override
  void initState() {
    bool paymentready = false;
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    paymentItem.add(const PaymentItem(
      amount: "42",
      label: "Charge",
      status: PaymentItemStatus.final_price,
    ));
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    // final time = args?['time'] as String;
    final mall = args?['mall'] as String?;
    final time = args?['time'] as String?;
    final duration = args?['duration'] as String?;
    final license = args?['license'] as String?;


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        backgroundColor: Colors.black,
        title: const Text(
          "Confirm booking",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Lottie.asset("assets/park.json"),
               Card(
                color: Colors.white,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mall ?? '',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),

                        Text(
                          license ?? '',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ),
               Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Entering Time",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Text(
                            time ?? '',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Duration",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Text(
                            duration ?? '',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Parking Charge",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Text(
                            '₹ ${calculateParkingCharge(duration ?? '').toStringAsFixed(0)}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Grand Total",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          Text(
                            '₹ ${calculateParkingCharge(duration ?? '').toStringAsFixed(0)}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  collapsedBackgroundColor: Colors.white,
                  textColor: Colors.black,
                  backgroundColor: Colors.white,
                  title: const Text("Select Payment Methods"),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         const HomePage()));
                                },
                                icon: const Icon(Icons.done)),
                            border: const OutlineInputBorder(),
                            hintText: "Enter your UPI"),
                      ),
                    ),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Debit/Credit Cards",
                            style: TextStyle(fontSize: 15),
                          ),
                        )),

                    //***********Pay with Razor Pay *******************/

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        onPressed: () {
                          var options = {
                            'key': 'rzp_test_fTnbgugypdAT3m',
                            'amount':
                                40000, //in the smallest currency sub-unit.
                            'name': 'Park Smart',
                            'order_id':
                                'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
                            'description': 'Parking charge',
                            'timeout': 300, // in seconds
                            'prefill': {
                              'contact': '9123456789',
                              'email': 'gaurav.kumar@example.com'
                            }
                          };
                          _razorpay.open(options);
                        },
                        color: Colors.black,
                        height: 40,
                        minWidth: double.infinity,
                        child: const Text(
                          "Pay With Razor Pay",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    //********Google Pay ************** */
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GooglePayButton(
                        // ignore: deprecated_member_use
                        paymentConfigurationAsset: "gpay.json",
                        paymentItems: paymentItem,
                        onPaymentResult: (data) {
                          log(data as String);
                        },
                        width: double.infinity,
                        height: 50,
                        type: GooglePayButtonType.plain,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}