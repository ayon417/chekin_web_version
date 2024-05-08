import 'package:syncfusion_flutter_xlsio/xlsio.dart' ;




///////////////////////Fetch all data for one single Domain///////////////////////////////
Future<List>fetchingDataSingleDomain(Map singleDomainData)async{
  List keys=singleDomainData.keys.toList();
  List data=[];
  for(int i=0;i<keys.length;i++){
    var key=keys[i];
    data.add(singleDomainData[key]);
  }
  return data;
}

//***************************Alphabet List**************************************//
alphabetList()async{
  List a=[];
  List.generate(26, (index) =>a.add(String.fromCharCode(index+65)));
  return a;
}
//***************************List of Headers of xlsx sheet**********************//

List headers=['ID','Name','Mail','HRMail','DOB','DOJ','MobileNo','ActiveTime','LoginTime','LogoutTime','Status'];






//*********************************************************************//
generateExcelWeb(List dataset)async{

  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];
  //List dataset=await fetchingDataSingleDomain(singleDomainData);


  //Setting the header of excel file//

  List alphabetsList=await alphabetList();
  for(int i=0;i<headers.length;i++){
    sheet.getRangeByName('${alphabetsList[i]}1').setText('${headers[i]}');

    //Hedader Decoretion//
    final Range rangeHeader = sheet.getRangeByName('${alphabetsList[i]}1');
    rangeHeader.cellStyle.fontSize = 11;
    rangeHeader.cellStyle.bold = true;
    rangeHeader.cellStyle.hAlign = HAlignType.left;
    rangeHeader.cellStyle.vAlign = VAlignType.center;
    rangeHeader.cellStyle.backColor = '#FDD1D1';
    rangeHeader.cellStyle.fontColor = '#B62021';
    rangeHeader.cellStyle.borders.all.color = '#B62021';
    rangeHeader.cellStyle.borders.bottom.lineStyle = LineStyle.thick;

  }




  //Input_Data to excel file for single domain//
  for(int k=0;k<dataset.length;k++){

    Map data=dataset[k];
    UserDetails details=UserDetails(
        name: data['Name'],
        mail: data['Mail'],
        dob: data['DOB'],
        doj: data['DOJ'],
        activeTime:data['ActiveTime'],
        hrmail: data['HRMail'],
        mobileNo:data['MobileNo'],
        id: data['ID'],
        loginTime: data['LoginTime'],
        logoutTime: data['LogoutTime'],
        status: data['Status']
    );

    for(int j=0;j<headers.length;j++){

      String a=headers[j];
      sheet.getRangeByName('${alphabetsList[j]}${k+2}').setText(details.getter(headers[j], details));
      sheet.autoFitColumn(j+1);
    }
    sheet.autoFitRow(k+2);
  }

  /////////////////////////////////////////////////////////////////////
  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();
  return bytes;
}



class UserDetails{
  final String name;
  final String dob;
  final String doj;
  final String mobileNo;
  final String activeTime;
  final String mail;
  final String hrmail;
  final String id;
  final String loginTime;
  final String logoutTime;
  final String status;
  UserDetails({
    required this.name,
    required this.mail,
    required this.dob,
    required this.doj,
    required this.activeTime,
    required this.hrmail,
    required this.mobileNo,
    required this.id,
    required this.loginTime,
    required this.logoutTime,
    required this.status
  });

  String getter(String a,UserDetails b){
    if (a=='ID'){
      return b.id;
    }else if(a=='Name'){
      return b.name;
    }else if(a=='Mail') {
      return b.mail;
    }else if(a=='Name') {
      return b.name;
    }else if(a=='HRMail') {
      return b.hrmail;
    }else if(a=='DOB') {
      return b.dob;
    }else if(a=='DOJ') {
      return b.doj;}
    else if(a=='ActiveTime') {
      return b.activeTime;
    }else if(a=='LoginTime') {
      return b.loginTime;
    }else if(a=='LogoutTime') {
      return b.logoutTime;}
    else if(a=='Status') {
      return b.status;}
    else if(a=='MobileNo') {
      return b.mobileNo;
    }else{
      return b.id;
    }
  }
}