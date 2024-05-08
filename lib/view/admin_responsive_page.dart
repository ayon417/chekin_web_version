
import 'dart:ui';

import 'package:chekin_web_version/model/show_company_emp_list.dart';
import 'package:chekin_web_version/view/Form_Page.dart';
import 'package:chekin_web_version/view/super_admin_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/Google_Sign_In.dart';
import '../model/show_organization_ip.dart';
import '../model/validation.dart';
import 'admin_notification.dart';
import 'admin_page.dart';
import 'admin_update_success.dart';
import 'login_page.dart';
import 'package:intl/intl.dart';

final _organizationIpController=TextEditingController();
final _organizationEmailController=TextEditingController();
final _hrEmailController=TextEditingController();
final _searchUserController=TextEditingController();
List<String> ip = [];
List<String> email = [];
int show=0;
var checkBypassVal;
var checkDisableVal;
int setText=0;
String  str="Bypass\nUser";
String  str1="Disable\nUser";

TextEditingController updatesecondaryEmailEditController = TextEditingController();
TextEditingController updatesupervisorNameEditController = TextEditingController();
TextEditingController updatephoneEditController = TextEditingController();
TextEditingController updatedeviceIdController = TextEditingController();
TextEditingController updateipAddressEditController = TextEditingController();
TextEditingController updatedateInputController = TextEditingController();
TextEditingController updatejoiningDateController = TextEditingController();

class AdminPageResponsive extends StatefulWidget {
  const AdminPageResponsive({super.key});

  @override
  State<StatefulWidget> createState() {
    return AdminPageResponsiveState();
  }
}

class AdminPageResponsiveState extends State<AdminPageResponsive> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String dropdownValue = '+91 (IND)';

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2022, 10, 10),
    end: DateTime(2022, 10, 10),
  );
  get newDateRange => null;
  @override
  void initState(){
    super.initState();
    setState(() {
      EmployeeList.showEmployeeList();
      OrganizationIpList.showIpList();
    });

    //print("no of clientuser is $clientuser");
  }
  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(
      child: Row(
        children: [
          item1(context),
          item2(context),
          frostedGlassEffectDemo(context),
        ],
      ),
    );


  }
  Widget item1(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,50,0,0),
      child: Container(
        height: 400,
        width: 290,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background_image.png"),
              fit: BoxFit.cover),

        ),
        child:Stack(
          children: [
            ListView(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Organizational settings",style: TextStyle(color: Colors.white,fontSize: 15),),
                        IconButton(
                          color: Colors.white,
                          icon: Icon(
                              Icons.notifications
                          ), onPressed: () {
                          showDialog(
                            barrierColor: Colors.black26,
                            context: context,
                            builder: (context) {
                              return const AdminNotification();
                            },
                          );
                        },)
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 190,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: TextFormField(
                              controller: _organizationIpController,
                              style: const TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                              decoration: const InputDecoration(
                                labelText: 'Enter Organizational IP address or IP range',
                                hintText: "192.11.16 or 155.97.22.11,155.97.22.17",
                                //hint text

                                hintStyle: TextStyle(fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                //hint text style
                                labelStyle: TextStyle(fontSize: 11, color: Colors.white),
                              ),

                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 0),
                            child: MaterialButton(
                              //padding: const EdgeInsets.symmetric(horizontal:100.0,vertical: 15),
                              //color: Color(0xFFB62021),
                              shape: RoundedRectangleBorder(side: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                  style: BorderStyle.solid
                              ),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                                textAlign: TextAlign.right,
                              ),
                              onPressed: () async {
                                var d4;
                                var ipRef=(await FirebaseFirestore.instance.collection(extractDomain).doc('config@$extractDomain').get()).data();
                                setState(() {
                                  //print("--------------hi------${_addressEditController.text}");
                                  ip=_organizationIpController.text.split(',');
                                  if(ipRef!.containsKey('Organizational Ip')){
                                    d4=<String,dynamic>{
                                      "Organizational Ip":FieldValue.arrayUnion(ip)

                                    };
                                  }else{
                                    d4=<String,dynamic>{
                                      "Organizational Ip":ip
                                    };
                                  }

                                  FirebaseFirestore.instance.collection(extractDomain).doc("config@$extractDomain").update(d4);
                                  print("ipudated");


                                });



                              },

                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10,),
                      child: Container(width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: StreamBuilder<Object>(
                            stream: FirebaseFirestore.instance.collection(extractDomain).doc('config@$extractDomain').snapshots(),
                            builder: (context, snapshot) {
                              return ListView.builder(
                                  itemCount: ipData.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        leading:  Tooltip(
                                          message: 'Delete this ip',
                                          child: IconButton( icon: const Icon(Icons.delete),color: Color(0xFFB62021), onPressed: () async {
                                            setState(() {
                                              FirebaseFirestore.instance.collection(extractDomain).doc(ipData[index]).delete();
                                              print("The deleted ip is ${ipData[index]}");
                                              FirebaseFirestore.instance.collection(extractDomain).doc('config@${extractDomain}')
                                                  .update({
                                                "Organizational Ip": FieldValue.arrayRemove([ipData[index]]),
                                              }
                                              );
                                              print("The ip deleted in list is ${ip[index]}");

                                            });

                                          },),
                                        ),
                                        title: Text(ipData[index].toString(),style: TextStyle(color:Colors.white),));
                                  }
                              );
                            }
                        ),
                      ),
                    ),
                    SizedBox(height: 1,),
                    StreamBuilder<Object>(
                        stream: FirebaseFirestore.instance.collection(extractDomain).doc('config@$extractDomain').snapshots(),
                        builder: (context, snapshot) {
                          return Text(
                            'Total IP addresses: ${ipData.length}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        }
                    ),

                    Row(
                      children: [
                        Container(
                          width: 190,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, left: 2),
                            child: TextFormField(
                              controller:  _hrEmailController,
                              style: const TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                              decoration: InputDecoration(
                                labelText: 'Enter HR Email',
                                hintText: "Eg:hr@infiflex.com",
                                //hint text
                                hintStyle: TextStyle(fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                //hint text style
                                labelStyle: TextStyle(fontSize: 11, color: Colors.white),
                              ),

                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30, left: 0),
                            child: MaterialButton(
                              //padding: const EdgeInsets.symmetric(horizontal:100.0,vertical: 15),
                              //color: Color(0xFFB62021),
                              shape: RoundedRectangleBorder(side: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                  style: BorderStyle.solid
                              ),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                                textAlign: TextAlign.right,
                              ),
                              onPressed: () {
                                var hrData;
                                hrData=<String,dynamic>{
                                  "HR email":_hrEmailController.text,
                                };
                                FirebaseFirestore.instance.collection(extractDomain).doc('config@$extractDomain').update(hrData);
                              },

                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 190,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, left: 2),
                            child: TextFormField(
                              controller: _organizationEmailController,
                              style: const TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                              decoration: InputDecoration(
                                labelText: 'Enter Organizational email or user email',
                                hintText: "Eg:user1@infiflex.com,user2@infiflex.com",
                                //hint text
                                hintStyle: TextStyle(fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                //hint text style
                                labelStyle: TextStyle(fontSize: 11, color: Colors.white),
                              ),

                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30, left: 0),
                            child: MaterialButton(
                              //padding: const EdgeInsets.symmetric(horizontal:100.0,vertical: 15),
                              //color: Color(0xFFB62021),
                              shape: RoundedRectangleBorder(side: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                  style: BorderStyle.solid
                              ),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                                textAlign: TextAlign.right,
                              ),
                              onPressed: () async {
                                if(_organizationEmailController.text!=''){
                                  var AdminRef =(await FirebaseFirestore
                                      .instance.collection(extractDomain)
                                      .doc("config@$extractDomain")
                                      .get()).data();
                                  var noOfSub=int.parse(AdminRef!["noOfSubscribers"]);

                                  print("No of subscriber is $noOfSub");

                                  setState(() {
                                    email=_organizationEmailController.text.split(',');

                                    if (AdminRef!.containsKey("Employee List")) {
                                      print("Employee List is presents");
                                      List noOfEmp=AdminRef["Employee List"];
                                      print("No of emp is ${noOfEmp.length+email.length}");
                                      if(noOfEmp.length+email.length<=noOfSub) {
                                        FirebaseFirestore.instance
                                            .collection(
                                            extractDomain)
                                            .doc("config@$extractDomain")
                                            .update({
                                          "Employee List": FieldValue
                                              .arrayUnion(
                                              email),
                                        });

                                        for (int i = 0; i < email.length; i++) {
                                          FirebaseFirestore.instance.collection(extractDomain).doc(email[i]).set({"bypass": "OFF","accountStatus":"active"});
                                        }
                                      }
                                      else{
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                "Subscriber limit exceeded. Please contact your administrator.",
                                                style: TextStyle(
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,),
                                              backgroundColor: Color(0xFFB62021),
                                              action: SnackBarAction(
                                                label: 'dismiss',
                                                textColor: Colors.white,
                                                onPressed: () {

                                                },
                                              ),
                                            ));
                                      }

                                    } else {
                                      print("Not present");
                                      if(email.length<=noOfSub){
                                        final data3=<String,dynamic>{
                                          "Employee List":email
                                        };
                                        FirebaseFirestore.instance.collection(extractDomain).doc("config@$extractDomain").update(data3);
                                        for(int i=0;i<email.length;i++){
                                          FirebaseFirestore.instance.collection(extractDomain).doc(email[i]).set({"bypass":"OFF","accountStatus":"active"});
                                        }
                                      } else{
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "You have exceed your limit",
                                                style: TextStyle(
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,),
                                              backgroundColor: Color(0xFFB62021),
                                              action: SnackBarAction(
                                                label: 'dismiss',
                                                textColor: Colors.white,
                                                onPressed: () {

                                                },
                                              ),
                                            ));
                                      }
                                    }
                                  });
                                }




                              },

                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 2,),
                      child: SingleChildScrollView(
                        child: Container(width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: StreamBuilder<Object>(
                              stream: FirebaseFirestore.instance.collection(extractDomain).doc('config@${extractDomain}').snapshots(),
                              builder: (context, snapshot) {
                                if(!snapshot.hasData){
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return ListView.builder(
                                    itemCount: noOfEmployee,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                          leading:  Tooltip(
                                            message: 'Delete this client',
                                            child: IconButton( icon: const Icon(Icons.delete),color: Color(0xFFB62021), onPressed: () async {
                                              setState(() {
                                                FirebaseFirestore.instance.collection(extractDomain).doc(empData[index]).delete();
                                                print("The deleted user is ${empData[index]}");
                                                FirebaseFirestore.instance.collection(extractDomain).doc('config@${extractDomain}')
                                                    .update({
                                                  "Employee List": FieldValue.arrayRemove([empData[index]]),
                                                }
                                                );
                                                print("The item deleted in list is ${empData[index]}");

                                              });

                                            },),
                                          ),
                                          title: Text(empData[index].toString(),style: TextStyle(color:Colors.white),));
                                    }
                                  //     Row(
                                  //   children: [
                                  //     Text("${ip[index]}",style: TextStyle(color: Colors.white,fontSize: 12) ,),
                                  //   ],
                                  // ),


                                );
                              }
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(12,5,0,0),
                      child: StreamBuilder<Object>(
                          stream: FirebaseFirestore.instance.collection(extractDomain).doc('config@$extractDomain}').snapshots(),
                          builder: (context, snapshot) {
                            return Text(
                              'Total Mail addresses: ${empData.length}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          }
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),

      ),
    );
  }
  Widget item2(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(0,50,0,0),
      child: Container(
        height: 400,
        width: 290,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background_image.png"),
              fit: BoxFit.cover),

        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 11,),
                  Row(
                    children: [
                      SizedBox(width: 4,),
                      Text("Step 1:",style: TextStyle(color: Colors.white,fontSize: 16),),
                      SizedBox(width: 2,),
                      Padding(
                        padding:  EdgeInsets.fromLTRB(4,0,0,0),
                        child: Text("User Settings",style: TextStyle(color: Colors.white,fontSize: 16),),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    color: Colors.white,
                  ),
                  Container(
                    margin:  EdgeInsets.only(left: 10, right: 10),
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            controller: _searchUserController,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            decoration: InputDecoration(

                              errorStyle: TextStyle(color: Colors.white54),
                              prefixIcon:
                              Icon(Icons.search, color: Colors.red, size: 22),
                              /**  suffix: Text(
                                  '@$extractDomain',
                                  style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                                  ),*/
                              /**      suffix: Text(
                                  '@$extractDomain',
                                  style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                                  ),*/
                              hintText: 'search user',
                              hintStyle:
                              TextStyle(fontSize: 12, color: Colors.white),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,0,0,0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(7)),
                            child: const Text(
                              'go',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.right,
                            ),
                            onPressed: () async {

                              var searchUser=(await FirebaseFirestore.instance.collection(extractDomain).doc(_searchUserController.text).get());
                              if(searchUser.exists){
                                var getData= (await FirebaseFirestore.instance.collection(extractDomain).doc(_searchUserController.text).get()).data();
                                setState(() {
                                  updatephoneEditController.text=getData!['phone no'];
                                  updatesecondaryEmailEditController.text=getData["secondary email"];
                                  updatesupervisorNameEditController.text=getData["supervisor email"];
                                  updatedeviceIdController.text=getData["deviceId"];
                                  updatedateInputController.text=getData["date of birth"];
                                  updatejoiningDateController.text=getData["joining date"];
                                  if(getData.containsKey("homeipaddress")){
                                    updateipAddressEditController.text=getData["homeipaddress"].join(',');
                                    print("The home ip address you are gettting is ${updateipAddressEditController.text}");
                                  }
                                  show=1;
                                  if(getData!["bypass"]=="OFF"){
                                    str="Bypass\nUser";
                                  }else{
                                    str="Restrict\nUser";
                                  }
                                  if(getData["accountStatus"]=="active"){
                                    str1="Disable\nUser";
                                    print("str1 is $str1");
                                  }else{
                                    str1="Enable\nUser";
                                    print("str1 is $str1");
                                  }
                                });

                              }else{
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "This user is not listed!!",
                                        style: TextStyle(
                                            color: Colors.white),
                                        textAlign: TextAlign.center,),
                                      backgroundColor: Color(0xFFB62021),
                                      action: SnackBarAction(
                                        label: 'dismiss',
                                        textColor: Colors.white,
                                        onPressed: () {

                                        },
                                      ),
                                    ));
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(left:10,right: 10),
                    width: 300,
                    height: 260,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8,10,0,0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Other Actions...",style: TextStyle(color: Colors.white70,fontSize: 15),),
                          SizedBox(height: 7,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Tooltip(
                                  message: "Bypass this user",
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      checkBypassVal=(await FirebaseFirestore.instance.collection(extractDomain).doc(_searchUserController.text).get()).data();
                                      setState(() {
                                        print(checkBypassVal!["bypass"]);
                                        if(checkBypassVal!["bypass"]=="OFF"){

                                          FirebaseFirestore.instance.collection(extractDomain).doc(_searchUserController.text).update({"bypass":"ON"});
                                          str="Restrict\nUser";
                                          print("str is $str");
                                        }else{
                                          setText=1;

                                          FirebaseFirestore.instance.collection(extractDomain).doc(_searchUserController.text).update({"bypass":"OFF"});
                                          str="Bypass\nUser";
                                          print("str is $str");
                                        }
                                      });


                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      minimumSize:Size(120,150),//<-- SEE HERE
                                      side: BorderSide(
                                          width: 1.0,
                                          color: Colors.red
                                      ),
                                    ), child:Text(str,style: TextStyle(color: Colors.white70,fontSize: 18),),
                                  )
                              ),
                              Tooltip(
                                message: "Disable this user",
                                child: ElevatedButton(
                                  onPressed: () async {
                                    checkDisableVal=(await FirebaseFirestore.instance.collection(extractDomain).doc(_searchUserController.text).get()).data();
                                    setState(() {
                                      print(checkDisableVal!["accountStatus"]);
                                      if(checkDisableVal!["accountStatus"]=="active"){

                                        FirebaseFirestore.instance.collection(extractDomain).doc(_searchUserController.text).update({"accountStatus":"inactive"});
                                        str1="Enable\nUser";
                                        print("str is $str1");
                                      }else{
                                        setText=1;

                                        FirebaseFirestore.instance.collection(extractDomain).doc(_searchUserController.text).update({"accountStatus":"active"});
                                        str1="Disable\nUser";
                                        print("str is $str1");
                                      }
                                    });

                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent,
                                    minimumSize:Size(120,150),//<-- SEE HERE
                                    side: BorderSide(
                                        width: 1.0,
                                        color: Colors.red
                                    ),
                                  ), child: Text(str1,style: TextStyle(color: Colors.white70,fontSize: 18),),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,0,0,0),
                            child: ElevatedButton(
                              onPressed: () async {

                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                minimumSize:Size(220,60),//<-- SEE HERE
                                side: BorderSide(
                                    width: 1.0,
                                    color: Colors.red
                                ),
                              ), child: Text("Generate User Activity Report",style: TextStyle(color: Colors.white70,fontSize: 14),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget frostedGlassEffectDemo(BuildContext context) {
    return show==0?ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: Container(
            child:
            Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 3,
                      sigmaY: 3,
                    ),
                    child: Container(
                      height:150,
                      width: 150,
                    ),
                  ),
                  Container(
                    height: 600,
                    width: 330,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                          )
                        ],

                        border: Border.all(
                            color: Colors.black.withOpacity(0.5), width: 0.5),
                        gradient: LinearGradient(
                          colors: [

                            Colors.white70.withOpacity(0.1),
                            Colors.white70.withOpacity(0.1),
                          ],
                          stops: [1.0, 0.0],
                        ),
                        borderRadius: BorderRadius.circular(19)),
                    child: SingleChildScrollView(
                      child: Column(
                          children: [
                            Form(key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:  <Widget>
                                [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0,0,50,0),
                                        child: Column(
                                          children: [
                                            Text(name!,style: const TextStyle(color: Colors.green),),
                                            Text(emailId!,style: const TextStyle(fontSize: 10),),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0,0,10,0),
                                        child: Tooltip(
                                          message: "Sign Out",
                                          child: IconButton(

                                            iconSize: 18,
                                            icon: const Icon(
                                              Icons.logout,
                                            ),
                                            onPressed: () {
                                              FirebaseAuthService().signOutGoogle().then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  const LoginPage())));
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(color: Color(0xFFB62021)),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      'Instructions',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Divider(color: Color(0xFFB62021)),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 150,0),
                                    child: Text("-->Organizational settings",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 110,0),
                                    child: Text("# Organization IP Address / Range -",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10,0),
                                    child: Text(" Add your office network details such as IP address, (E.g.,192.0.2.1) or IP range (E.g., 0.0.0.0 to 255.255.255.255) in the mentioned format. ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 155, 0),
                                    child: Text(
                                      "# Organization Email Address-",
                                      style: TextStyle(
                                        color: Colors.black,

                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Text(
                                      "Add your organization’s emails such as HR email address, Manager email address,etc., which needs to be copied in all important notifications sent out using Chekin.  ",
                                      style: TextStyle(
                                        color: Colors.black,

                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0,10,185,0),
                                    child: Text(
                                      "# Notification Settings -",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10,0,0,0),
                                    child: Text(
                                      "Set timing for tip of day,bithday anniversary,work anniversary,daily attendance.",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0,20,200,0),
                                    child: Text(
                                      "-->User settings",
                                      style: TextStyle(
                                        color:  Colors.red,

                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(12, 10,10,0),
                                    child: Text(
                                      "@ Search User-\nSearch the user for whom the update activities such as Disable User,Bypass User, Generate Reports, edit personal details,etc. needs to be performed.",
                                      style: TextStyle(
                                        color:  Colors.black,

                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10,10,0),
                                    child: Text(
                                      "  §  General Actions –\nAdmin can update the user’s phone number, secondary email, supervisor email, home IP address and device Id. ",
                                      style: TextStyle(
                                        color:  Colors.black,

                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10,10,0),
                                    child: Text(
                                      " §  Other Actions –\nAdmin can bypass user from all network restrictions so that the user can access from anywhere. Admin can disable a user in case of leave of absence or resignation. Admin can also generate activity report of the user.",
                                      style: TextStyle(
                                        color:  Colors.black,

                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ]),
                    ),
                  ),
                ]
            )
        )
    ):Form(
      key: _formKey,
      child: Container(

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

        child: ListView(
            children:[
              Column(
                  children:[
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        const Text(
                          'Step:2',

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.blueGrey,
                          ),
                        ),
                        //SizedBox(width: 150,),
                        IconButton(

                          iconSize: 18,
                          icon: const Icon(
                            Icons.logout,
                          ),
                          onPressed: () {
                            FirebaseAuthService().signOutGoogle().then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  LoginPage())));;
                          },
                        ),

                      ],
                    ),
                    SizedBox(width: 10),
                    Text(_searchUserController.text),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: updatephoneEditController,
                          //     validator: Validation().validatePhoneNo,
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          decoration: InputDecoration(
                            /** prefix: DropdownButton(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_drop_down),
                                elevation: 10,
                                isDense: true,
                                dropdownColor: const Color(0xFFEEEAE8),
                                style: const TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w700),
                                onChanged: (String? newValue) {
                                setState(() {
                                dropdownValue = newValue!;
                                });
                                },
                                items: <String>['+91 (IND)', '+1 (US)', '+65 (SG)']
                                .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                                );
                                }).toList(),
                                ),*/
                            labelText: 'Phone number *',
                            hintText: "Enter your phone number", //hint text
                            prefixIcon: const Icon(Icons.phone, color: Colors.red),
                            hintStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey), //hint text style
                            labelStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                          ),
                          keyboardType: TextInputType.phone,

                        ),
                        TextFormField(
                          // initialValue: 'hello@gmail.com',
                          controller:updatesecondaryEmailEditController,
                          validator: Validation().validateEmail,
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          decoration: InputDecoration(

                            labelText: 'Secondary Email *',
                            hintText: "Enter your secondary email id", //hint text
                            prefixIcon: const Icon(Icons.email, color: Colors.red),
                            hintStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey), //hint text style
                            labelStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                          ),
                          //maxLength: 1000,

                          onSaved: (value) {
                            // _secondaryEmail = value;
                          },
                        ),
                        TextFormField(
                          controller: updatedateInputController,
                          validator: Validation().validateDate,
                          style: const TextStyle(
                              color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 16),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.calendar_today, color: Colors.red),
                            //icon of text field
                            labelText: "Enter Date of Birth *",
                            labelStyle: TextStyle(
                                fontSize: 14, color: Colors.black38, fontWeight: FontWeight.w600),
                            //label text of field
                          ),
                          readOnly: true,
                          //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2100));
                            if (pickedDate != null) {
                              String formattedDate =DateFormat('dd/MM/yyyy')
                                  .format(pickedDate); //DateFormat.yMd(pickedDate) as String;
                              print('format joinig-----$formattedDate');
                              setState(() {
                                dateInputController.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            }

                          },
                        ),
                        TextFormField(
                          controller: updatejoiningDateController,
                          validator: Validation().validateDate,
                          style: const TextStyle(
                              color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 16),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.calendar_today, color: Colors.red),
                            //icon of text field
                            labelText: "Enter Date of Joining *",
                            labelStyle: TextStyle(
                                fontSize: 14, color: Colors.black38, fontWeight: FontWeight.w600),
                            //label text of field
                          ),
                          readOnly: true,
                          //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2100));
                            if (pickedDate != null) {
                              String formattedDate = DateFormat('dd/MM/yyyy')
                                  .format(pickedDate); //DateFormat.yMd(pickedDate) as String;
                              print('format dob-----$formattedDate');
                              setState(() {
                                joiningDateController.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            }

                          },
                        ),
                        TextFormField(
                          controller: updatesupervisorNameEditController,
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          decoration: InputDecoration(

                            labelText: 'Supervisor email *',
                            hintText: "Enter your supervisor email",
                            prefixIcon:
                            const Icon(Icons.supervisor_account, color: Colors.red),

                            hintStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey), //hint text style
                            labelStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                          ),
                          // maxLength: 100,

                          onSaved: (value) {
                            // _supervisorName = value;
                          },
                        ),
                        TextFormField(
                          controller: updateipAddressEditController,

                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          decoration: InputDecoration(

                            labelText: 'Home ip address (optional)',
                            labelStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.black38,
                                fontWeight: FontWeight.w700),
                            hintText: 'E.g. 192.16.1.1 or 192.16.1.1,192.16.1.5', //hint text
                            prefixIcon: const Icon(
                              Icons.location_on_outlined,
                              color: Colors.red,
                            ),

                            hintStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                        TextFormField(
                          controller: updatedeviceIdController,
                          validator: Validation().validateDeviceId,
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          decoration: InputDecoration(

                            labelText: 'Your device Id *',
                            hintText: "Enter your device Id",
                            prefixIcon:
                            const Icon(Icons.important_devices, color: Colors.red),
                            hintStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey), //hint text style
                            labelStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                          ),
                          onSaved: (value) {
                            // _userName = value;
                          },
                        ),


                        SizedBox(height: 10),
                        MaterialButton(
                          minWidth: 330,
                          color: const Color(0xFFB62021),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: const Text(
                            'Update',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          onPressed: () async {
                            var data;
                            if(_formKey.currentState!.validate()) {
                              var ipRef=(await FirebaseFirestore.instance.collection(extractDomain).doc(_searchUserController.text).get()).data();
                              String supervisor=updatesupervisorNameEditController.text;
                              List ip=updateipAddressEditController.text.split(',');
                              if(ipRef!.containsKey("homeipaddress")){
                                data=<String,dynamic>{
                                  "phone no":updatephoneEditController.text.toString(),
                                  // "phone no":'${dropdownValue.split(' ')[0]}${updatephoneEditController.text.toString()}',
                                  "secondary email":updatesecondaryEmailEditController.text.toString(),
                                  "supervisor email":supervisor,
                                  "deviceId":updatedeviceIdController.text.toString(),
                                  "date of birth":updatedateInputController.text.toString(),
                                  "joining date":updatejoiningDateController.text.toString(),
                                  "homeipaddress":FieldValue.arrayUnion(ip)

                                };
                              }else{
                                data=<String,dynamic>{
                                  "phone no":updatephoneEditController.text.toString(),
                                  "secondary email":updatesecondaryEmailEditController.text.toString(),
                                  "supervisor email":supervisor,
                                  "deviceId":updatedeviceIdController.text.toString(),
                                  "date of birth":updatedateInputController.text.toString(),
                                  "joining date":updatejoiningDateController.text.toString(),
                                  "homeipaddress":ip


                                };
                              }



                              print(phoneEditController.text);
                              print(supervisorNameEditController.text);
                              print(secondaryEmailEditController.text);
                              print(deviceIdController.text);
                              print(dateInputController.text);
                              print(joiningDateController.text);
                              FirebaseFirestore.instance.collection(extractDomain).doc(_searchUserController.text).update(data).then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AdminUpdateScreen())));
                            }
                          },
                        )
                      ],
                    )

                  ]
              ),
            ]
        ),

      ),
    );
  }


}

