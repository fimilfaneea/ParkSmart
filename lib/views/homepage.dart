import 'package:lottie/lottie.dart';
import 'package:parksmart/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String allocatedSpot = "";
  // int counter() {

  // }

  Future<String?> getLatestDocumentId(int i) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Ticket')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      String latestDocumentId = snapshot.docs[i].id;
      return latestDocumentId;
    } else {
      return null;
    }
  }

  Future<void> _showMyDialog(String title, String text, String nobutton,
      String yesbutton, Function onTap, bool isValue) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: isValue, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(nobutton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(yesbutton),
              onPressed: () async {
                onTap();
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> getQRData(int i) async {
    String? latestDocumentId = await getLatestDocumentId(i);
    if (latestDocumentId != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Ticket')
          .doc(latestDocumentId)
          .get();

      Map<String, dynamic> data =
          Map<String, dynamic>.from(snapshot.data() as Map<dynamic, dynamic>);
      String qrData = '';

      data.forEach((key, value) {
        qrData += '$key: ${value.toString()}\n';
      });

      String allocatedSpot = data['parkingSpot'];
       // Retrieve the allocated parking spot

      setState(() {
        this.allocatedSpot = allocatedSpot;
      });

      return qrData;
    } else {
      return ''; // Return an empty string or handle the case when there is no latest document ID
    }
  }

  bool changebutton = false;
  var id;

  //logout function
  logout(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    await AuthController.logout();
  }

  userInformation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString('userId');
    });
  }

  @override
  void initState() {
    userInformation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "PARKSMART",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
          foregroundColor: const Color.fromARGB(221, 255, 255, 255),
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          actions: [
            Card(
              color: Colors.red,
              child: TextButton(
                  onPressed: () {
                    _showMyDialog('Log Out', 'Are you sure you want to logout?',
                        'No', 'Yes', () async {
                      logout(context);
                    }, false);
                    /*Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));*/
                  },
                  child: const Text(
                    'Log Out',
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  )),
            ),
          ],
          
          // bottom: PreferredSize(
          //     preferredSize: const Size.fromHeight(300),
          //     child: Lottie.asset("assets/images/parking.json")),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: (){
            Navigator.of(context).pushNamed('form');
          },
        ),
        body: 
        Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Lottie.asset("assets/parking.json"),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                height: 500,
                color: Colors.black,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Ticket")
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasData) {
                      {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                          itemBuilder: (context,i){
                             var data=snapshot.data!.docs[i];
                             String details =
                            'Name: ${data['name']},Vehicle no.: ${data['license']},Mobile: ${data['mobileno']},Mall: ${data['mall']},Start time: ${data['date']},Duration: ${data['duration']}';
                            getQRData(i);
                      return (id!=data['userId'])?
                         const Center()
                        
                        :
                        
                         Column(
                          
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            
                            const SizedBox(
                              height: 50,
                            ),
                            const Text(
                              'Your Parking Ticket: Scan on exit.',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 16),
                            
                            Text(
                              'Vehicle No: ${data['license']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),

                            Text(
                              'Entry time: ${data['date']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),

                            Text(
                              'Allocated Spot: ${data['parkingSpot']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            QrImage(
                              
                              data: details,
                              
                              version: QrVersions.auto,
                              padding: const EdgeInsets.all(40.0),
                              size: 300,
                              foregroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                            ),


                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (Set<MaterialState> states) {
                                  return const Color.fromARGB(255, 120, 0, 0);
                                }),
                              ),
                              onPressed: () {
                                _showMyDialog(
                                    'Delete booking',
                                    'Are you sure you want to delete this booking?\n\n(This action is irreversable and non-refundable)',
                                    'No',
                                    'Yes', () async {
                                  try {
                                    setState(() {
                                      changebutton = true;
                                    });

                                    await FirebaseFirestore.instance
                                        .collection("Ticket")
                                        .doc(data.id)
                                        .delete()
                                        .whenComplete(() {
                                      Navigator.of(context).pop();
                                      Get.snackbar("Reservation Cancelled",
                                          "Parking spot reservation cancelled successfully",
                                          snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.white,
                                        );
                                    });
                                    setState(() {
                                      changebutton = false;
                                    });
                                  } catch (e) {
                                    print("Something went wrong");
                                    setState(() {
                                      changebutton = false;
                                    });
                                  }
                                }, true);
                              },
                              child: const Text('Cancel Ticket'),
                            ),
                          ],
                         );}
                        );
                      

                        //snapshot.hasData ? isFABEnabled = true :isFABEnabled =false;
                      
                   } } else if (snapshot.hasError) {
                      return const Center(child: Text("No data"));
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
                        
                        
      )
                                              
      
    );
  }
}

