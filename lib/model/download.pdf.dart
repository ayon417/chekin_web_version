import 'dart:convert';
import 'dart:html';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../view/superadmin_client_list.dart';

void downloadPdf() async {
// Create a new PDF document.
  final PdfDocument document = PdfDocument();
// Add a new page to the document.
  final PdfPage page = document.pages.add();
// Create a PDF grid class to add tables.
  final PdfGrid grid = PdfGrid();
// Specify the grid column count.
  grid.columns.add(count: 6);
// Add a grid header row.
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  headerRow.cells[0].value = 'Domain Name';
  headerRow.cells[1].value = 'No of Users';
  headerRow.cells[2].value = 'Date From';
  headerRow.cells[3].value = 'Date To';
  headerRow.cells[4].value = 'Status';
  headerRow.cells[5].value = 'Admin Ids';
  print("no of client is $noOfClients");
  for(int i=0;i<noOfClients;i++){

    var clientDetails = (await FirebaseFirestore.instance
        .collection(clientData[i])
        .doc('config@${clientData[i]}')
        .get()).data();
    PdfGridRow row = grid.rows.add();
    row.cells[0].value = clientData[i];
    row.cells[1].value = clientDetails!["noOfSubscribers"];
    row.cells[2].value = clientDetails!["fromDate"];
    row.cells[3].value = clientDetails!["toDate"];
    row.cells[4].value = clientDetails!["status"];
    row.cells[5].value = clientDetails!["AdminList"].toString();

    print("clientDetails value $i is ${clientData[i]} is $clientDetails");
//  FetchFirebaseData().readFirestoreData(clientData[i],'config@${clientData[i]}');

    // print("excel sub value is ${FetchFirebaseData.sub}");
    print("sub is ${clientDetails!["noOfSubscribers"]}");
    print("fdate is ${clientDetails!["fromDate"]}");
    print("todate is ${clientDetails!["toDate"]}");
    print("status is ${clientDetails!["status"]}");



  }
// Set header font.
  headerRow.style.font =
      PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);
// Add rows to the grid.

// Set grid format.
  grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
// Draw table in the PDF page.
  grid.draw(
      page: page,
      bounds: Rect.fromLTWH(
          0, 0, page.getClientSize().width, page.getClientSize().height));


  final List<int> bytes = await document.save();
  document.dispose();

  if (kIsWeb) {
    //Download the output file in web.
    AnchorElement(
        href:
        "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "output.pdf")
      ..click();
  }

}