

import 'dart:convert';
import 'package:http/http.dart' as http;



class SendingMail2{
  List<dynamic>? mailTo;
  String? subject;
  List? bccData;
  String? text;
  List<String>? ccData;
  bool? accountCreationMail;
  bool? otpSender;
  bool? registrationSuccessMail;
  bool? registerMail;
  bool? attendenceMailer;
  bool? birthdayMail;
  bool? workAnniverssary;
  bool? goodMorningTip;
  bool? attendenceWithoutAttach;
  bool? accountUpdate;
  List<int>? attachmentContent;
  Map? normalMailHTMLdata;
  List<dynamic>? htmlData;
  String? dailyTips;
  String? stringHTMLData;
  SendingMail2({
    this.subject,
    this.mailTo,
    this.text,
    this.ccData,
    this.attachmentContent,
    this.htmlData,
    this.attendenceMailer,
    this.birthdayMail,
    this.goodMorningTip,
    this.workAnniverssary,
    this.dailyTips,
    this.bccData,
    this.stringHTMLData,
    this.attendenceWithoutAttach,
    this.otpSender,
    this.normalMailHTMLdata,
    this.registrationSuccessMail,
    this.accountUpdate,
    this.registerMail,
    this.accountCreationMail
  });


  Future<Map> mailBody(SendingMail2 object)async{
    if(object.attendenceMailer ==true){
      var body={
        "data": {
          "mailTo":object.mailTo,
          "content":base64Encode(object.attachmentContent!),
          "htmldata":object.htmlData,
          "ccData":object.ccData,
          "attendenceMailer":true
        }
      };
      return body;

    }else if(object.attendenceWithoutAttach==true){
      var body={
        "data": {
          "mailTo":object.mailTo,
          "htmldata":object.htmlData,
          "ccData":object.ccData,
          "attendanceWithoutAttach":object.attendenceWithoutAttach
        }
      };
      return body;
    }else if(object.birthdayMail ==true){
      var body={
        "data": {
          "ccData":object.ccData,
          "birthdayMail":object.birthdayMail,
          "bccData":object.bccData,
          "htmldata":object.htmlData
        }
      };
      return body;
    }else if(object.workAnniverssary==true){
      var body={
        "data": {
          "ccData":object.ccData,
          "workAniversery":object.workAnniverssary,
          "htmldata":object.htmlData,
          "bccData":object.bccData
        }
      };
      return body;
    }else if(object.goodMorningTip==true){
      var body={
        "data": {
          "mailTo":object.mailTo,
          "dailyTip":object.goodMorningTip,
          "htmldata":object.dailyTips
        }
      };
      return body;
    }else if(object.otpSender==true){
      var body={
        "data": {
          "mailTo":object.mailTo,
          "htmldata":object.normalMailHTMLdata,
          "ccData":object.ccData,
          "normalMailWithHTML":object.otpSender,
          "subject":object.subject,
          "text":object.text
        }
      };
      return body;
    }else if(object.registrationSuccessMail==true){
      var body={
        "data": {
          "mailTo":object.mailTo,
          "htmldata":object.normalMailHTMLdata,
          "ccData":object.ccData,
          "registrationMail":object.registrationSuccessMail,
          "subject":object.subject
        }
      };
      return body;
    }else if(object.registerMail==true){
      var body={
        "data": {
          "mailTo":object.mailTo,
          "htmldata":object.normalMailHTMLdata,
          "ccData":object.ccData,
          "registerMail":object.registerMail,
          "subject":object.subject
        }
      };
      return body;
    }else if(object.accountUpdate==true){
      var body={
        "data": {
          "mailTo":object.mailTo,
          "htmldata":object.normalMailHTMLdata,
          "ccData":object.ccData,
          "accountUpdateMail":object.accountUpdate,
          "subject":object.subject
        }
      };
      return body;
    }else if(object.accountCreationMail==true){
      var body={
        "data": {
          "mailTo":object.mailTo,
          "htmldata":object.normalMailHTMLdata,
          "ccData":object.ccData,
          "accountCreationMail":object.accountCreationMail,
          "subject":object.subject
        }
      };
      return body;
    }else{
      var body={
        "data": {
          "mailTo":object.mailTo,
          "text":object.text,
          "subject":object.subject,
          "ccData":object.ccData
        }
      };
      return body;
    }

  }


  Future<void> sendMail(SendingMail2 object)async{
    final Map body=await mailBody(object);
    return await http
        .post(Uri.parse("https://us-central1-notification-sending-32c98.cloudfunctions.net/notificationSending1"), body: json.encode(body), headers: {
      'Content-Type': 'application/json',
    })
        .then((http.Response response) {
      //      print(response.body);
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 ) {
        throw Exception("Error while fetching data");
      }else{
        print(response.statusCode);
        print("successFully sent");}
    });
  }


}