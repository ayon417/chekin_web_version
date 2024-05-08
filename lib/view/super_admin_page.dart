
import 'dart:ui';
import 'package:chekin_web_version/model/Google_Sign_In.dart';
import 'package:chekin_web_version/view/login_page.dart';
import 'package:chekin_web_version/view/superadmin_client_list.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:chekin_web_version/model/download.pdf.dart';
import 'package:chekin_web_version/model/validation.dart';
import 'package:flutter/cupertino.dart';

import '../model/download_excel.dart';



final _domainAddController = TextEditingController();
final _adminIdController = TextEditingController();

final _noOfSubscriberController = TextEditingController();

TextEditingController updateAdminIdController = TextEditingController();
TextEditingController updateSubscriberController = TextEditingController();
var readData;
String str='';
List admin=[];

class SuperAdminPage extends StatefulWidget{
  @override
  State<SuperAdminPage> createState()=> SuperAdminPageState();
}

class SuperAdminPageState extends State<SuperAdminPage>{
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2022, 10, 10),
    end: DateTime(2022, 10, 10),
  );
  get newDateRange => null;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return ScaffoldMessenger(
      child: Scaffold(
          body:Stack(
              children:[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/page_background.jpg'),
                      fit: BoxFit.cover,
                    ),

                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only( top: 70,
                    left:15,
                    // bottom: deviceHeight(context) * 0.01,
                    // right: deviceWidth(context) * 0.09,
                  ),
                  child: LayoutBuilder(

                      builder: (context, constraints) {
                        if(constraints.maxWidth>900 || constraints.maxHeight>700){
                          return Form(
                              key: _key,
                              child: Row(
                                children: [
                                  part1(context),
                                  BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 8,
                                      sigmaY: 8,
                                    ),

                                  ),
                                  part2(context),
                                ],
                              )
                          );
                        }else{
                          return ListView(
                            children: [
                              Column(
                                children: [
                                  part1(context),
                                  BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 8,
                                      sigmaY: 8,
                                    ),

                                  ),
                                  part2(context),
                                ],
                              ),
                            ],
                          );
                        }

                      }
                  ),
                ),

              ]
          )


      ),
    );
  }
  @override
  Widget part1(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
    return  Flexible(
      child: Column(
        children: [
          Flexible(
            child: Container(
              height: 370,
              width: 470,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/background_image.png'),
                  fit: BoxFit.cover,
                ),

              ),
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Add Client Domain",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    width: double.infinity,
                    height: 314,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              TextFormField(
                                controller: _domainAddController,
                                validator: Validation().validateDomainID,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                                decoration: const InputDecoration(
                                  labelText: 'Enter client Domain',
                                  hintText: 'E.g. infiflex.com', //hint text
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey), //hint text style
                                  labelStyle:
                                  TextStyle(fontSize: 14, color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: _adminIdController,
                                validator: Validation().validateEmail,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                                decoration: const InputDecoration(
                                  labelText: 'Enter admin Id',
                                  hintText:
                                  'E.g. admin1@infiflex.com,admin2@infiflex.com', //hint text
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey), //hint text style
                                  labelStyle:
                                  TextStyle(fontSize: 14, color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'No of Subscribers :',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 116,
                                    height: 40,
                                    child: TextFormField(
                                      controller: _noOfSubscriberController,
                                      validator: Validation().validateSubscriber,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                            const BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(7)),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(7),
                                        ), //hint text style
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'License period :',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 32),
                                  SizedBox(
                                    width: 116,
                                    height: 40,
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.red,
                                            width: 1,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      onPressed: pickDateRange,
                                      child: const Text(
                                        'Select Date',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),

                              Container(
                                padding: EdgeInsets.fromLTRB(142,0,0,0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 116,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border:
                                          Border.all(width: 1, color: Colors.white)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${start.day}/${start.month}/${start.year}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'to',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: 116,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border:
                                          Border.all(width: 1, color: Colors.white)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${end.day}/${end.month}/${end.year}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 25),
                              SizedBox(
                                height: 30,
                                width:150,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    List adminIdList =_adminIdController.text.split(',');
                                    print("the list is $adminIdList");
                                    if(_key.currentState!.validate()) {
                                      final data1 = <String, dynamic>{
                                        "AdminList": adminIdList,
                                        "fromDate": '${start.day}/${start
                                            .month}/${start.year}',
                                        "noOfSubscribers": _noOfSubscriberController
                                            .text,
                                        "status": "active",
                                        "toDate": '${end.day}/${end.month}/${end
                                            .year}',


                                      };
                                      var superAdminRef = await FirebaseFirestore
                                          .instance.collection("SuperAdmin")
                                          .doc("List of Clients")
                                          .get();
                                      if (superAdminRef.exists == true) {
                                        print("Its presents");
                                        FirebaseFirestore.instance.collection(
                                            "SuperAdmin")
                                            .doc("List of Clients")
                                            .update({
                                          "Client List": FieldValue.arrayUnion(
                                              [_domainAddController.text]),
                                        });
                                      } else {
                                        print("Not present");
                                        FirebaseFirestore.instance.collection(
                                            "SuperAdmin")
                                            .doc("List of Clients")
                                            .set({
                                          "Client List": [
                                            _domainAddController.text
                                          ],
                                        });
                                      }
                                      FirebaseFirestore.instance.collection(
                                          _domainAddController.text)
                                          .doc(
                                          "config@${_domainAddController.text}")
                                          .set(data1);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Sucessfully Submitted!!",
                                              style: TextStyle(
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,),
                                            backgroundColor: Color(0xFFB62021),
                                            action: SnackBarAction(
                                              label: 'dismiss',
                                              textColor: Colors.white,
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    //      minimumSize: const Size.fromWidth(40),

                                  ),

                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xFFB62021)
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

            ),
          ),
          SizedBox(height:deviceHeight(context) * 0.10, ),
          Text(
            "Super Admin Portal",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  Widget part2(BuildContext context){
    return Container(

      height:580,
      width: 350,

      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.transparent,
          )
        ],
        border:
        Border.all(color: Colors.black.withOpacity(0.5), width: 0.5),
        gradient: LinearGradient(
          colors: [
            Colors.white60.withOpacity(0.0),
            Colors.transparent.withOpacity(0.0),
          ],
          stops: const [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Stack(
          children:[

            Row(

              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                const Text(
                  'Client List',

                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.blueGrey,
                  ),
                ),
                //SizedBox(width: 150,),
                Tooltip(
                  message: 'Sign Out',
                  child: IconButton(

                    iconSize: 18,
                    icon: const Icon(
                      Icons.logout,
                    ),
                    onPressed: () {
                      FirebaseAuthService().signOutGoogle().then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  LoginPage())));
                    },
                  ),
                ),

              ],
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0,40,0,0),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('SuperAdmin').snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                              if(!snapshot.hasData){
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return ListView.builder(
                                  itemCount: clientData.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ListTile(
                                        leading:  Tooltip(message:'Edit Client Details',child: IconButton( icon: const Icon(Icons.edit), onPressed: () {
                                          //  FetchFirebaseData().readFirestoreData(clientData[index], 'config@${clientData[index]}');
                                          print("Client index is $index}");
                                          print("Client is ${clientData[index]}");
                                          var collection = FirebaseFirestore.instance.collection(clientData[index]);
                                          collection.doc('config@${clientData[index]}').snapshots().listen((docSnapshot) {
                                            if (docSnapshot.exists) {
                                              Map<String, dynamic> data = docSnapshot.data()!;
                                              readData=data;
                                              admin=readData["AdminList"];
                                              str=admin.join(',');
                                              print("*************$admin");
                                              print("Data value is $str");
                                              updateAdminIdController.text=str;
                                              updateSubscriberController.text=data["noOfSubscribers"];
                                            }
                                          });

                                          showAlertDialog(context, index);
                                        },)),
                                        trailing:  Wrap(
                                          children: [
                                            Switch(
                                              value: isClicked[index],
                                              onChanged: (val) {
                                                setState(() {
                                                  print("The value is $index");
                                                  isClicked[index]=val;
                                                  print("The is client is ${isClicked[index]}");
                                                });
                                                if (isClicked[index] == false) {
                                                  FirebaseFirestore.instance.collection(
                                                      clientData[index])
                                                      .doc("config@${clientData[index]}")
                                                      .update({
                                                    "status":"inactive",
                                                  });

                                                }else{
                                                  FirebaseFirestore.instance.collection(
                                                      clientData[index])
                                                      .doc("config@${clientData[index]}")
                                                      .update({
                                                    "status":"active",
                                                  });
                                                }
                                              },
                                              activeColor: Colors.white,
                                              activeTrackColor: const Color(0xFFB62021),
                                              inactiveThumbColor: const Color(0xFFB62021),
                                              inactiveTrackColor: Colors.grey,
                                            ),
                                            Tooltip(
                                              message: 'Delete this client',
                                              child: IconButton( icon: const Icon(Icons.delete),color: Color(0xFFB62021), onPressed: () async {
                                                showAlertDialogForDelete(context,index);
                                              },),
                                            ),
                                          ],
                                        ),
                                        title: Text(clientData[index].toString()));
                                  });
                            }
                        ),
                        /**ListView.builder(
                            itemCount: clientData.length,
                            itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                            leading:  Tooltip(message:'Edit Client Details',child: IconButton( icon: const Icon(Icons.edit), onPressed: () {
                            showAlertDialog(context, index);
                            },)),
                            trailing:  Tooltip(
                            message: 'Delete this client',
                            child: IconButton( icon: const Icon(Icons.delete),color: Color(0xFFB62021), onPressed: () async {
                            final instance = FirebaseFirestore.instance;
                            final batch = instance.batch();
                            var collection = instance.collection(clientData[index]);
                            var snapshots = await collection.get();
                            for (var doc in snapshots.docs) {
                            batch.delete(doc.reference);
                            }
                            await batch.commit();

                            FirebaseFirestore.instance.collection('SuperAdmin').doc('List of Clients')
                            .update({
                            "Client List": FieldValue.arrayRemove([clientData[index]]),
                            }
                            );

                            },),
                            ),
                            title: Text(clientData[index].toString()));
                            }),*/
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: StreamBuilder<Object>(
                                stream:FirebaseFirestore.instance.collection('SuperAdmin').snapshots(),
                                builder: (context, snapshot) {
                                  return Text(
                                    'Total Client : $noOfClients',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.blueGrey),
                                  );
                                }
                            ),
                          ),
                          Row(

                            children: [
                              ElevatedButton(

                                onPressed: () {
                                  downloadExcel();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFB62021),
                                  //      minimumSize: const Size.fromWidth(40),

                                ),

                                child: Row(
                                  children: const [
                                    Icon(Icons.download),
                                    SizedBox(width: 5),
                                    Text(
                                      'excel',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 5),
                              ElevatedButton(
                                onPressed: () {
                                  downloadPdf();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFB62021),
                                  //      minimumSize: const Size.fromWidth(40),

                                ),

                                child: Row(

                                  children: const [
                                    Icon(Icons.download),
                                    SizedBox(width: 5),
                                    Text(
                                      'pdf',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ]
      ),


    );
  }
  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (newDateRange == null) return; //pressed ' X'
    setState(() => dateRange = newDateRange); //pressed save
  }

  showAlertDialog(BuildContext context, int index) {
    print("Client index is $index}");
    print("Client is ${clientData[index]}");

    var start = dateRange.start;
    var end = dateRange.end;
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(

      title: Text("Update Client Details",textAlign: TextAlign.center,),

      actions: [
        Column(
          children: [

            TextFormField(
              controller: updateAdminIdController,
              validator: Validation().validateEmail,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
              decoration: const InputDecoration(
                labelText: 'Enter admin Id',

                hintText:
                'E.g. admin1@infiflex.com,admin2@infiflex.com', //hint text
                hintStyle: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.black), //hint text style
                labelStyle:
                TextStyle(fontSize: 12, color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'No of Subscribers :',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 5,),
                SizedBox(
                  width: 116,
                  height: 40,
                  child: TextFormField(
                    controller: updateSubscriberController,
                    validator: Validation().validateSubscriber,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(7)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                      ), //hint text style
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'License period :',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(width: 17),
                SizedBox(
                  width: 116,
                  height: 40,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Colors.red,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    onPressed: pickDateRange,
                    child: const Text(
                      'Select Date',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Container(
                  width: 116,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                      Border.all(width: 1, color: Colors.black)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${start.day}/${start.month}/${start.year}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 2),
                const Text(
                  'to',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(width: 2),
                Container(
                  width: 116,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                      Border.all(width: 1, color: Colors.black)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${end.day}/${end.month}/${end.year}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      //      minimumSize: const Size.fromWidth(40),
                      fixedSize:const Size(100, 30),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel",style: TextStyle(color: Color(0xFFB62021),fontSize: 12),)),
                SizedBox(width: 8,),
                ElevatedButton(
                  onPressed: () async {

                    List updateadminIdList =updateAdminIdController.text.split(',');
                    print("the list is $updateadminIdList");
                    final data1 = <String, dynamic>{
                      "AdminList":updateadminIdList,
                      "fromDate": '${start.day}/${start.month}/${start.year}',
                      "noOfSubscribers": updateSubscriberController.text, "status": "active", "toDate": '${end.day}/${end.month}/${end.year}',

                    };
                    FirebaseFirestore.instance.collection(clientData[index]).doc("config@${clientData[index]}").set(data1);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                        SnackBar(
                          content: Text(
                            "Updated Successfully!!",
                            style: TextStyle(
                                color: Colors.white),
                            textAlign: TextAlign.center,),
                          backgroundColor: Color(0xFFB62021),
                          action: SnackBarAction(
                            label: 'dismiss',
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    fixedSize:const Size(100, 30),


                  ),

                  child: const Text(
                    'Update',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color(0xFFB62021)
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  showAlertDialogForDelete(BuildContext context,index) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No",style: TextStyle(color: Color(0XFFB62021)),),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = Container(
      color: Color(0xFFB62021),
      child: TextButton(
        child: Text("Yes",style: TextStyle(color: Colors.white),),
        onPressed:  () async {
          final instance = FirebaseFirestore.instance;
          final batch = instance.batch();
          var collection = instance.collection(clientData[index]);
          var snapshots = await collection.get();
          for (var doc in snapshots.docs) {
            batch.delete(doc.reference);
          }
          await batch.commit();
          FirebaseFirestore.instance.collection('SuperAdmin').doc('List of Clients')
              .update({
            "Client List": FieldValue.arrayRemove([clientData[index]]),
          }
          );
          Navigator.of(context).pop();
        },
      ),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(

      content: Text("Are you sure you want to delete?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

