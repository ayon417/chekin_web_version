



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
String? name;
String? imageUrl;
String? emailId;
bool? emailVerified;
bool normalUserIsPresent=false;
bool adminUserIsPresent=false;
bool superAdminUserIsPresent=false;
bool userExists=false;
String extractDomain="";
String extractEmailId="";
class FirebaseAuthService extends StatelessWidget{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
    '91631303171-2ucsqtsdijfgjbqquimd5pejs5ka89nf.apps.googleusercontent.com'
  );

  var doc;

  Future <void> signInWithGoogle() async {
    // The `GoogleAuthProvider` can only be used while running on the web
    final authProvider = GoogleAuthProvider();
    try {
      final UserCredential userCredential = await _auth.signInWithPopup(authProvider);
      var collectionRef = FirebaseFirestore.instance.collection('SuperAdmin');
      doc= await collectionRef.doc(userCredential.user!.email).get();


      if (userCredential.user != null) {
        name = userCredential.user?.displayName;
        emailId = userCredential.user?.email;
        imageUrl = userCredential.user?.photoURL;
        emailVerified = userCredential.user?.emailVerified;
        print(name);
        print(emailId);
        print(emailVerified);

      }
    } catch (e) {
      print(e);
    }
    var superAdminUser = await FirebaseFirestore
        .instance.collection("SuperAdmin")
        .doc(emailId)
        .get();
    if (superAdminUser.exists == true) {
      print("The superadmin user $emailId is presents");
      superAdminUserIsPresent=true;
      print("The super admin user is $superAdminUserIsPresent");
    }else if(superAdminUser.exists==false){
      int lastIndex=emailId!.lastIndexOf('@');
      String domain=emailId!.substring(lastIndex+1,emailId!.length);
      extractDomain=emailId!.substring(lastIndex+1,emailId!.length);
      extractEmailId=emailId!;
      print("The extracted domain is ${extractDomain}");
      print("The extracted email is ${extractEmailId}");
      print("The domain is $domain");
      var normalUserCol = await FirebaseFirestore
          .instance.collection(domain)
          .get();
      if(normalUserCol.size !=0){
        var normalUser= await FirebaseFirestore
            .instance.collection(domain).doc(emailId).get();
        var alreadyRegisteredUser=(await FirebaseFirestore.instance.collection(domain).doc(emailId).get()).data();
        if(normalUser.exists == true){
          normalUserIsPresent=true;
          print("The normal user is $normalUserIsPresent");
          print("The user is in this $domain collection}");
          if(alreadyRegisteredUser!.containsKey("registration")){
            userExists=true;
              print("user exist is $userExists");
          }
        }
        else if(normalUser.exists==false){
          var adminUser=(await FirebaseFirestore
              .instance.collection(domain)
              .doc("config@$domain")
              .get()).data();
          List admin= adminUser!["AdminList"];
          if(admin.contains(emailId)){
            adminUserIsPresent=true;
            print("The admin user is $adminUserIsPresent");
            print("$emailId is the admin of $domain");
          }
        }
      }else if(normalUserCol.size==0){
        print("The user is unauthorized");
      }

    }
  }
  googleImageUrl() {

    return _auth.currentUser?.photoURL ?? 'https://lh3.googleusercontent.com/a/default-user=s160-c';
  }




  Future<void> signOutGoogle() async {
    await FirebaseAuth.instance.signOut();

    print("User signed out of Google account");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
