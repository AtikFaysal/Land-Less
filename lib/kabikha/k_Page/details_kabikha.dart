import 'dart:io';
import 'dart:ui';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/kabikha/k_Model/kabikha_data.dart';
import 'package:land_less/kabikha/k_Model/kabikha_project_byId.dart';
import 'package:land_less/kabikha/k_Model/kabikha_project_info.dart';
import 'package:land_less/kabikha/k_Page/k_list_info.dart';
import 'package:land_less/kabikha/k_Page/upload_kabikha_info.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/model/up_data.dart';
import 'package:land_less/model/year_data.dart';
import 'package:land_less/service/apiService.dart';
import 'package:land_less/service/dioApiCall.dart';
import 'package:land_less/service/khabikha_api.dart';
import 'package:land_less/widget/give_image_with_location.dart';
import 'package:land_less/widget/image_details.dart';
import 'package:land_less/widget/map_image_show.dart';
import 'package:land_less/widget/toast_massage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class KabikhaDetails extends StatefulWidget {
  KabikhaData kabikhaData;
  LoginResponse loginResponse;

  KabikhaDetails(this.kabikhaData,this.loginResponse);

  @override
  MapScreenState createState() => MapScreenState(kabikhaData,loginResponse);
}

class MapScreenState extends State<KabikhaDetails>
    with SingleTickerProviderStateMixin {

  KabikhaData kabikhaData;
  LoginResponse loginResponse;
  List<KabikhaData>_khabikhaDataList=[];
  List<UpData>_upDataList=[];
  String _upPourosavaId;
  List<YearJsonData>_yearList=[];
  String _financialYearId;
  List<ProjectInformation>_khabikhaProjectInfo=[];

  MapScreenState(this.kabikhaData,this.loginResponse);

  final _picker = ImagePicker();
  bool _isLoading=false;
  bool _projectLoad=false;
  var temFile;
  File _image;
  final formatDate = DateFormat("yyyy-MM-dd");
  /* String id,fristname,lastName,email,city,address,mobile,country
  ,postalCode,prfOver,skill,certification,experience,documents;*/


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

  final FocusNode myFocusNode = FocusNode();

  bool _status=true;
  String _verticalGroupValue;

  List<String> _type = ["গৃহহীন", "ভূমিহীন"];
  //bool _isLoading=false;

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
      'kabikha_project_id':kabikhaData.kabikhaProjectId
    };
   KhabikhaApi().getKabikhaInfoById(task).then((value){
      if(value['status']==200){
        KabikhaDetailsById kabikhaDetailsById;
        kabikhaDetailsById=KabikhaDetailsById.fromJson(value);
        for(int i=0;i<kabikhaDetailsById.kabikhaData.length;i++){
          //print(kabikhaDetailsById.kabikhaData[i].latitude);
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
  _imgFromCamera() async {
    /*File image = await _picker.getImage(
        source: ImageSource.camera, imageQuality: 50
    );*/
    final pickedFile=await _picker.getImage(source:ImageSource.camera,imageQuality: 50 );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

  }

  _imgFromGallery() async {
    /*File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );*/
    final pickedFile=await _picker.getImage(source: ImageSource.gallery,imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    //uploadTask.catchError((e)=>print(e.toString()));

  }
  void loadUpdataList()async{
    if(loginResponse.upData.isNotEmpty){
      for(int i=0;i<loginResponse.upData.length;i++){
        setState(() {
          _upDataList.add(loginResponse.upData[i]);
        });
      }
    }
  }
  void loadYearJsonData()async{
    if(loginResponse.yearJsonData.isNotEmpty){
      for(int i=0;i<loginResponse.yearJsonData.length;i++){
        setState(() {
          _yearList.add(loginResponse.yearJsonData[i]);
        });
      }
    }
  }
  List<UpData> getSuggestions(String query) {
    List<UpData> matches = List();
    matches.addAll(_upDataList);
    matches.retainWhere((s) =>   s.upPourashavaName.contains(query.toLowerCase()));
    return matches;
  }
  List<YearJsonData> getSuggestionsYear(String query) {
    List<YearJsonData> matches = List();
    matches.addAll(_yearList);
    matches.retainWhere((s) =>   s.financialYear.contains(query.toLowerCase()));
    return matches;
  }
  void loadProjectInfo(BuildContext context){
    setState(() {
      _projectLoad=true;
    });
    Map<String,dynamic>task={
      'device_id':loginResponse.response.deviceId,
      'user_id':loginResponse.response.userId,
      'user_role':loginResponse.response.userRole,
      'kabikha_project_id':kabikhaData.kabikhaProjectId
    };
    _khabikhaProjectInfo.clear();
    KhabikhaApi().getKabikhaInfoById(task).then((value) {
      KabikhaDetailsById kabikhaDetailsById;
      kabikhaDetailsById=KabikhaDetailsById.fromJson(value);
      if(kabikhaDetailsById.projectInformation.isNotEmpty){
        for(int j=0;j<kabikhaDetailsById.projectInformation.length;j++){
          setState(() {
            _khabikhaProjectInfo.add(kabikhaDetailsById.projectInformation[j]);
            _projectLoad=false;
          });
        }
        houseInfoList(context);
      }else{
        showToastMassage(context, "কোন তথ্য পাওয়া যায়নি।");
        setState(() {
          _projectLoad=false;
        });
      }
    });
  }
  Widget floatingAction(){
    return _projectLoad?CircularProgressIndicator():FloatingActionButton.extended(
      onPressed: () {
        loadProjectInfo(context);
      } ,
      label:Text('প্রকল্পের তথ্য দেখুন',style: TextStyle(color: AppTheme.mainColor),),
      icon: Icon(
        Icons.visibility,
        color: AppTheme.mainColor,
      ),
      backgroundColor:AppTheme.mainInfo,
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    loadEditTextData();
    loadUpdataList();
    loadYearJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading?new Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton:_khabikhaDataList[0].latitude!=null && _isLoading==false?floatingAction():Text(''),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          elevation: 0.0,
          //centerTitle: true,
          title: Text(
            'সম্পূর্ণ তথ্য',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          actions:_isLoading?[]: [
            loginResponse.response.userRole!='1' && _khabikhaDataList[0].status=='2' && _khabikhaDataList[0].latitude!=null?
            new FlatButton(
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.house,
                    size: 30,
                    color: AppTheme.white,
                  ),
                  Text(
                    'প্রকল্পের তথ্য দিন',
                    style: TextStyle(
                        color: AppTheme.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 19),
                  ),

                ],
              ),
              onPressed: () => Navigator.of(context)
                  .push(PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) =>
                      RotationTransition(
                        turns: animation,
                        child: ScaleTransition(
                          scale: animation,
                          child: FadeTransition(
                              opacity: animation,
                              child: UploadKhabikhaInfo(
                                  loginResponse,
                                  _khabikhaDataList[0].status,
                                  _khabikhaDataList[0].kabikhaProjectId)),
                        ),
                      )))
                  .then((value) => setState(() {})),
              shape: RoundedRectangleBorder(side: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                  style: BorderStyle.solid
              ), borderRadius: BorderRadius.circular(8)),):Text(''),
          ],
        ),
        backgroundColor: AppTheme.nearlyWhite,
        body: new Container(
          color: Colors.white,
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                 /* new Container(
                    height: 250.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 60.0),
                          child:
                          new Stack(fit: StackFit.loose, children: <
                              Widget>[
                            new Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                  width: 140.0,
                                  height: 140.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: _image == null
                                          ? new DecorationImage(
                                        image: _memberDataList[0]
                                            .image !=
                                            ''
                                            ? NetworkImage(
                                            _memberDataList[0]
                                                .fileDirectory +
                                                _memberDataList[
                                                0]
                                                    .image)
                                            : ExactAssetImage(
                                            'assets/images/person.png'),
                                        fit: BoxFit.cover,
                                      )
                                          : new DecorationImage(
                                        image: FileImage(_image),
                                        fit: BoxFit.cover,
                                      )),
                                )
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 90.0, right: 100.0),
                                child: new Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    new GestureDetector(
                                        onTap: () => !_status
                                            ? _showPicker(context)
                                            : print(''),
                                        child: CircleAvatar(
                                          backgroundColor:
                                          AppTheme.mainColor,
                                          radius: 25.0,
                                          child: new Icon(
                                            Icons.camera_alt,
                                            color: AppTheme.subColors,
                                          ),
                                        ))
                                  ],
                                )),
                          ]),
                        )
                      ],
                    ),
                  ),*/
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
                                  new Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[

                                      _khabikhaDataList[0].latitude==null? Padding(
                                        padding: const EdgeInsets.only(left: 140),
                                        child: _getCameraIcon(),
                                      )
                                          : Padding(
                                            padding: const EdgeInsets.only(left: 140),
                                            child: _getMapIcon(),
                                          ),
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status
                                          ? _getEditIcon()
                                          : new Container(),
                                    ],
                                  )
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
                                      decoration: !_status?InputDecoration(
                                          hintText:
                                          "উপজেলা নাম"):InputDecoration(
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
                                    child: TypeAheadFormField<UpData>(
                                      textFieldConfiguration:
                                      TextFieldConfiguration(
                                          controller: this
                                              ._unController,
                                          decoration:!_status?InputDecoration(
                                            hintText:
                                            'ইউনিয়ন অথবা পৌরসভা নির্বাচন করুন',
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.clear),
                                              onPressed: (){
                                                setState(() {
                                                  _unController.clear();
                                                });
                                              },
                                            ),
                                            ):InputDecoration(
                                            hintText:
                                            'ইউনিয়ন অথবা পৌরসভা নির্বাচন করুন',
                                            border: InputBorder.none,
                                            ),
                                          enabled: !_status),
                                      suggestionsCallback: (pattern) {
                                        //ledgerList.retainWhere((element) => element.ledgerName.toLowerCase().contains(pattern.toLowerCase()))
                                        return getSuggestions(pattern);
                                      },
                                      itemBuilder:
                                          (context, suggestion) {
                                        return ListTile(
                                          title: Text(suggestion
                                              .upPourashavaName),
                                        );
                                      },
                                      transitionBuilder: (context,
                                          suggestionsBox, controller) {
                                        return suggestionsBox;
                                      },
                                      onSuggestionSelected:
                                          (suggestion) {
                                        this._unController.text =
                                            suggestion.upPourashavaName;
                                        setState(() {
                                          _upPourosavaId=suggestion.upPourashavaId;
                                        });
                                      },
                                      validator: (value) => value
                                          .isEmpty
                                          ? 'ইউনিয়ন অথবা পৌরসভা নাম আবশ্যক'
                                          : null,
                                      //onSaved: (value) => this._selectedCity = value,
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
                                        decoration: !_status?const InputDecoration(
                                            hintText: "প্রকল্প নাম লিখুন"):const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "প্রকল্প নাম লিখুন"),
                                        enabled: !_status,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding:
                                      EdgeInsets.only(left: 10.0),
                                      child: TypeAheadFormField<YearJsonData>(
                                        textFieldConfiguration:
                                        TextFieldConfiguration(
                                            controller: this
                                                ._YearController,
                                            decoration:!_status?InputDecoration(
                                              hintText:
                                              'অর্থবছর নির্বাচন করুন',
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.clear),
                                                onPressed: (){
                                                  setState(() {
                                                    _YearController.clear();
                                                  });
                                                },
                                              ),
                                            ):InputDecoration(
                                              hintText:
                                              'অর্থবছর নির্বাচন করুন',
                                              border: InputBorder.none,
                                            ),
                                            enabled: !_status),
                                        suggestionsCallback: (pattern) {
                                          //ledgerList.retainWhere((element) => element.ledgerName.toLowerCase().contains(pattern.toLowerCase()))
                                          return getSuggestionsYear(pattern);
                                        },
                                        itemBuilder:
                                            (context, suggestion) {
                                          return ListTile(
                                            title: Text(suggestion
                                                .financialYear),
                                          );
                                        },
                                        transitionBuilder: (context,
                                            suggestionsBox, controller) {
                                          return suggestionsBox;
                                        },
                                        onSuggestionSelected:
                                            (suggestion) {
                                          this._YearController.text =
                                              suggestion.financialYear;
                                          setState(() {
                                            _financialYearId=suggestion.financialYearId;
                                          });
                                        },
                                        validator: (value) => value
                                            .isEmpty
                                            ? 'অর্থবছর নির্বাচন করুন আবশ্যক'
                                            : null,
                                        //onSaved: (value) => this._selectedCity = value,
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
                                        resetIcon: _status?null:Icon(Icons.clear),
                                        controller: _startDate,
                                        decoration: !_status?const InputDecoration(
                                            hintText: "প্রকল্প শুরুর তারিখ নির্বাচন করুন"):const InputDecoration(
                                            border: InputBorder.none,
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
                                        enabled: !_status,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding:
                                      EdgeInsets.only(right: 10.0),
                                      child: new DateTimeField(
                                        resetIcon: _status?null:Icon(Icons.clear),
                                        controller: _completeDate,
                                        decoration: !_status?const InputDecoration(
                                            hintText: "প্রকল্প শেষ হওয়ার নির্ধারিত তারিখ"):const InputDecoration(
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
                                        enabled: !_status,
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
                                      resetIcon: _status?null:Icon(Icons.clear),
                                      controller: _endDate,
                                      decoration: !_status?const InputDecoration(
                                          hintText: "প্রকল্প শেষের তারিখ নির্বাচন করুন"):const InputDecoration(
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
                                      enabled: !_status,
                                    ),
                                    flex: 2,
                                  ),

                                  Flexible(
                                    child:  new TextField(
                                      controller: _amountControler,
                                      //keyboardType: TextInputType.multiline,
                                      //maxLines: null,
                                      decoration: !_status?const InputDecoration(
                                          hintText: "প্রকল্পে বরাদ্দের পরিমাণ "):const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "প্রকল্পে বরাদ্দের পরিমাণ "),
                                      enabled: !_status,
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
                                      decoration: !_status?const InputDecoration(
                                          hintText:
                                          "প্রকল্প বাস্তবায়নের ঠিকানা লিখুন"):
                                      const InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                          "প্রকল্প বাস্তবায়নের ঠিকানা লিখুন"),
                                      enabled: !_status,
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
                                      decoration: !_status?const InputDecoration(
                                          hintText: "মন্তব্য লিখুন"):const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "মন্তব্য লিখুন"),
                                      enabled: !_status,
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
                          _status?Padding(
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
                              )):Text(''),
                          _status?Padding(
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
                                        decoration: !_status?const InputDecoration(
                                            hintText: "তথ্য সংগ্রহকারী"):const InputDecoration(
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
                                      decoration: !_status?const InputDecoration(
                                          hintText: "তথ্য সংগ্রহের তারিখ"):const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "তথ্য সংগ্রহের তারিখ"),
                                      enabled: false,
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )):Text(''),
                          _status?Padding(
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
                              )):Text(''),
                          _status?Padding(
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
                                        decoration: !_status?const InputDecoration(
                                            hintText: "অনুমোদনকারী"):const InputDecoration(
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
                                      decoration: !_status?const InputDecoration(
                                          hintText: "অনুমোদন তারিখ"):const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "অনুমোদন তারিখ"),
                                      enabled: false,
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )):Text(''),
                          SizedBox(
                            height: 20,
                          ),
                          !_status
                              ? _getActionButtons()
                              : new Container(),
                        ],
                      ),
                    ),
                  ),
                  loginResponse.response.userRole == '2' &&
                      _khabikhaDataList[0].status == '1'
                      ? Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width:
                          MediaQuery.of(context).size.width / 3,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty
                                  .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(
                                        MaterialState.selected))
                                      return AppTheme.mainColor;
                                    return AppTheme
                                        .mainColor; // Use the default value.
                                  }),
                            ),
                            onPressed: () {
                              setState(() {
                                _isLoading = true;
                              });
                              Map<String, dynamic> task = {
                                'device_id':
                                loginResponse.response.deviceId,
                                'user_id':
                                loginResponse.response.userId,
                                'kabikha_project_id':
                                _khabikhaDataList[0].kabikhaProjectId
                              };
                              ApiCall()
                                  .approvedKabikha(task)
                                  .then((value) {
                                if (value['status'] == 200) {
                                  setState(() {
                                    loadEditTextData();
                                  });
                                  successToast(context,
                                      "সফলভাবে অনুমোদন হয়েছে");
                                } else if (value['status'] == 401) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  showToastMassage(context,
                                      'দুঃখিত ! অনুমোদন সফল হয়নি');
                                } else if (value['status'] == 650) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  showToastMassage(context,
                                      'দুঃখিত ! আপনার ব্যবহৃত মোবাইলটি অ্যাপ্স ব্যবহারের জন্য অনুমোদিত নয়। অনুগ্রহকরে অথিরিটির সাথে যোগাযোগ করুন।');
                                } else if (value['status'] == 550) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  showToastMassage(context,
                                      'দুঃখিত !এটি আপনার জন্য অনুমোদিত মোবাইল নয়। অনুগ্রহকরে অথিরিটির সাথে যোগাযোগ করুন।');
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  showToastMassage(context,
                                      "আবশ্যক তথ্যগুলো প্রদান করুন");
                                }
                              });
                            },
                            child: Text(
                              "অনুমোদন করুন",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Container(
                          width:
                          MediaQuery.of(context).size.width / 3,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty
                                  .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(
                                        MaterialState.selected))
                                      return AppTheme.subColors;
                                    return AppTheme
                                        .subColors; // Use the default value.
                                  }),
                            ),
                            onPressed: () {
                              Map<String, dynamic> task = {
                                'device_id':
                                loginResponse.response.deviceId,
                                'user_id':
                                loginResponse.response.userId,
                                'kabikha_project_id':
                                _khabikhaDataList[0].kabikhaProjectId
                              };
                              ApiCall()
                                  .rejectKhabikha(task)
                                  .then((value) {
                                if (value['status'] == 200) {
                                  setState(() {
                                    loadEditTextData();
                                  });
                                  successToast(context,
                                      "সফলভাবে বাতিল হয়েছে");
                                } else if (value['status'] == 401) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  showToastMassage(context,
                                      'দুঃখিত ! অনুমোদন সফল হয়নি');
                                } else if (value['status'] == 650) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  showToastMassage(context,
                                      'দুঃখিত ! আপনার ব্যবহৃত মোবাইলটি অ্যাপ্স ব্যবহারের জন্য অনুমোদিত নয়। অনুগ্রহকরে অথিরিটির সাথে যোগাযোগ করুন।');
                                } else if (value['status'] == 550) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  showToastMassage(context,
                                      'দুঃখিত !এটি আপনার জন্য অনুমোদিত মোবাইল নয়। অনুগ্রহকরে অথিরিটির সাথে যোগাযোগ করুন।');
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  showToastMassage(context,
                                      "আবশ্যক তথ্যগুলো প্রদান করুন");
                                }
                              });
                            },
                            child: Text(
                              "বাতিল করুন",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                      : Text(''),
                  SizedBox(height: 50,)
                ],
              ),
            ],
          ),
        )): Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              //centerTitle: true,
              title: Text(
                'সম্পূর্ণ তথ্য',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  Widget _getActionButtons() {
    return loginResponse.response.userRole!='1'?Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0,bottom: 40),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("সংশোধন করুন"),
                    textColor: AppTheme.nearlyWhite,
                    color: AppTheme.mainColor,
                    onPressed: ()async {
                      setState(() {
                        _isLoading=true;
                      });
                      FormData formData=new FormData.fromMap({
                        'device_id':loginResponse.response.deviceId,
                        'user_id':loginResponse.response.userId,
                        'user_role':loginResponse.response.userRole,
                        'kabikha_project_id':kabikhaData.kabikhaProjectId,
                        'financial_year_id':_financialYearId!=null?_financialYearId:kabikhaData.financialYearId,
                        'up_pourashava_id':_upPourosavaId!=null?_upPourosavaId:kabikhaData.upPourashavaId,
                        'project_name':_nameControler.text,
                        'project_construction_address':_addressControler.text,
                        'comments':_commentControler.text,
                        'assigned_amount':_amountControler.text,
                        'project_start_date':_startDate.text,
                        'project_end_date':_endDate.text,
                        'completion_of_project':_completeDate.text
                      });
                      DioApiCall().dioUpdateKhabikhaProject(formData).then((value) {
                        if(value['status']==200){
                          setState(() {
                            loadEditTextData();
                            _status=true;
                          });
                          successToast(context, "সফলভাবে সংশোধিত হয়েছে");
                        }else if(value['status']==401){
                          setState(() {
                            _isLoading=false;
                          });
                          showToastMassage(context, 'দুঃখিত ! গ্রাহকের তথ্য সংরক্ষণ হয়নি');
                        }else if(value['status']==503){
                          setState(() {
                            _isLoading=false;
                          });
                          showToastMassage(context,'দুঃখিত ! উক্ত এন.আই.ডি পূর্বে ব্যবহার হয়েছে');
                        }else if(value['status']==650){
                          setState(() {
                            _isLoading=false;
                          });
                          showToastMassage(context,'দুঃখিত ! আপনার ব্যবহৃত মোবাইলটি অ্যাপ্স ব্যবহারের জন্য অনুমোদিত নয়। অনুগ্রহকরে অথিরিটির সাথে যোগাযোগ করুন।');
                        }
                        else{
                          setState(() {
                            _isLoading=false;
                          });
                          showToastMassage(context, "সংশোধন করা সম্ভব হয়নি");
                        }
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("ঠিক আছে"),
                    textColor: AppTheme.nearlyWhite,
                    color: AppTheme.subColors,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        loadEditTextData();
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    ):Text('');
  }

  Widget _getEditIcon() {
    return loginResponse.response.userRole!='1'?new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: AppTheme.mainInfo,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: AppTheme.mainColor,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    ):Text('');
  }
  Widget _getCameraIcon() {
    return loginResponse.response.userRole!='1'?new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: AppTheme.mainInfo,
        radius: 14.0,
        child: new Icon(
          Icons.photo_camera_outlined,
          color: AppTheme.mainColor,
          size: 16.0,
        ),
      ),
      onTap: () => goToSecondScreen(),
    ):Text('');
  }
  void goToSecondScreen()async {
    var result = await Navigator.of(context)
        .push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) =>
            RotationTransition(
              turns: animation,
              child: ScaleTransition(
                scale: animation,
                child: FadeTransition(
                    opacity: animation,
                    child: ImageWithLocation(loginResponse,_khabikhaDataList[0].kabikhaProjectId)),
              ),
            )));
    if(result!=null){
      setState(() {
        loadEditTextData();
        loadUpdataList();
        loadYearJsonData();
      });
    }
  }
  Widget _getMapIcon() {
    return loginResponse.response.userRole!='1'?new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: AppTheme.mainInfo,
        radius: 14.0,
        child: new Icon(
          Icons.location_on_outlined,
          color: AppTheme.mainColor,
          size: 16.0,
        ),
      ),
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context)=>
          MapImageShow(lat:_khabikhaDataList[0].latitude,long:_khabikhaDataList[0].longitude,
            image:_khabikhaDataList[0].file_directory+_khabikhaDataList[0].image ,)))
    ):Text('');
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('ফটো লাইব্রেরি'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('ক্যামেরা'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
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
          child:Column(
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
                      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                          MapImageShow(lat: _khabikhaProjectInfo[index].latitude,
                          long: _khabikhaProjectInfo[index].longitude,
                          image:_khabikhaProjectInfo[index].fileDirectory+_khabikhaProjectInfo[index].image,
                          details:_khabikhaProjectInfo[index].details))),
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
                            /*Padding(padding: EdgeInsets.all(5),
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
