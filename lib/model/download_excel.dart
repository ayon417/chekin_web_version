import 'dart:convert';
import 'dart:html';

import 'package:chekin_web_version/model/Fetch_Firebase_Data.dart';
import 'package:chekin_web_version/view/superadmin_client_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:syncfusion_flutter_xlsio/xlsio.dart';


void downloadExcel() async {
  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];
  // ExcelSheetProtectionOption
  final ExcelSheetProtectionOption options =
  ExcelSheetProtectionOption();
  options.all = true;
  // Protecting the Worksheet by using a Password
  sheet.protect('chekin', options);
  // Enable calculation for worksheet.
  sheet.enableSheetCalculations();

  //set coloumn width
  sheet.getRangeByName('A1').columnWidth = 20.00;
  sheet.getRangeByName('B1').columnWidth = 15.00;
  sheet.getRangeByName('C1').columnWidth = 15.00;
  sheet.getRangeByName('D1').columnWidth = 15.00;
  sheet.getRangeByName('E1').columnWidth = 15.00;
  sheet.getRangeByName('F1:G1').columnWidth = 20;
  //Applying Number format.
  final Range rangeHeader = sheet.getRangeByName('A1:G1');
  rangeHeader.cellStyle.fontSize = 11;
  rangeHeader.cellStyle.bold = true;
  rangeHeader.cellStyle.hAlign = HAlignType.left;
  rangeHeader.cellStyle.vAlign = VAlignType.center;
  rangeHeader.cellStyle.backColor = '#FDD1D1';
  rangeHeader.cellStyle.fontColor = '#B62021';
  rangeHeader.cellStyle.borders.all.color = '#B62021';
  rangeHeader.cellStyle.borders.bottom.lineStyle = LineStyle.thick;

  sheet.getRangeByName('A1').setText('Domain Name');
  sheet.getRangeByName('B1').setText('No of Users');
  sheet.getRangeByName('C1').setText('Date From');
  sheet.getRangeByName('D1').setText('Date To');
  sheet.getRangeByName('E1').setText('Status');
  sheet.getRangeByName('F1').setText('Admin Ids');
  var index = 2;
  for(int i=0;i<noOfClients;i++){
    sheet.getRangeByName('A${i+index}').setText(clientData[i]);
    var clientDetails = (await FirebaseFirestore.instance
        .collection(clientData[i])
        .doc('config@${clientData[i]}')
        .get()).data();

    print("clientDetails value $i is ${clientData[i]} is $clientDetails");
//  FetchFirebaseData().readFirestoreData(clientData[i],'config@${clientData[i]}');

    // print("excel sub value is ${FetchFirebaseData.sub}");
    print("sub is ${clientDetails!["noOfSubscribers"]}");
    print("fdate is ${clientDetails!["fromDate"]}");
    print("todate is ${clientDetails!["toDate"]}");
    print("status is ${clientDetails!["status"]}");
//  String client=clientDetails["AdminList"];
    String client=clientDetails["AdminList"].join(',');
    print(client);
    sheet.getRangeByName('B${i+index}').setText(clientDetails!["noOfSubscribers"]);
    sheet.getRangeByName('C${i+index}').setText(clientDetails!["fromDate"]);
    sheet.getRangeByName('D${i+index}').setText(clientDetails!["toDate"]);
    sheet.getRangeByName('E${i+index}').setText(clientDetails!["status"]);
    sheet.getRangeByName('F${i+index}').setText(client);


  }
  sheet.autoFitColumn(6);
  sheet.getRangeByName('A${noOfClients+index}:F${noOfClients+index}').cellStyle.backColor ='#B62021';
  // Save and dispose the document.
  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();
  if (kIsWeb) {
    //Download the output file in web.
    AnchorElement(
        href:
        "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "output.xlsx")
      ..click();
  }
}
