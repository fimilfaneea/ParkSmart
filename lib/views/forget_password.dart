import 'package:firebase_auth/firebase_auth.dart';
import 'package:parksmart/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/auth_provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  bool changebutton = false;
  final _formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  //AuthController authController=Get.put(AuthController());




  //Function to move to login page
  moveTologinpage(BuildContext context)async{
    if(_formkey.currentState!.validate()){
      setState(() {
        changebutton = true;
      });
      await Future.delayed(Duration(seconds: 6));
      Navigator.of(context).pop();
      setState(() {
        changebutton = false;
      });
    }
  }

  forgotPass(String email) async{
    AuthController authController = AuthController();
    await authController.forgotPassword(email);
    Get.snackbar('Forgot password', 'Password reset link has been sent, please check your email',
      backgroundColor: Colors.white,);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Image.asset("assets/Images/logo3.png",fit: BoxFit.cover,),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Forget Password",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Enter Your Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            labelText: "Email"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      InkWell(
                        onTap: () {
                          String emailStr = email.toString();
                          forgotPass(emailStr);
                          moveTologinpage(context);
                          },
                        child: AnimatedContainer(duration: Duration(seconds: 1),
                          height: 50,
                          width: changebutton?50:150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular( changebutton ?50:8)
                          ),
                          child: changebutton ?Icon(Icons.done):Text("Confirm",style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white
                          ),),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
