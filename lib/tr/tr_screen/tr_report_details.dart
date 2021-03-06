import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/kabikha/k_Model/kabikha_data.dart';
import 'package:land_less/kabikha/k_Model/kabikha_project_byId.dart';
import 'package:land_less/kabikha/k_Model/kabikha_project_info.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/service/khabikha_api.dart';
import 'package:land_less/service/tr_apiService.dart';
import 'package:land_less/tr/tr_model/trListModel.dart';
import 'package:land_less/tr/tr_model/tr_details_by_id.dart';
import 'package:land_less/tr/tr_model/tr_report_model.dart';
import 'package:land_less/widget/image_details.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TrReportDetails extends StatefulWidget {
  LoginResponse loginResponse;
  String kabikhaProjectId;

  TrReportDetails(this.loginResponse, this.kabikhaProjectId);

  @override
  _TrReportDetailsState createState() => _TrReportDetailsState(loginResponse,kabikhaProjectId);
}

class _TrReportDetailsState extends State<TrReportDetails> {
  LoginResponse loginResponse;
  String kabikhaProjectId;

  _TrReportDetailsState(this.loginResponse, this.kabikhaProjectId);

  List<TrData>_trDataList=[];
  List<ProjectInformation>_trProjectInfo=[];

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
    _trDataList.clear();
    _trProjectInfo.clear();
    Map<String,dynamic>task={
      'device_id':loginResponse.response.deviceId,
      'user_id':loginResponse.response.userId,
      'user_role':loginResponse.response.userRole,
      'tr_project_id':kabikhaProjectId
    };
    TrApi().getTrInfoById(task).then((value){
      if(value['status']==200){
        TrDetailsById trDetailsById;
        trDetailsById=TrDetailsById.fromJson(value);
        for(int i=0;i<trDetailsById.trData.length;i++){
          setState(() {
            _trDataList.add(trDetailsById.trData[i]);
          });
        }
        for(int j=0;j<trDetailsById.projectInformation.length;j++){
          setState(() {
            _trProjectInfo.add(trDetailsById.projectInformation[j]);
          });
        }
        setState(() {
          _upojilaController.value=TextEditingValue(text: _trDataList[0].upazilaName.toString());
          _unController.value=TextEditingValue(text: _trDataList[0].upPourashavaName);
          _nameControler.value=TextEditingValue(text: _trDataList[0].projectName);
          _YearController.value=TextEditingValue(text: _trDataList[0].financialYear);
          _completeDate.value=TextEditingValue(text:_trDataList[0].completionOfProject);
          _amountControler.value=TextEditingValue(text: _trDataList[0].assignedAmount);
          _startDate.value=TextEditingValue(text: _trDataList[0].projectStartDate);
          _endDate.value=TextEditingValue(text: _trDataList[0].projectEndDate);
          _commentControler.value=TextEditingValue(text: _trDataList[0].comments);
          _addressControler.value=TextEditingValue(text: _trDataList[0].projectConstructionAddress);
          _createdByController.value=TextEditingValue(text: _trDataList[0].createdBy);
          _createdDateController.value=TextEditingValue(text: _trDataList[0].entryDate);
          _aprovedByController.value=TextEditingValue(text: _trDataList[0].approvedBy==null?"":_trDataList[0].approvedBy);
          _aprovedDateController.value=TextEditingValue(text: _trDataList[0].approvedDate);
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
          label: Text('??????????????????????????? ???????????? ???????????????'),
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
            '???????????????????????? ????????????',
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
                                        '??????????????????????????? ????????????',
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
                                        '??????????????????',
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
                                          hintText: "?????????????????? ?????????"),
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
                                        '??????????????????',
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
                                          hintText: "?????????????????? ???????????? ?????????????????? ???????????????????????? ????????????"),
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
                                        '??????????????????????????? ?????????',
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
                                        '?????????????????????',
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
                                            hintText: "????????????????????? ????????? ???????????????"),
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
                                            hintText: "????????????????????? ???????????????????????? ???????????? ",border: InputBorder.none),
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
                                              'NID ???????????????  ',
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
                                                hintText: "NID ??????????????? "),
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
                                        '????????????????????? ??????????????? ???????????????',
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
                                        '????????????????????? ????????? ??????????????? ??????????????????????????? ???????????????',
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
                                        '????????????????????? ??????????????? ???????????????',
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
                                            hintText: "????????????????????? ??????????????? ??????????????? ???????????????????????? ????????????"),
                                        format: formatDate,
                                        onShowPicker:
                                            (context, currentValue) {
                                          return showDatePicker(
                                              context: context,
                                              helpText:
                                              "????????????????????? ??????????????? ??????????????? ???????????????????????? ????????????",
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
                                            hintText: "????????????????????? ????????? ??????????????? ??????????????????????????? ???????????????"),
                                        format: formatDate,
                                        onShowPicker:
                                            (context, currentValue) {
                                          return showDatePicker(
                                              context: context,
                                              helpText:
                                              "????????????????????? ????????? ??????????????? ??????????????????????????? ??????????????? ???????????????????????? ????????????",
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
                                        '????????????????????? ??????????????? ???????????????',
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
                                        '???????????????????????? ???????????????????????? ??????????????????',
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
                                          hintText: "????????????????????? ??????????????? ??????????????? ???????????????????????? ????????????"),
                                      format: formatDate,
                                      onShowPicker:
                                          (context, currentValue) {
                                        return showDatePicker(
                                            context: context,
                                            helpText:
                                            "????????????????????? ??????????????? ??????????????? ???????????????????????? ????????????",
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
                                          hintText: "???????????????????????? ???????????????????????? ?????????????????? "),
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
                                        '????????????????????? ?????? ???????????? ',
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
                                        '????????????????????? ????????????????????????????????? ??????????????????',
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
                                          "????????????????????? ????????????????????????????????? ?????????????????? ???????????????"),
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
                                        '?????????????????????',
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
                                          hintText: "????????????????????? ???????????????"),
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
                                        '??????????????? ?????????',
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
                                          hintText: "??????????????? ????????? ???????????????"),
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
                                        '??????????????? ?????????',
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
                                          hintText: "??????????????? ????????? ???????????????"),
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
                                        '???????????? ??????????????????????????????',
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
                                        '???????????? ???????????????????????? ???????????????',
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
                                            hintText: "???????????? ??????????????????????????????"),
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
                                          hintText: "???????????? ???????????????????????? ???????????????"),
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
                                        '?????????????????????????????????',
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
                                        '????????????????????? ??????????????? ',
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
                                            hintText: "?????????????????????????????????"),
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
                                          hintText: "????????????????????? ???????????????"),
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
              Text('??????????????????????????? ????????????',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: AppTheme.mainColor,decoration: TextDecoration.underline),),
              _trProjectInfo.isNotEmpty?GridView.builder(
                  scrollDirection: Axis.vertical,
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _trProjectInfo.length,
                  gridDelegate:
                  // crossAxisCount stands for number of columns you want for displaying
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {

                    // return your grid widget here, like how your images will be displayed
                    return GestureDetector(
                      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailScreen(_trProjectInfo[index].fileDirectory+_trProjectInfo[index].image,_trProjectInfo[index].details))),
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
                                        _trProjectInfo[index].fileDirectory+_trProjectInfo[index].image
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Card(
                                  color: _trProjectInfo[index].status=='1'?AppTheme.mainColor:AppTheme.nearlyWhite,
                                  child: Padding(
                                      padding: EdgeInsets.all(2),
                                      child: _trProjectInfo[index].status=='1'?Text('?????????????????????',style: TextStyle(color: Colors.white),)
                                          :Text('????????????????????????',style: TextStyle(color: Colors.red),)
                                  ),
                                ),
                              ),
                            ),
                            /*Padding(padding: EdgeInsets.all(5),
                              child: Text("???????????????: "+_trProjectInfo[index].details),),*/
                            Padding(
                              padding: EdgeInsets.all(2),
                              child: Text('???????????????: '+_trProjectInfo[index].entryDate),
                            )
                          ],
                        ),
                      ),
                    );
                  }):Center(child: Text('????????? ???????????? ??????????????? ??????????????????'),),// 2nd remove Expanded
            ],
          )
      ),
    );
  }
}
