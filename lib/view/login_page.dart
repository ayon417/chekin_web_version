import 'package:chekin_web_version/model/Google_Sign_In.dart';
import 'package:chekin_web_version/model/Microsoft_sign_in.dart';
import 'package:chekin_web_version/view/super_admin_page.dart';
// import 'package:chekin_web_registration/model/Google_Sign_In.dart';
// import 'package:chekin_web_registration/view/Form_Page.dart';
// import 'package:chekin_web_registration/view/super_admin_page.dart';
//import 'package:chekinweb/microsoftsignin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireauthweb;
import 'package:firebase_core/firebase_core.dart' as firecoreweb;

import 'Form_Page.dart';
import 'admin_page.dart';
import 'already_registered_user.dart';
//import 'googlesignin.dart';
//import 'admin_page.dart';
//import 'already_registered_user.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final fireauthweb.FirebaseAuth _auth = fireauthweb.FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        body: Container(
            width:MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(195, 20, 50, 1.0),
                    Color.fromRGBO(36, 11, 54, 1.0)
                  ]),
            ),

            child: SizedBox(
              width: double.infinity,
              child: LayoutBuilder(
                  builder: (context, snapshot) {
                    if(snapshot.maxWidth<610 || snapshot.maxHeight<400){
                      return ListView(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        //  crossAxisAlignment: CrossAxisAlignment.start,
                          children:  <Widget>[
                            Text(
                              "      Welcome to Chekin",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                  color: Colors.white),

                            ),
                            const SizedBox(height: 10),
                            Text(
                              "  The most secure authentication system for your business.\n    Introducing the next gen passwordless authentication .",

                              style: TextStyle(fontSize: 18.0, color: Colors.white),

                            ),

                            const SizedBox(height: 30),

                            SizedBox(
                              width: double.infinity,

                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom( primary:
                                  Colors.white10, shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [
                                      Image.asset("assets/images/google_logo.gif"),
                                      Text("o",style: TextStyle(fontSize:25,color: Colors.lightBlue),),
                                      Text("o",style: TextStyle(fontSize:25,color: Colors.redAccent)),
                                      Text("g",style: TextStyle(fontSize:25,color: Colors.yellow)),
                                      Text("l",style: TextStyle(fontSize:25,color: Colors.greenAccent)),
                                      Text("e",style: TextStyle(fontSize:25,color: Colors.lightBlue)),
                                      Text(" sign",style: TextStyle(fontSize:25,color: Colors.white70)),
                                      Text("in",style: TextStyle(fontSize:25,color: Colors.blueGrey)),

                                    ],

                                  ),
                                  onPressed:() {

                                    FirebaseAuthService().signInWithGoogle().then((value) {
                                      print("user exist value is $userExists");
                                      if(superAdminUserIsPresent==true){
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  SuperAdminPage()));
                                      }else if(adminUserIsPresent==true){
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  AdminPage()));
                                      }else if(normalUserIsPresent==true && userExists == false){
                                         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  const FormPage()));
                                      }else if(userExists== true){
                                         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  const AlreadyRegisteredPage()));
                                      }
                                      else{
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Unauthorized Access",
                                                style: TextStyle(
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,),
                                              backgroundColor: Color(0xFFB62021),
                                              action: SnackBarAction(
                                                label: 'dismiss',
                                                textColor: Colors.white,
                                                onPressed: () {
                                                  // Navigator.of(context).pop();
                                                },
                                              ),
                                            ));
                                      }
                                    });

                                    // GoogleWebSignIn().SignIn();
                                  }

                              ),
                            ),
                            const SizedBox(height: 20,),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom( primary:
                                  Colors.white10, shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(width: 51,),
                                      Image.asset("assets/images/Microsoft.gif"),
                                      SizedBox(width:1,height:1),
                                      const Text(" Mi",style: TextStyle(fontSize:25.0,color: Colors.lightBlue),),
                                      const Text("cr",style: TextStyle(fontSize:25.0,color: Colors.redAccent),),
                                      const Text("os",style: TextStyle(fontSize:25.0,color: Colors.yellow),),
                                      const Text("of",style: TextStyle(fontSize:25.0,color: Colors.greenAccent),),
                                      const Text("t",style: TextStyle(fontSize:25.0,color: Colors.lightBlue),),
                                      const Text(" sign",style: TextStyle(fontSize:25.0,color: Colors.white70),),
                                      const Text("in",style: TextStyle(fontSize:25.0,color: Colors.blueGrey),),

                                    ],

                                  ),
                                  onPressed:() {
                                   MicrosoftService().signInWithMicrosoft().then((value) =>
                                   {
                                     if(superAdminIsPresent==true)
                                       {
                                         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  SuperAdminPage()))
                                       }
                                   }
                                   );
                                  }

                              ),
                            ),
                            SizedBox(height: 20,),
                            Image.asset(
                              "assets/images/check_in.gif",
                              height: 218,

                            ),
                          ]

                      );
                      // SizedBox(height: 100),
                    }
                    else
                    {
                      return Row(
                          children: <Widget>[
                            SizedBox(width: 30),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    //  crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  <Widget>[
                                      Text(
                                        "      Welcome to Chekin",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 35.0,
                                            color: Colors.white),

                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "  The most secure authentication system for your business.\n    Introducing the next gen passwordless authentication .",
                                        style: TextStyle(fontSize: 18.0, color: Colors.white),

                                      ),

                                      const SizedBox(height: 30),

                                      SizedBox(
                                          width: double.infinity,

                                          child: ElevatedButton(

                                              style: ElevatedButton.styleFrom(

                                                primary: Colors.white10, shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(40.0))),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset("assets/images/google_logo.gif"),
                                                  Text("o",style: TextStyle(fontSize:25,color: Colors.lightBlue),),
                                                  Text("o",style: TextStyle(fontSize:25,color: Colors.redAccent)),
                                                  Text("g",style: TextStyle(fontSize:25,color: Colors.yellow)),
                                                  Text("l",style: TextStyle(fontSize:25,color: Colors.greenAccent)),
                                                  Text("e",style: TextStyle(fontSize:25,color: Colors.lightBlue)),
                                                  //Text(" sign",style: TextStyle(fontSize:25,color: Colors.white70)),
                                                  //Text("in",style: TextStyle(fontSize:25,color: Colors.blueGrey)),
                                                ],
                                              ),
                                              onPressed:()
                                                {
                                                FirebaseAuthService()
                                                    .signInWithGoogle()
                                                    .then((value) {
                                                  if (superAdminUserIsPresent == true)
                                                  {
                                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  SuperAdminPage()));
                                                       }
                                                  else if(adminUserIsPresent==true){
                                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  AdminPage()));
                                                       }
                                                  else if(normalUserIsPresent==true && userExists == false){
                                                         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  const FormPage()));
                                                       }
                                                  else if(userExists== true){
                                                         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  const AlreadyRegisteredPage()));
                                                       }
                                                  else
                                                  {
                                                        ScaffoldMessenger.of(context)
                                                             .showSnackBar(
                                                             SnackBar(
                                                               content: Text(
                                                                 "Unauthorized Access",
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
                                                     }
                                                     );
                                                  }
                                                  )
                                      ),




                                      SizedBox(height: 20,),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white10, shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(40.0))),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                //SizedBox(width: 0,),
                                                Image.asset("assets/images/Microsoft.gif"

                                                ),

                                                const Text(" Mi",style: TextStyle(fontSize:25.0,color: Colors.lightBlue),),
                                                const Text("cr",style: TextStyle(fontSize:25.0,color: Colors.redAccent),),
                                                const Text("os",style: TextStyle(fontSize:25.0,color: Colors.yellow),),
                                                const Text("of",style: TextStyle(fontSize:25.0,color: Colors.greenAccent),),
                                                const Text("t",style: TextStyle(fontSize:25.0,color: Colors.lightBlue),),
                                                //const Text(" sign",style: TextStyle(fontSize:25.0,color: Colors.white70),),
                                                //const Text("in",style: TextStyle(fontSize:25.0,color: Colors.blueGrey),),
                                              ],

                                            ),
                                            onPressed:()
                                            {
                                              MicrosoftService().signInWithMicrosoft().then((value) =>
                                              {
                                                if(superAdminIsPresent==true)
                                                  {
                                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  SuperAdminPage()))
                                                  }

                                              }
                                              );
                                            }

                                        ),
                                      ),
                                    ]

                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Flexible(


                              child: Image.asset(
                                "assets/images/check_in.gif",


                              ),

                            ),
                            SizedBox(width: 30),
                          ]


                      );
                    }

                  }
              ),
            )

        ),
      ),
    );
  }

}
