
import 'package:flutter/material.dart';
import 'admin_responsive_page.dart';

int adminScreenSize=0;
int clientuser=0;
class AdminPage extends StatefulWidget{
  const AdminPage({super.key});

  @override
  State<AdminPage> createState()=> AdminPageState();
}

class AdminPageState extends State<AdminPage>{

  @override
  Widget build(BuildContext context) {

    return ScaffoldMessenger(
      child: Scaffold(
          body:Stack(
              alignment: Alignment.bottomLeft,
              children:[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/page_background.jpg'),
                      fit: BoxFit.cover,
                    ),

                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(
                    left:15,
                  ),
                  child:AdminPageResponsive(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,0,0,20),
                  child: Text("Admin Portal",style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),),
                ),
              ]
          )


      ),
    );
  }

}

