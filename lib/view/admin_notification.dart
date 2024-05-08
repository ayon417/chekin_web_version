
import 'package:chekin_web_version/model/Google_Sign_In.dart';
import 'package:chekin_web_version/view/mailNotification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

bool isChecked = false;
bool isCheckedBday = false;
bool isCheckedAnniversaryDay = false;
bool isChecked3 = false;
bool isPresent=false;
bool isPresentWork=false;
String str='';
String str1='';

class AdminNotification extends StatefulWidget {
  const AdminNotification({Key? key}) : super(key: key);

  @override
  State<AdminNotification> createState() =>
      _AdminNotificationState();
}

class _AdminNotificationState extends State<AdminNotification> {
  TimeOfDay initialTime=TimeOfDay.now();
  TimeOfDay initialTimeForBday=TimeOfDay.now();
  final Stream<QuerySnapshot> tipOfDayStream =
  FirebaseFirestore.instance.collection('tipOfDayConfig').snapshots();

  TimeOfDay _timeOfDay = TimeOfDay(hour: 9, minute: 30);
  void _showTimePicker(StateSetter setState) {
    showTimePicker(
      context: context,
      initialTime: _timeOfDay,
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    checkTime();
    fetchData();

  }

  checkTime() async {
    var v= (await FirebaseFirestore.instance.collection(extractDomain).doc("config@$extractDomain").get()).data();
    if(v!.containsKey("birthdayTime")==true){
      print("key is present");
      setState(() {
        str=v["birthdayTime"];
        print("String is $str");
      });

      isPresent=true;
      print("Val  is $isPresent");
    }
    if(v!.containsKey("anniversaryTime")==true){
      print(" Anniversary key is present");
      setState(() {
        str1=v["anniversaryTime"];
        print("String is $str1");
      });

      isPresentWork=true;
      print("Val  is $isPresentWork");
    }
  }
  Future<void> fetchData() async {
    var check=(await FirebaseFirestore.instance.collection(extractDomain).doc("config@$extractDomain").get()).data();
    if(check!["isCheckedBday"]==true){
      setState(() {
        isCheckedBday=true;
      });
    }else if(check.containsKey("isCheckedBday")==false){
      FirebaseFirestore.instance.collection(extractDomain).doc("config@$extractDomain").update({"isCheckedBday":false});
    }else{
      isCheckedBday=false;
    }
    print("bday is $isCheckedBday");

    if(check!["isCheckedAnniversaryDay"]==true){
      setState(() {
        isCheckedAnniversaryDay=true;
      });
    }else if(check.containsKey("isCheckedAnniversaryDay")==false){
      FirebaseFirestore.instance.collection(extractDomain).doc("config@$extractDomain").update({"isCheckedAnniversaryDay":false});
    }else{
      isCheckedAnniversaryDay=false;
    }
    print("work anniversary day is $isCheckedAnniversaryDay");
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
        elevation: 1,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        actions:[
          Column(
            children: [
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(''),
                  RichText(
                    text: const TextSpan(
                        text: 'Notification\n',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.red),
                        children: [
                          TextSpan(
                            text: 'Preferences\nBeta (Under Maintenance)',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          )
                        ]),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Divider(color: Color(0xFFB62021)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(

                  children: [
                    const Text(
                      'Tip of the day',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: ((context, setState) => Dialog(
                                        elevation: 3,
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15)),
                                        child: Container(
                                          width: 550,
                                          height: 340,
                                          // color: Colors.red,
                                          child: DefaultTabController(
                                            length: 2,
                                            initialIndex: 1,
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 40,
                                                  child: const TabBar(
                                                      labelStyle: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                      indicatorColor:
                                                      Color(0xFFB62021),
                                                      unselectedLabelColor:
                                                      Colors.grey,
                                                      labelColor:
                                                      Color(0xFFB62021),
                                                      indicator:
                                                      BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(
                                                                8),
                                                            topRight: Radius
                                                                .circular(
                                                                15)),
                                                        color: Color.fromARGB(
                                                            255,
                                                            227,
                                                            222,
                                                            222),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                            Colors.black,
                                                            offset: Offset(
                                                              5.0,
                                                              5.0,
                                                            ), //Offset
                                                            blurRadius: 5.0,
                                                            spreadRadius: 1.0,
                                                          ), //BoxShadow
                                                          BoxShadow(
                                                            color:
                                                            Colors.white,
                                                            offset: Offset(
                                                                0.0, 0.0),
                                                            blurRadius: 0.0,
                                                            spreadRadius: 0.0,
                                                          ), //BoxShadow
                                                        ],
                                                      ),
                                                      tabs: [
                                                        Tab(
                                                          text: "Clock",
                                                        ),
                                                        Tab(
                                                          text: "Tip of Day",
                                                        ),
                                                      ]),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 280,
                                                  child: TabBarView(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          const SizedBox(
                                                              height: 10),
                                                          Text(
                                                            _timeOfDay
                                                                .format(
                                                                context)
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 60,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          ElevatedButton(
                                                            onPressed: () =>
                                                                _showTimePicker(
                                                                    setState),
                                                            style:
                                                            ElevatedButton
                                                                .styleFrom(
                                                              primary:
                                                              const Color(
                                                                  0xFFB62021),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      5)),
                                                            ),
                                                            child: const Text(
                                                                'Pick Time'),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            left: 8,
                                                            right: 10,
                                                            top: 8),
                                                        child: StreamBuilder<
                                                            QuerySnapshot>(
                                                            stream:
                                                            tipOfDayStream,
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasError) {
                                                                print(
                                                                    'Something went wrong');
                                                              }
                                                              if (snapshot
                                                                  .connectionState ==
                                                                  ConnectionState
                                                                      .waiting) {
                                                                return const Center(
                                                                  child:
                                                                  CircularProgressIndicator(),
                                                                );
                                                              }
                                                              Map<String,
                                                                  dynamic>
                                                              tipsOfDayData =
                                                              {};
                                                              snapshot
                                                                  .data!.docs
                                                                  .map((DocumentSnapshot
                                                              document) {
                                                                Map a = document
                                                                    .data()
                                                                as Map<
                                                                    String,
                                                                    dynamic>;

                                                                tipsOfDayData = Map<
                                                                    String,
                                                                    dynamic>.from(a[
                                                                'tipOfDay']
                                                                as Map);

                                                                /*  tipsOfDayData
                                                                      .forEach((k,
                                                                              v) =>
                                                                          print(
                                                                              '---${k}: ${v}'));  */
                                                              }).toList();

                                                              return ListView(
                                                                children: [
                                                                  for (var key
                                                                  in tipsOfDayData
                                                                      .keys) ...[
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.only(bottom: 5),
                                                                      child:
                                                                      EditTipOfDayWidget(
                                                                        tipDate:
                                                                        key,
                                                                        tipTitle:
                                                                        tipsOfDayData[key],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ],
                                                              );
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )));
                                });
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black54,
                            size: 18,
                          ),
                        ),
                        Checkbox(

                          checkColor: Colors.white,
                          fillColor: MaterialStateColor.resolveWith((states) => Colors.redAccent),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });


                          },
                        ),

                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(

                  children: [
                    Text(
                      'Birth Anniversary',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                    Row(
                      children: [


                        IconButton(
                          onPressed: () async {

                            TimeOfDay? time= await showTimePicker(
                              initialTime: initialTime,
                              context: context,

                            );
                            setState(() {
                              initialTime=time!;
                            });
                            String s=time.toString();
                            str=s.substring(s.lastIndexOf('(')+1,s.lastIndexOf(')'));
                            FirebaseFirestore.instance.collection(extractDomain).doc("config@$extractDomain").update({"birthdayTime":str});
                            print("time is $str");

                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black54,
                            size: 18,
                          ),
                        ),
                        Checkbox(

                          checkColor: Colors.white,
                          fillColor: MaterialStateColor.resolveWith((states) => Colors.redAccent),
                          value: isCheckedBday,
                          onChanged: (bool? value) {
                            setState(() {
                              isCheckedBday = value!;
                              FirebaseFirestore.instance.collection(extractDomain).doc("config@$extractDomain").update({"isCheckedBday":isCheckedBday});
                              print("The value of ischecked is $isCheckedBday");

                            });


                          },
                        ),
                        isPresent==true?Padding(
                          padding: const EdgeInsets.fromLTRB(5,0,0,0),
                          child: Text(
                            'Time:$str',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
                          ),
                        ):Text(''),

                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(

                  children: [
                    Text(
                      'Work Anniversary',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            TimeOfDay? time= await showTimePicker(
                              initialTime: initialTimeForBday,
                              context: context,

                            );
                            setState(() {
                              initialTimeForBday=time!;
                            });
                            String s=time.toString();
                            str1=s.substring(s.lastIndexOf('(')+1,s.lastIndexOf(')'));
                            FirebaseFirestore.instance.collection(extractDomain).doc("config@$extractDomain").update({"anniversaryTime":str1});
                            print("time is $str1");

                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black54,
                            size: 18,
                          ),
                        ),
                        Checkbox(

                          checkColor: Colors.white,
                          fillColor: MaterialStateColor.resolveWith((states) => Colors.redAccent),
                          value: isCheckedAnniversaryDay,
                          onChanged: (bool? value) {
                            setState(() {
                              isCheckedAnniversaryDay = value!;
                              FirebaseFirestore.instance.collection(extractDomain).doc("config@$extractDomain").update({"isCheckedAnniversaryDay":isCheckedAnniversaryDay});
                              print("The value of ischecked is $isCheckedAnniversaryDay");
                            });


                          },
                        ),
                        isPresentWork==true?Padding(
                          padding: const EdgeInsets.fromLTRB(5,0,0,0),
                          child: Text(
                            'Time:$str1',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
                          ),
                        ):Text(''),

                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(

                  children: [
                    const Text(
                      'Daily Attendance',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black54,
                            size: 18,
                          ),
                        ),
                        Checkbox(

                          checkColor: Colors.white,
                          fillColor: MaterialStateColor.resolveWith((states) => Colors.redAccent),
                          value: isChecked3,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked3 = value!;
                            });


                          },
                        ),

                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ]

    );

  }

}

class EditTipOfDayWidget extends StatefulWidget {
  final String tipDate;
  final String tipTitle;
  const EditTipOfDayWidget({
    Key? key,
    required this.tipDate,
    required this.tipTitle,
  }) : super(key: key);

  @override
  State<EditTipOfDayWidget> createState() => _EditTipOfDayWidgetState();
}

class _EditTipOfDayWidgetState extends State<EditTipOfDayWidget> {
  var __tipController = TextEditingController();
  @override
  void initState() {
    __tipController = TextEditingController.fromValue(TextEditingValue(
        text: widget.tipTitle,
        selection: TextSelection.collapsed(offset: widget.tipTitle.length)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 38,
          decoration: const BoxDecoration(
            color: Color(0xFFB62021),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(
                  5.0,
                  5.0,
                ), //Offset
                blurRadius: 5.0,
                spreadRadius: 1.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(widget.tipDate,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Container(
            // width: 100,
            height: 38,
            decoration: const BoxDecoration(
              // color: Color(
              //     0xFFB62021),
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  // color:
                  //     Colors.black,
                  color: Color(0xFFB62021),
                  offset: Offset(
                    5.0,
                    5.0,
                  ), //Offset
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
            ),
            child: TextFormField(
              controller: __tipController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.start,
              style: const TextStyle(color: Colors.blueGrey, fontSize: 14),
              decoration: InputDecoration(
                  suffix: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: IconButton(
                      tooltip: 'Save',
                      color: Colors.blueGrey,
                      iconSize: 20,
                      icon: Icon(Icons.save_sharp),
                      onPressed: () {
                        updateTipInDatabase(__tipController.text, widget.tipDate)
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              backgroundColor: Color(0xFFB62021),
                              content: Text(
                                'Updated Successfully',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              )));
                        });
                      },
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> updateTipInDatabase(String tipTitle, String tipDate) {
    print('yyyy--$tipDate = $tipTitle');
    return FirebaseFirestore.instance
        .collection("tipOfDayConfig")
        .doc("tipOfDayList")
        .set({
      'tipOfDay': {tipDate: tipTitle},
    }, SetOptions(merge: true)).then((_) {
      print("success!");
    });
  }
}
