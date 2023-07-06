import 'package:parksmart/models/auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool  changebutton = false;
  bool seepwd = true;
  final _formkey = GlobalKey<FormState>();


  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthController authController=Get.put(AuthController());

  moveToLogin(BuildContext context)async{
    if(_formkey.currentState!.validate()) {
      setState(() {
        changebutton = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      await  authController.signUp(name.text,username.text, password.text);
      // Navigator.push(
      //context, MaterialPageRoute(builder: (context) => LoginPage()),);
      setState(() {
        changebutton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: SingleChildScrollView(
          //----------- Top Image code ------------------------
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Image.asset("assets/Images/logo3.png",fit: BoxFit.cover,),
                const SizedBox(
                  height: 20.0,
                ),
                // --------------- Sign Up ------------------------------
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text('SIGN UP',style: TextStyle(fontFamily:'San Francisco', fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // -----------------TextFormFiled For Name ,Username and Password------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 32),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder( // Customize the focused border here
                              borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                color: Colors.black54, // Change the border color here
                              ),
                            ),
                            labelText: 'Name',
                            hintText: 'Enter your name'
                        ),
                        validator: (value){
                          if (value!.isEmpty) {
                            return "Name cannot be empty.";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const  SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: username,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            border:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            labelText: 'Email',
                            hintText: 'Enter Your Email'
                        ),
                        validator: (value){
                          if (value!.isEmpty){
                            return "Email cannot be Empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: password,
                        obscureText: seepwd,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Icon( seepwd ? Icons.visibility_off : Icons.visibility),
                              //icon:seepwd== false ?Icon(Icons.remove_red_eye_outlined ): Icon(Icons.remove_red_eye) ,
                              onPressed: (){
                                setState(() {
                                  seepwd=!seepwd;
                                });
                              },
                            ),
                            border:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            labelText: 'Password',
                            hintText: 'Enter Your Password'
                        ),
                        validator: (value){
                          if (value!.isEmpty){
                            return "Password cannot be Empty";
                          }
                          else if(value.length < 6){
                            return "Password length should be atleast 6";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      // ------------ Sign Up Container Button -----------
                      InkWell(
                        onTap: () => moveToLogin(context),
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          height: 50,
                          width: changebutton ? 50 : 150,
                          alignment: Alignment.center,
                          child: changebutton ? Icon(Icons.done,color: Colors.white,) :Text("Sign Up",style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,),),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(changebutton ? 50: 8)
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
