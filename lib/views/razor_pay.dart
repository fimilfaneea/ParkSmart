import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPay extends StatefulWidget {
  const RazorPay({super.key});

  @override
  State<RazorPay> createState() => _RazorPayState();

  void on(String event_payment_success,
      void Function(PaymentSuccessResponse response) handlePaymentSuccess) {}
}

class _RazorPayState extends State<RazorPay> {
  RazorPay _razorpay = RazorPay();

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        _handlePaymentError as void Function(PaymentSuccessResponse response));
    _razorpay.on(
        Razorpay.EVENT_EXTERNAL_WALLET,
        _handleExternalWallet as void Function(
            PaymentSuccessResponse response));
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
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
