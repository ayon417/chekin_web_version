import 'package:chekin_web_version/model/Google_Sign_In.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/download_excel.dart';

List ipData=[];
List<bool> isClicked=[];
class OrganizationIpList{
  static void showIpList(){
    var collection = FirebaseFirestore.instance.collection(extractDomain);
    collection.doc('config@${extractDomain}').snapshots().listen((docSnapshot) {
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()!;
        // You can then retrieve the value from the Map like this:
        ipData = data['Organizational Ip'];
        print("List of IP is $ipData");
      }
    });

  }


}