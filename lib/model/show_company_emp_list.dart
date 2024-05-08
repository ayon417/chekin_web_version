import 'package:chekin_web_version/model/Google_Sign_In.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/download_excel.dart';

List empData=[];
int noOfEmployee=0;
List<bool> isClicked=[];
class EmployeeList{
  static void showEmployeeList(){
    var collection = FirebaseFirestore.instance.collection(extractDomain);
    collection.doc('config@${extractDomain}').snapshots().listen((docSnapshot) {
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()!;
        // You can then retrieve the value from the Map like this:
        empData = data['Employee List'];
        noOfEmployee=empData.length;
        print("No of emp is $noOfEmployee");
      }
    });

  }


}