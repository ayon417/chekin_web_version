import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/download_excel.dart';

List clientData=[];
int noOfClients=0;
List<bool> isClicked=[];
class ClientList{
  static void showClientList(){
    var collection = FirebaseFirestore.instance.collection('SuperAdmin');
    collection.doc('List of Clients').snapshots().listen((docSnapshot) {
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()!;
        // You can then retrieve the value from the Map like this:
        clientData = data['Client List'];
        noOfClients=clientData.length;
        isClicked= List.filled(noOfClients, true,growable: true);

        print("Name value is $noOfClients");
        print("is clicked is $isClicked");


      }
    });

  }


}