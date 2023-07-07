import 'package:parksmart/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dropdown_button2/dropdown_button2.dart';



class Add extends StatefulWidget {
    const Add({
    Key? key,
    this.id,
    this.name,
    this.mobileNo,
    this.license,
    this.date,
    this.mall,
    this.duration,


  }) : super(key: key);

  final String? id;
  final String? name;
  final String? mobileNo;
  final String? license;
  final String? date;
  final String? mall;
  final String? duration;

  @override
  State<Add> createState() => _AddState();


}

// for Authentication login and signup
class _AddState extends State<Add> {
  TextEditingController username = TextEditingController();
  TextEditingController license = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController dateofJourney = TextEditingController();
  AuthController authController = Get.put(AuthController());


//list for malls
  String? selectedMall;
  final List<String> mallItems = ['Lulu Mall'];


//list for duration selection
  String? selectedDuration;
  final List<String> durationItems = ['1 Hour', '2 Hours' , '3 Hours', '4 Hours'];

  String? onclick;
  bool seepwd = false;
  bool changebutton = false;
  final _formkey = GlobalKey<FormState>();
  


// navigation and animation button code
  /*moveToHome(BuildContext context) async{
    if(_formkey.currentState!.validate()) {
      setState(() {
        changebutton = true;
      });
       Navigator.push(
        context, MaterialPageRoute(builder: (context) => Submit()),);
      setState(() {
        changebutton = false;
      });
    }
  }*/

  @override
  void initState() {
    widget.id != null ? username.text = widget.name.toString() : "";
    widget.id != null ? license.text = widget.license.toString() : "";
    widget.id != null ? number.text = widget.mobileNo.toString() : "";
    widget.id != null ? selectedMall = widget.mall.toString() : "";
    widget.id != null ? selectedDuration = widget.duration.toString() : "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
          color: Colors.black87,
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Parking Reservation",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  //------Textformfiled code-------------
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Column(children: [
                      TextFormField(
                        controller: username,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Enter Your Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Name"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name cannot be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: license,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            counterText: "",
                            hintText: "Enter Your Vehicle Number",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Vehicle Number"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "License Plate cannot be empty";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: number,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            counterText: "",
                            filled: true,
                            hintText: "Enter Your Mobile Number",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Mobile Number"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Mobile Number cannot be empty";
                          } else if (value.length > 10) {
                            return "Mobile number should be 10 digit";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),

                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Mall :",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 1.0),
                        child: DropdownButtonFormField2(
                          buttonStyleData: const ButtonStyleData(
                            height: 60,
                            padding:
                                EdgeInsets.only(left: 20, right: 10),
                          ),
                          iconStyleData: const IconStyleData(
                            iconSize: 30,
                            ),
                          decoration:
                          InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),

                            ),
                          ),
                          isExpanded: true,
                          hint: const Text(
                            'Select The Mall',
                            style: TextStyle(fontSize: 16),
                          ),


                         dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                         ),
                         ),

                          items: mallItems
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select the Mall.';
                            }
                            return null;
                          },
                          value: selectedMall,
                          onChanged: (value) {
                            setState(() {
                              selectedMall = value.toString();
                            });
                          },
                        ),
                      ),

                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Time :",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        child: TextFormField(
                          readOnly: true,
                          controller: dateofJourney,
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Pick your Time'),
                          validator: (value) {
                            // ignore: unrelated_type_equality_checks
                            if (value == false) return 'Please select Time';
                            return null;
                          },
                          onTap: () async {
                            TimeOfDay? selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (selectedTime != null) {
                              setState(() {
                                dateofJourney.text =
                                    selectedTime.format(context); // Update the text value
                              });
                            }
                          },
                        ),
                      ),

                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Duration :",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 1.0),
                        child: DropdownButtonFormField2(
                          buttonStyleData: const ButtonStyleData(
                            height: 60,
                            padding:
                            EdgeInsets.only(left: 20,right: 10),
                          ),

                            iconStyleData: const IconStyleData(
                              iconSize: 30 ,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              
                            ),
                          
                            decoration: InputDecoration( 
                             fillColor: Colors.grey.shade100,
                            filled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                           ),
                          
                          isExpanded: true,
                          hint: const Text(
                            'Select required duration',
                            style: TextStyle(fontSize: 16),
                          ),
          
                          value: selectedDuration,
                          onChanged: (value) {
                            setState(() {
                              selectedDuration = value.toString();
                            });
                          },
                          
                          items: durationItems
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select your required duration.';
                            }
                            return null;
                          }, 
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      //-----------Login Button code---------------
                      InkWell(
                        onTap: () => Submit(),
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          width: changebutton ? 50 : 150,
                          height: 50,
                          alignment: Alignment.center,
                          child: changebutton
                              ? Icon(Icons.done)
                              : Text(
                            widget.id == null ? "Pay" : "Update",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(
                                  changebutton ? 50 : 8)),
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Submit() async {
    var userId = FirebaseAuth.instance.currentUser!.uid.toString();
    if (_formkey.currentState!.validate()) {
      try {
        setState(() {
          changebutton = true;
        });
        if (widget.id == null) {
          await FirebaseFirestore.instance.collection("Ticket").add({
            'name': username.text,
            'license': license.text,
            'mobileno': number.text,
            'mall':selectedMall,
            'date': dateofJourney.text,
            'duration':selectedDuration,
            'userId': userId,
          }).whenComplete(() {
            Get.snackbar("Parking reserved", "Successful",
                snackPosition: SnackPosition.BOTTOM);
                Navigator.of(context).pushNamed('pay');
            //Navigator.of(context).pop();
          });
        } 
        setState(() {
          changebutton = false;
        });
      } catch (e) {
        print(e);
        setState(() {
          changebutton = false;
        });
        Get.snackbar('Something went wrong', e.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }
}