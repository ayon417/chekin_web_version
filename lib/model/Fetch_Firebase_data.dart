import 'package:cloud_firestore/cloud_firestore.dart';

import '../view/superadmin_client_list.dart';

/**import 'package:cloud_firestore/cloud_firestore.dart';
    import 'package:flutter/cupertino.dart';
    import 'package:flutter/material.dart';

    import '../view/super_admin_page.dart';


    var doc;
    checkIfDocExists(String docId) async {
    try {
    // Get reference to Firestore collection
    var collectionRef = FirebaseFirestore.instance.collection('SuperAdmin');

    doc = await collectionRef.doc(docId).get();


    return doc.exists;
    } catch (e) {
    throw e;
    }
    }*/



String fDate='';
String toDate='';
class FetchFirebaseData{
  static var sub;
  Map<String, dynamic> cdata={};
  void readFirestoreData(var coll,var docId) async {
    var data1 = (await FirebaseFirestore.instance
        .collection(coll)
        .doc(docId)
        .get()).data();

    print("Data 1 value is $data1");
    sub =data1!["noOfSubscribers"];
    print("Sub is $sub");

  }

/** void readFirestoreData(){
    for (int i = 0; i < noOfClients; i++) {
    var collection = FirebaseFirestore.instance.collection(clientData[i]);
    collection.doc('config@${clientData[i]}').snapshots().listen((
    docSnapshot) {
    if (docSnapshot.exists) {

    cdata= docSnapshot.data()!;
    sub=cdata["noOfSubscribers"];
    fDate=cdata["fromDate"];
    toDate=cdata["toDate"];
    print("check $cdata");


    }

    });
    print("Static sub is $sub");
    }*/

}
//}