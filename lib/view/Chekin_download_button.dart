
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DownLoadApp extends StatelessWidget {
  const DownLoadApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Step: 1",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Align(
          alignment: Alignment.topCenter,
          child: Text(
            "To find your device id click and install one of the below mentioned desktop   application installer based on your    operating system and follow the",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Text("Instruction Link",style: TextStyle(fontSize: 18,color: Colors.white,decoration:TextDecoration.underline,),),
        const SizedBox(height: 20,),
        Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          child: MaterialButton(
            color: const Color(0xFFB62021),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: const Text(
              'WINDOWS DOWNLOAD',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            onPressed: () {},
          ),
        ),
        const SizedBox(height:15),
        Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          child: MaterialButton(
            color: const Color(0xFFB62021),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: const Text(
              'LINUX DOWNLOAD',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 15,),
        Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          child: MaterialButton(
            color: const Color(0xFFB62021),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: const Text(
              'MAC DOWNLOAD',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget getGuideUrl(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom:
          BorderSide(color: Color.fromARGB(255, 240, 206, 206), width: 2.0),
        ),
      ),
      child: RichText(
        text: TextSpan(
            text: "instruction link",
            style: const TextStyle(
              // color: Color(0xFFFDD1D1),
              color: Color.fromARGB(255, 240, 206, 206),
              fontWeight: FontWeight.bold,
              // decoration: TextDecoration.underline,
              fontSize: 20,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                //TODO: need to implement
                // final Uri uriUpdated = Uri(
                //     scheme: 'https',
                //     host: 'in.docworkspace.com',
                //     path: 'l/sIMOp4PWUAdf30JYG');
                // var url = 'https://in.docworkspace.com/d/sIMOp4PWUAdf30JYG';
                // if (await canLaunchUrl(uriUpdated)) {
                //   await launchUrl(uriUpdated);
                // } else {
                //   throw 'Could not launch $uriUpdated';
                // }
              }),
      ),
    );
  }
}
