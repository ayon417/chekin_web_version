
import 'dart:ui';


import 'package:chekin_web_version/view/admin_responsive_page.dart';
import 'package:chekin_web_version/view/user_form_registration_success_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/Google_Sign_In.dart';
import '../model/validation.dart';
import 'Chekin_download_button.dart';

import 'login_page.dart';
import 'user_form_info.dart';
import 'package:intl/intl.dart';

TextEditingController secondaryEmailEditController = TextEditingController();
TextEditingController supervisorNameEditController = TextEditingController();
TextEditingController phoneEditController = TextEditingController();
TextEditingController deviceIdController = TextEditingController();
TextEditingController ipAddressEditController = TextEditingController();
TextEditingController dateInputController = TextEditingController();
TextEditingController joiningDateController = TextEditingController();


class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {



  String dropdownValue = '+91 (IND)';

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2022, 10, 10),
    end: DateTime(2022, 10, 10),
  );
  get newDateRange => null;


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    FirebaseAuthService().googleImageUrl();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Stack(
          children:[
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/page_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only( top: 40,
                  left:15,
                  // bottom: deviceHeight(context) * 0.01,
                  // right: deviceWidth(context) * 0.09,
                ),
                child: LayoutBuilder(

                    builder: (context, constraints) {
                      if(constraints.maxWidth>900 || constraints.maxHeight>700){
                        return ListView(
                            children: [
                              Row(
                                children: [

                                  Flexible(
                                    child: Container(
                                      height: 380,
                                      width: 250,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/background_image.png'),
                                          fit: BoxFit.cover,
                                        ),

                                      ),


                                      child:UserFormInfo(),
                                    ),
                                  ),
                                  Container(
                                    height: 380,
                                    width: 250,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/background_image.png'),
                                        fit: BoxFit.cover,
                                      ),

                                    ),

                                    child: const DownLoadApp(),
                                  ),
                                  BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 8,
                                      sigmaY: 8,
                                    ),

                                  ),
                                  userForm(context)
                                ],
                              ),
                            ]
                        );
                      }else{
                        return ListView(
                            children:[
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Container(
                                          height: 380,
                                          width: 250,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/background_image.png'),
                                              fit: BoxFit.cover,
                                            ),

                                          ),

                                          child:UserFormInfo(),
                                        ),
                                      ),
                                      Container(
                                        height: 380,
                                        width: 250,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/background_image.png'),
                                            fit: BoxFit.cover,
                                          ),

                                        ),

                                        child: const DownLoadApp(),
                                      ),
                                    ],
                                  ),

                                  BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 8,
                                      sigmaY: 8,
                                    ),

                                  ),
                                  userForm(context)

                                ],
                              ),
                            ]
                        );
                      }

                    }
                ),
              ),
            ),]
      ),
    );
  }


  Widget userForm(BuildContext context){
    return  Form(
      key: _formKey,
      child: Container(

        height:580,
        width: 350,

        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.transparent,
            )
          ],
          border:
          Border.all(color: Colors.black.withOpacity(0.5), width: 0.5),
          gradient: LinearGradient(
            colors: [
              Colors.white60.withOpacity(0.0),
              Colors.transparent.withOpacity(0.0),
            ],
            stops: const [0.0, 1.0],
          ),
          borderRadius: BorderRadius.circular(20),
        ),

        child: ListView(
            children:[
              Column(
                  children:[
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        const Text(
                          'Step:2',

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.blueGrey,
                          ),
                        ),
                        //SizedBox(width: 150,),
                        IconButton(

                          iconSize: 18,
                          icon: const Icon(
                            Icons.logout,
                          ),
                          onPressed: () {
                            FirebaseAuthService().signOutGoogle().then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  LoginPage())));;
                          },
                        ),

                      ],
                    ),
                    SizedBox(width: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Column(
                            children:[
                              Text(name!),
                              Text(emailId!)
                            ]

                        ),
                        CircleAvatar(
                          radius: 40,
                          // Image radius
                          backgroundImage: NetworkImage(
                            FirebaseAuthService().googleImageUrl(),
                            scale: 1,
                            // imageUrl ?? 'https://lh3.googleusercontent.com/a/default-user=s160-c',
                            //    'https://thumbs.dreamstime.com/b/cartoon-cute-man-red-background-art-cartoon-cute-man-red-background-194213394.jpg',
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: phoneEditController,
                          validator: Validation().validatePhoneNo,
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          decoration: InputDecoration(
                            prefix: DropdownButton(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 10,
                              isDense: true,
                              dropdownColor: const Color(0xFFEEEAE8),
                              style: const TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.w700),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>['+91 (IND)', '+1 (US)', '+65 (SG)']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            labelText: 'Phone number *',
                            hintText: "Enter your phone number", //hint text
                            prefixIcon: const Icon(Icons.phone, color: Colors.red),
                            hintStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey), //hint text style
                            labelStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                          ),
                          keyboardType: TextInputType.phone,
                          onSaved: (value) {
                            //  phoneEditController.text=value!;
                            // _phoneNumber = value;
                          },
                        ),
                        TextFormField(
                          // initialValue: 'hello@gmail.com',
                          controller:secondaryEmailEditController,
                          validator: Validation().validateEmail,
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          decoration: InputDecoration(

                            labelText: 'Secondary Email *',
                            hintText: "Enter your secondary email id", //hint text
                            prefixIcon: const Icon(Icons.email, color: Colors.red),
                            hintStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey), //hint text style
                            labelStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                          ),


                        ),
                        TextFormField(
                          controller: dateInputController,
                          validator: Validation().validateDate,
                          style: const TextStyle(
                              color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 16),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.calendar_today, color: Colors.red),
                            //icon of text field
                            labelText: "Enter Date of Birth *",
                            labelStyle: TextStyle(
                                fontSize: 14, color: Colors.black38, fontWeight: FontWeight.w600),
                            //label text of field
                          ),
                          readOnly: true,
                          //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2100));
                            if (pickedDate != null) {
                              String formattedDate = DateFormat('dd/MM/yyyy')
                                  .format(pickedDate); //DateFormat.yMd(pickedDate) as String;
                              print('format dob-----$formattedDate');
                              setState(() {
                                dateInputController.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            }

                          },
                        ),
                        TextFormField(
                          controller: joiningDateController,
                          validator: Validation().validateDate,
                          style: const TextStyle(
                              color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 16),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.calendar_today, color: Colors.red),
                            //icon of text field
                            labelText: "Enter Date of Joining *",
                            labelStyle: TextStyle(
                                fontSize: 14, color: Colors.black38, fontWeight: FontWeight.w600),
                            //label text of field
                          ),
                          readOnly: true,
                          //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2100));
                            if (pickedDate != null) {
                              String formattedDate = DateFormat('dd/MM/yyyy')
                                  .format(pickedDate); //DateFormat.yMd(pickedDate) as String;
                              print('format dob-----$formattedDate');
                              setState(() {
                                joiningDateController.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            }

                          },
                        ),
                        TextFormField(
                          controller: supervisorNameEditController,
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          decoration: InputDecoration(
                            suffix: Text(
                              '@$extractDomain',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            labelText: 'Supervisor email *',
                            hintText: "Enter your supervisor email",
                            prefixIcon:
                            const Icon(Icons.supervisor_account, color: Colors.red),

                            hintStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey), //hint text style
                            labelStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                          ),
                          // maxLength: 100,

                          onSaved: (value) {
                            // _supervisorName = value;
                          },
                        ),
                        TextFormField(
                          controller: ipAddressEditController,

                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          decoration: InputDecoration(

                            labelText: 'Home ip address (optional)',
                            labelStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.black38,
                                fontWeight: FontWeight.w700),
                            hintText: 'E.g. 192.16.1.1 or 192.16.1.1,192.16.1.5', //hint text
                            prefixIcon: const Icon(
                              Icons.location_on_outlined,
                              color: Colors.red,
                            ),

                            hintStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                        TextFormField(
                          controller: deviceIdController,
                          validator: Validation().validateDeviceId,
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          decoration: InputDecoration(

                            labelText: 'Your device Id *',
                            hintText: "Enter your device Id",
                            prefixIcon:
                            const Icon(Icons.important_devices, color: Colors.red),
                            hintStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey), //hint text style
                            labelStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                          ),
                          onSaved: (value) {
                            // _userName = value;
                          },
                        ),


                        SizedBox(height: 10),
                        MaterialButton(
                          minWidth: 330,
                          color: const Color(0xFFB62021),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          onPressed: () async {
                            var data;
                            if(_formKey.currentState!.validate()) {
                              String supervisor=supervisorNameEditController.text+'@'+extractDomain.toString();
                              if(ipAddressEditController.text.isEmpty){
                                data=<String,dynamic>{
                                  "phone no":'${dropdownValue.split(' ')[0]}${phoneEditController.text.toString()}',
                                  "secondary email":secondaryEmailEditController.text.toString(),
                                  "supervisor email":supervisor,
                                  "deviceId":deviceIdController.text.toString(),
                                  "date of birth":dateInputController.text.toString(),
                                  "joining date":joiningDateController.text.toString(),
                                  "registration":"Done",
                                };
                              }else{
                                data=<String,dynamic>{
                                  "phone no":'${dropdownValue.split(' ')[0]}${phoneEditController.text.toString()}',
                                  "secondary email":secondaryEmailEditController.text.toString(),
                                  "supervisor email":supervisor,
                                  "homeipaddress":ipAddressEditController.text.split(','),
                                  "deviceId":deviceIdController.text.toString(),
                                  "date of birth":dateInputController.text.toString(),
                                  "joining date":joiningDateController.text.toString(),
                                  "registration":"Done",
                                };
                              }

                              print(phoneEditController.text);
                              print(supervisorNameEditController.text);
                              print(secondaryEmailEditController.text);
                              print(deviceIdController.text);
                              print(dateInputController.text);
                              print(joiningDateController.text);
                              FirebaseFirestore.instance.collection(extractDomain).doc(emailId).update(data).then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserFormSuccess())));
                            }
                          },
                        )
                      ],
                    )

                  ]
              ),
            ]
        ),

      ),
    );
  }
}


