
import 'package:chekin_web_version/model/birthday_mail.dart';
import 'package:chekin_web_version/view/login_page.dart';
import 'package:chekin_web_version/view/superadmin_client_list.dart';
//import 'package:chekin_web_version/view/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:const FirebaseOptions(
      // apiKey: "AIzaSyBtdjKRpwQFK-NAttTo6ZCVkbNLu8MWy2E",
      // authDomain: "chekin-c5cf3.firebaseapp.com",
      // projectId: "chekin-c5cf3",
      // messagingSenderId: "507321655149",
      // appId: "1:507321655149:web:11ec1c1bdc121d6670c464",
        apiKey: "AIzaSyC082BAW64cTPI29TS-yJJWeJoX75qUiJs",
        authDomain: "firedemo-35d0f.firebaseapp.com",
        projectId: "firedemo-35d0f",
        storageBucket: "firedemo-35d0f.appspot.com",
        messagingSenderId: "851332011579",
        appId: "1:851332011579:web:826d39dd925fd11f14ae1e",
        measurementId: "G-P1S3CHL1VB"

    ),
  );
  ClientList.showClientList();
  //birthdayMaialer("18", "43");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:LoginPage(),
    );
  }
}

