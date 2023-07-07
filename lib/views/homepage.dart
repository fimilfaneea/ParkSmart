import 'package:parksmart/models/auth.dart';
import 'package:parksmart/views/ticket.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool changebutton =false;
  var id;




  //logout function
  logout(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    await AuthController.logout();
  }





  userInformation() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      id=preferences.getString('userId');
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
          title:const Text("PARKSMART"),
          foregroundColor: const Color.fromARGB(221, 255, 255, 255),
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          actions: [
            TextButton(
                onPressed: (){
                  _showMyDialog(
                      'Log Out',
                      'Are you sure you want to logout?',
                      'No',
                      'Yes',
                          () async{
                        logout(context);
                      },false
                  );
                  /*Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));*/
                }, child: const Text('Log Out',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          child: const Icon(Icons.add),
          onPressed: (){
      
            Get.to(() => const Add());
          },
        ),
        body: Container(
          height: 800,
          color: Colors.black,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Ticket").snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                    itemBuilder: (context,i){
                      var data=snapshot.data!.docs[i];
                      return (id!=data['userId'])?
                      const Center()
                          :Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 15,
                                    offset: const Offset(0,7),
                                    color: Colors.black.withOpacity(0.1)
                                )
                              ],
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text("Name :",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                    const SizedBox(width: 5,),
                                    Text(data['name'],style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5,),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text("Mobile no : ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                    Text(data['mobileno'],style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text("Vehicle Number : ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                    Text(data['license'],style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text("Mall : ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                    Text(data['mall'],style: const  TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text("Duration : ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                    Text(data['duration'],style: const  TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Stack(
                                children: [
                                  Align(
                                    alignment:Alignment.bottomLeft,
                                    child: Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            clipBehavior: Clip.antiAlias,
                                            width: 100,
                                            height: 30,
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(255, 255, 255, 255),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomLeft: Radius.circular(10),
                                                )
                                            ),
                                            child: Center(child: Text(data['date'],style: const TextStyle(color: Colors.black87),))),
                                        InkWell(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Add(
                                                id: data.id,
                                                name:data['name'] ,
                                                license: data['license'],
                                                mobileNo:data['mobileno'] ,
                                                mall:data['mall'],
                                                date: data['date'],
                                              )));
                                            },
                                            child: Text("Edit",style: TextStyle(color: Colors.tealAccent.withOpacity(0.0),fontSize: 16,fontWeight: FontWeight.bold),)),
                                        InkWell(
                                          onTap: (){
                                            _showMyDialog(
                                                'Delete booking',
                                                'Are you sure you want to delete this booking?',
                                                'No',
                                                'Yes',
                                                    () async {
                                                  try{
                                                    setState(() {
                                                      changebutton=true;
                                                    });
                                                    await FirebaseFirestore.instance.collection("Ticket").doc(
                                                        data.id
                                                    ).delete().whenComplete(() {
                                                      Navigator.of(context).pop();
                                                      Get.snackbar("Delete Ticket book", "Delete Ticket book successfully",snackPosition: SnackPosition.BOTTOM);
                                                    });
                                                    setState(() {
                                                      changebutton=false;
                                                    });
                                                  }catch(e){
                                                    print("Something went wrong");
                                                    setState(() {
                                                      changebutton=false;
                                                    });
                                                  }
                                                },true
                                            );
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.only(right: 60.0),
                                            child: Text("Delete",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }else if(snapshot.hasError){
                return const Center(child: Text("No data"));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
  Future<void> _showMyDialog(String title,String text,String nobutton,String yesbutton,Function onTap,bool isValue) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: isValue, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text(nobutton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:  Text(yesbutton),
              onPressed: () async {
                onTap();
              },
            ),
          ],
        );
      },
    );
  }
}