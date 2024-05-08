import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireauthweb;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
bool superAdminIsPresent=false;
class MicrosoftService extends StatelessWidget {
  final fireauthweb.FirebaseAuth _auth = fireauthweb.FirebaseAuth.instance;
  MicrosoftService({Key? key}) : super(key: key);
  Future<void> signInWithMicrosoft() async
  {
    if(!kIsWeb)
    {
    }
    else {
      final authProvider = fireauthweb.MicrosoftAuthProvider();
      authProvider.addScope('mail.read');
      try {
        final fireauthweb.UserCredential userCredential =
        await _auth.signInWithPopup(authProvider);
        if (userCredential.user != null)
        {
          var value=userCredential.user!.email;
          int lastIndex=value!.lastIndexOf('@');
          String? domain= value.substring(lastIndex+1,value.length);
          var superAdminUser = await FirebaseFirestore.instance.collection('SuperAdmin').doc(value).get();
          if(superAdminUser.exists==true)
          {
            print("super admin exists");
            superAdminIsPresent=true;
          }


          // Navigator.pushReplacement(context, MaterialPageRoute
          //   (builder: (context)=>ShowUser(eMail: value,)));
          // name = userCredential.user?.displayName;
          // emailId = userCredential.user?.email;
          // imageUrl = userCredential.user?.photoURL;
          // emailVerified = userCredential.user?.emailVerified;
        }
      } catch (e) {
        print(e);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
