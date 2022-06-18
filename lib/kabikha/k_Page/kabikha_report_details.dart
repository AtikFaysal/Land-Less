import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/kabikha/k_Model/kabikha_data.dart';
import 'package:land_less/kabikha/k_Model/kabikha_project_byId.dart';
import 'package:land_less/kabikha/k_Model/kabikha_project_info.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/service/khabikha_api.dart';
import 'package:land_less/widget/image_details.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class KabikhaReportDetails extends StatefulWidget {
  LoginResponse loginResponse;
  String kabikhaProjectId;

  KabikhaReportDetails(this.loginResponse, this.kabikhaProjectId);

  @override
  _KabikhaReportDetailsState createState() => _KabikhaReportDetailsState(loginResponse,kabikhaProjectId);
}

class _KabikhaReportDetailsState extends State<KabikhaReportDetails> {
  LoginResponse loginResponse;
  String kabikhaProjectId;

  _KabikhaReportDetailsState(this.loginResponse, this.kabikhaProjectId);

  List<KabikhaData>_khabikhaDataList=[];
  List<ProjectInformation>_khabikhaProjectInfo=[];

  final formatDate = DateFormat("yyyy-MM-dd");
  bool _isLoading=false;

  TextEditingController _YearController=TextEditingController();
  TextEditingController _upojilaController=TextEditingController();
  TextEditingController _unController=TextEditingController();
  TextEditingController _nameControler=TextEditingController();
  TextEditingController _addressControler=TextEditingController();
  TextEditingController _commentControler=TextEditingController();
  TextEditingController _amountControler=TextEditingController();
  TextEditingController _completeDate=TextEditingController();
  TextEditingController _startDate=TextEditingController();
  TextEditingController _endDate=TextEditingController();
  TextEditingController _createdByController=new TextEditingController();
  TextEditingController _createdDateController=new TextEditingController();
  TextEditingController _aprovedByController=new TextEditingController();
  TextEditingController _aprovedDateController=new TextEditingController();

  void loadEditTextData(){
    setState(() {
      _isLoading=true;
    });
    _khabikhaDataList.clear();
    _khabikhaProjectInfo.clear();
    Map<String,dynamic>task={
      'device_id':loginResponse.response.deviceId,
      'user_id':loginResponse.response.userId,
      'user_role':loginResponse.response.userRole,
      'kabikha_project_id':kabikhaProjectId
    };
    KhabikhaApi().getKabikhaInfoById(task).then((value){
      if(value['status']==200){
        KabikhaDetailsById kabikhaDetailsById;
        kabikhaDetailsById=KabikhaDetailsById.fromJson(value);
        for(int i=0;i<kabikhaDetailsById.kabikhaData.length;i++){
          setState(() {
            _khabikhaDataList.add(kabikhaDetailsById.kabikhaData[i]);
          });
        }
        for(int j=0;j<kabikhaDetailsById.projectInformation.length;j++){
          setState(() {
            _khabikhaProjectInfo.add(kabikhaDetailsById.projectInformation[j]);
          });
        }
        setState(() {
          _upojilaController.value=TextEditingValue(text: _khabikhaDataList[0].upazilaName.toString());
          _unController.value=TextEditingValue(text: _khabikhaDataList[0].upPourashavaName);
          _nameControler.value=TextEditingValue(text: _khabikhaDataList[0].projectName);
          _YearController.value=TextEditingValue(text: _khabikhaDataList[0].financialYear);
          _completeDate.value=TextEditingValue(text:_khabikhaDataList[0].completionOfProject);
          _amountControler.value=TextEditingValue(text: _khabikhaDataList[0].assignedAmount);
          _startDate.value=TextEditingValue(text: _khabikhaDataList[0].projectStartDate);
          _endDate.value=TextEditingValue(text: _khabikhaDataList[0].projectEndDate);
          _commentControler.value=TextEditingValue(text: _khabikhaDataList[0].comments);
          _addressControler.value=TextEditingValue(text: _khabikhaDataList[0].projectConstructionAddress);
          _createdByController.value=TextEditingValue(text: _khabikhaDataList[0].createdBy);
          _createdDateController.value=TextEditingValue(text: _khabikhaDataList[0].entryDate);
          _aprovedByController.value=TextEditingValue(text: _khabikhaDataList[0].approvedBy==null?"":_khabikhaDataList[0].approvedBy);
          _aprovedDateController.value=TextEditingValue(text: _khabikhaDataList[0].approvedDate);
          _isLoading=false;
        });
      }
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    loadEditTextData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton:FloatingActionButton.extended(
          onPressed: () => houseInfoList(context),
          label: Text('প্রকল্পের তথ্য দেখুন'),
          icon: Icon(
            Icons.house,
            color: AppTheme.subColors,
          ),
          backgroundColor: AppTheme.mainColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'সম্পূর্ণ তথ্য',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body:new Container(
        color: Colors.white,
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : new ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                new Container(
                  color: Color(0xffFFFFFF),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'বিস্তারিত তথ্য',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'উপজেলা',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    controller: _upojilaController,
                                    /*keyboardType: TextInputType.multiline,
                                      maxLines: null,*/
                                    decoration: InputDecoration(
                                        border:InputBorder.none,
                                        hintText: "উপজেলা নাম"),
                                    enabled:false,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'ইউনিয়ন',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    controller:
                                    _unController,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "ইউনিয়ন অথবা পৌরসভা নির্বাচন করুন"),
                                    enabled: false,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: new Text(
                                      'প্রকল্পের নাম',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Container(
                                    child: new Text(
                                      'অর্থবছর',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(right: 10.0),
                                    child: new TextField(
                                      controller:
                                      _nameControler,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "প্রকল্প নাম লিখুন"),
                                      enabled: false,
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(left: 10.0),
                                    child: new TextField(
                                      controller: _YearController,
                                      //keyboardType: TextInputType.multiline,
                                      //maxLines: null,
                                      decoration: const InputDecoration(
                                          hintText: "অর্থবছর নির্বাচন করুন ",border: InputBorder.none),
                                      enabled: false,
                                    ),
                                  ),
                                  flex: 2,
                                ),
                              ],
                            )),
                        /* Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'NID নম্বর  ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: new TextField(
                                            controller: _nidController,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            decoration: const InputDecoration(
                                                hintText: "NID নম্বর "),
                                            enabled: !_status,
                                          ),
                                        ),
                                      ],
                                    )),*/
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: new Text(
                                      'প্রকল্প শুরুর তারিখ',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Container(
                                    child: new Text(
                                      'প্রকল্প শেষ হওয়ার নির্ধারিত তারিখ',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                /* Expanded(
                                    child: Container(
                                      child: new Text(
                                        'প্রকল্প শেষের তারিখ',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),*/
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(right: 10.0),
                                    child: new DateTimeField(
                                      controller: _startDate,
                                      resetIcon: null,
                                      decoration:const InputDecoration(
                                          border: InputBorder.none,
                                          //suffixIcon: null,
                                          hintText: "প্রকল্প শুরুর তারিখ নির্বাচন করুন"),
                                      format: formatDate,
                                      onShowPicker:
                                          (context, currentValue) {
                                        return showDatePicker(
                                            context: context,
                                            helpText:
                                            "প্রকল্প শুরুর তারিখ নির্বাচন করুন",
                                            firstDate: DateTime(2021),
                                            initialDate: currentValue ??
                                                DateTime.now(),
                                            lastDate: DateTime(2100));
                                      },
                                      enabled: false,
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(right: 10.0),
                                    child: new DateTimeField(
                                      controller: _completeDate,
                                      resetIcon: null,
                                      decoration:const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "প্রকল্প শেষ হওয়ার নির্ধারিত তারিখ"),
                                      format: formatDate,
                                      onShowPicker:
                                          (context, currentValue) {
                                        return showDatePicker(
                                            context: context,
                                            helpText:
                                            "প্রকল্প শেষ হওয়ার নির্ধারিত তারিখ নির্বাচন করুন",
                                            firstDate: DateTime(2021),
                                            initialDate: currentValue ??
                                                DateTime.now(),
                                            lastDate: DateTime(2100));
                                      },
                                      enabled: false,
                                    ),
                                  ),
                                  flex: 2,
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: new Text(
                                      'প্রকল্প শেষের তারিখ',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Container(
                                    child: new Text(
                                      'প্রকল্পে বরাদ্দের পরিমাণ',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: new DateTimeField(
                                    controller: _endDate,
                                    resetIcon: null,
                                    decoration:const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "প্রকল্প শেষের তারিখ নির্বাচন করুন"),
                                    format: formatDate,
                                    onShowPicker:
                                        (context, currentValue) {
                                      return showDatePicker(
                                          context: context,
                                          helpText:
                                          "প্রকল্প শেষের তারিখ নির্বাচন করুন",
                                          firstDate: DateTime(2021),
                                          initialDate: currentValue ??
                                              DateTime.now(),
                                          lastDate: DateTime(2100));
                                    },
                                    enabled: false,
                                  ),
                                  flex: 2,
                                ),

                                Flexible(
                                  child:  new TextField(
                                    controller: _amountControler,
                                    //keyboardType: TextInputType.multiline,
                                    //maxLines: null,
                                    decoration:const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "প্রকল্পে বরাদ্দের পরিমাণ "),
                                    enabled: false,
                                  ),
                                  flex: 2,
                                ),
                              ],
                            )),

                        /* Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 30.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'যোগাযোগ এর তথ্য ',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),*/
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'প্রকল্প বাস্তবায়নের ঠিকানা',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    controller: _addressControler,
                                    keyboardType:
                                    TextInputType.multiline,
                                    maxLines: null,
                                    decoration:
                                    const InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                        "প্রকল্প বাস্তবায়নের ঠিকানা লিখুন"),
                                    enabled: false,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'মন্তব্য',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    controller: _commentControler,
                                    keyboardType:
                                    TextInputType.multiline,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "মন্তব্য লিখুন"),
                                    enabled: false,
                                  ),
                                ),
                              ],
                            )),
                        /* Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'পিতার নাম',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      controller:_fathersNameController,
                                      decoration: const InputDecoration(
                                          hintText: "পিতার নাম লিখুন"),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),*/

                        /*Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'মাতার নাম',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      controller:_mothersNameController,
                                      decoration: const InputDecoration(
                                          hintText: "মাতার নাম লিখুন"),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),*/
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: new Text(
                                      'তথ্য সংগ্রহকারী',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Container(
                                    child: new Text(
                                      'তথ্য সংগ্রহের তারিখ',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(right: 10.0),
                                    child: new TextField(
                                      controller: _createdByController,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "তথ্য সংগ্রহকারী"),
                                      enabled: false,
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Flexible(
                                  child: new TextField(
                                    controller: _createdDateController,
                                    decoration:const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "তথ্য সংগ্রহের তারিখ"),
                                    enabled: false,
                                  ),
                                  flex: 2,
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: new Text(
                                      'অনুমোদনকারী',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Container(
                                    child: new Text(
                                      'অনুমোদন তারিখ ',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(right: 10.0),
                                    child: new TextField(
                                      controller: _aprovedByController,
                                      decoration:const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "অনুমোদনকারী"),
                                      enabled: false,
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Flexible(
                                  child: new TextField(
                                    controller: _aprovedDateController,
                                    decoration:const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "অনুমোদন তারিখ"),
                                    enabled: false,
                                  ),
                                  flex: 2,
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        /* !_status
                              ? _getActionButtons()
                              : new Container(),*/
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }

  void houseInfoList(BuildContext context){
    showMaterialModalBottomSheet(
      elevation: 5.5,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      context: context,
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height*2/3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // 1st use min not max
            children: <Widget>[
              Align(
                  alignment: Alignment.topRight,
                  child:Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: ()=>Navigator.pop(context),
                      child: Icon(Icons.clear,),
                    ),
                  )
              ),
              Text('প্রকল্পের তথ্য',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: AppTheme.mainColor,decoration: TextDecoration.underline),),
              _khabikhaProjectInfo.isNotEmpty?GridView.builder(
                  scrollDirection: Axis.vertical,
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _khabikhaProjectInfo.length,
                  gridDelegate:
                  // crossAxisCount stands for number of columns you want for displaying
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {

                    // return your grid widget here, like how your images will be displayed
                    return GestureDetector(
                      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailScreen(_khabikhaProjectInfo[index].fileDirectory+_khabikhaProjectInfo[index].image,_khabikhaProjectInfo[index].details))),
                      child: Container(
                        width: 150.0,
                        height: 170.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            new Container(
                              width: 140.0,
                              height: 140.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        _khabikhaProjectInfo[index].fileDirectory+_khabikhaProjectInfo[index].image
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Card(
                                  color: _khabikhaProjectInfo[index].status=='1'?AppTheme.mainColor:AppTheme.nearlyWhite,
                                  child: Padding(
                                      padding: EdgeInsets.all(2),
                                      child: _khabikhaProjectInfo[index].status=='1'?Text('সম্পন্ন',style: TextStyle(color: Colors.white),)
                                          :Text('অসম্পন্ন',style: TextStyle(color: Colors.red),)
                                  ),
                                ),
                              ),
                            ),
                           /* Padding(padding: EdgeInsets.all(5),
                              child: Text("বিবরণ: "+_khabikhaProjectInfo[index].details),),*/
                            Padding(
                              padding: EdgeInsets.all(2),
                              child: Text('তারিখ: '+_khabikhaProjectInfo[index].entryDate),
                            )
                          ],
                        ),
                      ),
                    );
                  }):Center(child: Text('কোন তথ্য পাওয়া যায়নি।'),),// 2nd remove Expanded
            ],
          )
      ),
    );
  }
}
