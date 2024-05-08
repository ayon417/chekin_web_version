
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class AlreadyRegisteredPage extends StatefulWidget {
  const AlreadyRegisteredPage ({super.key});

  @override
  State<StatefulWidget> createState() {
    return AlreadyRegisteredPageState();
  }
}

class AlreadyRegisteredPageState extends State<AlreadyRegisteredPage> {


  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body:  Stack(
        children: [
          Container(
            width: double.infinity,
            decoration:  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/page_background.jpg"),
                  fit: BoxFit.cover),

            ),
          ),
          Container(
            width: width / 4.0,
            height: height,
            color: Color(0xFFB62021),

          ),
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if(constraints.maxWidth>900 || constraints.maxHeight>700){
                  return Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.fromLTRB(10,110,0,0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Image.asset("assets/images/existUser.gif",width:470),


                              SizedBox(height: 5.0),
                              const Text( "Sorry for the inconvenience.\nFor further modification \nplease contact to your \nAdministrator.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              //  SizedBox(height: 50.0),
                            ],
                          ),
                        ),
                      ),
                      frostedGlassEffectDemo(context),
                    ],
                  );
                }else{
                  return ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,100,0,0),
                        child: Column(
                          children: <Widget>[
                            Image.asset("assets/images/existUser.gif",width:480),


                            SizedBox(height: 15.0),
                            const Text( "Sorry for the inconvenience.\nFor further modification \nplease contact to your \nAdministrator.",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            //  SizedBox(height: 50.0),
                          ],
                        ),
                      ),
                      frostedGlassEffectDemo(context),
                    ],
                  );
                }
              }
          ),

        ],
      ),
    );
  }
  Widget frostedGlassEffectDemo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,10,0,0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: Container(
                    height: 580,
                    width: 350,
                  ),
                ),
                Container(
                  height: 580,
                  width: 350,
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

                          Colors.grey.withOpacity(0.1),
                          Colors.grey.withOpacity(0.1),
                        ],
                        stops: [0.0, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(19)),
                  child: ListView(
                    children: [
                      Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 43,0,0),
                              child: Text(
                                "The latest version of the best software",
                                style: TextStyle(
                                  //color:  Colors.red,
                                  color: Color(0xFFB62021),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: <Widget>[Image.asset(
                                  "assets/images/lap.png",
                                  width: 280,
                                  height:280,
                                ),
                                  const Text(
                                    "Thank you for choosing Chekin",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    "Its pleasure to have you onboard.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    "Your device  can now be  used as another viable option for login. A notification has been send to you and your supervisor about your registration.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  RichText(
                                    text: TextSpan(
                                        text: "Getting started guide.",
                                        style: const TextStyle(
                                          color: Color(0xFFB62021),
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          fontSize: 15,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {

                                          }),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    "Check out the above guide to understand\nhow Chekin can serve you and your team.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                                    child: Text(
                                      "512,348,3427 ",
                                      style: TextStyle(
                                        color: Color(0xFFB62021),

                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0,0,0),
                                    child: Text(
                                      "Download served",
                                      style: TextStyle(
                                        color:  Colors.grey,

                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ]),
                    ],
                  ),
                ),
              ]
          )
      ),
    );
  }


}

