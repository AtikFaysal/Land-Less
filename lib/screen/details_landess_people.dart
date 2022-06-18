import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/model/house_information.dart';
import 'package:land_less/model/landless_memberList.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/model/member_data.dart';
import 'package:land_less/model/up_data.dart';
import 'package:land_less/model/year_data.dart';
import 'package:land_less/screen/upload_house_update.dart';
import 'package:land_less/service/apiService.dart';
import 'package:land_less/service/dioApiCall.dart';
import 'package:land_less/widget/image_details.dart';
import 'package:land_less/widget/map_image_show.dart';
import 'package:land_less/widget/toast_massage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LandlessPeopleDetails extends StatefulWidget {
  MemberData memberData;
  LoginResponse loginResponse;

  LandlessPeopleDetails(this.memberData,this.loginResponse);

  @override
  MapScreenState createState() => MapScreenState(memberData,loginResponse);
}

class MapScreenState extends State<LandlessPeopleDetails>
    with SingleTickerProviderStateMixin {

  MemberData memberData;
  LoginResponse loginResponse;
  List<MemberData>_memberDataList=[];
  List<UpData>_upDataList=[];
  String _upId;
  List<HouseInformation>_houseInfo=[];

  MapScreenState(this.memberData,this.loginResponse);

  final _picker = ImagePicker();
  bool _isLoading=false;
  bool _houseLoad=false;
  var temFile;
  File _image;
  final formatDate = DateFormat("yyyy-MM-dd");
 /* String id,fristname,lastName,email,city,address,mobile,country
  ,postalCode,prfOver,skill,certification,experience,documents;*/


  TextEditingController _upojalaNamaControler=new TextEditingController();
  TextEditingController _unionNameController=new TextEditingController();
  TextEditingController _nidController=new TextEditingController();
  TextEditingController _yearController=new TextEditingController();
  TextEditingController _dateOfBarthController=new TextEditingController();
  TextEditingController _userNameController=new TextEditingController();
  TextEditingController _userPhoneController=new TextEditingController();
  TextEditingController _fathersNameController=new TextEditingController();
  TextEditingController _mothersNameController=new TextEditingController();
  TextEditingController _addressController=new TextEditingController();
  TextEditingController _boraddoAddressController=new TextEditingController();
  TextEditingController _createdByController=new TextEditingController();
  TextEditingController _createdDateController=new TextEditingController();
  TextEditingController _aprovedByController=new TextEditingController();
  TextEditingController _aprovedDateController=new TextEditingController();

  final FocusNode myFocusNode = FocusNode();

  bool _status=true;
  String _verticalGroupValue;
  List<YearJsonData>_yearJsonData=[];
  String _financialYearId;

  List<String> _type = ["গৃহহীন", "ভূমিহীন"];
  //bool _isLoading=false;
  String oldImage;
  void loadEditTextData(){
    setState(() {
      _isLoading=true;
    });
    _memberDataList.clear();
    _houseInfo.clear();
    Map<String,dynamic>task={
      'device_id':loginResponse.response.deviceId,
      'user_id':loginResponse.response.userId,
      'user_role':loginResponse.response.userRole,
      'member_id':memberData.memberId
    };
    ApiCall().getMemberById(task).then((value){
      if(value['status']==200){
        LandlessMemberList landlessMemberList;
        landlessMemberList=LandlessMemberList.fromJson(value);
        for(int i=0;i<landlessMemberList.memberData.length;i++){
          setState(() {
            _memberDataList.add(landlessMemberList.memberData[i]);
          });
        }
        for(int j=0;j<landlessMemberList.houseInformation.length;j++){
          setState(() {
            _houseInfo.add(landlessMemberList.houseInformation[j]);
          });
        }
        setState(() {
          _upojalaNamaControler.value=TextEditingValue(text: _memberDataList[0].upazilaName.toString());
          _unionNameController.value=TextEditingValue(text: _memberDataList[0].upPourashavaName);
          _nidController.value=TextEditingValue(text: _memberDataList[0].nid);
          _yearController.value=TextEditingValue(text: _memberDataList[0].financialYear);
          _dateOfBarthController.value=TextEditingValue(text:_memberDataList[0].dateOfBirth);
          _userNameController.value=TextEditingValue(text: _memberDataList[0].memberName);
          _userPhoneController.value=TextEditingValue(text: _memberDataList[0].mobileNumber);
          _fathersNameController.value=TextEditingValue(text: _memberDataList[0].fatherName);
          _mothersNameController.value=TextEditingValue(text: _memberDataList[0].motherName);
          _mothersNameController.value=TextEditingValue(text: _memberDataList[0].motherName);
          _addressController.value=TextEditingValue(text: _memberDataList[0].address);
          _boraddoAddressController.value=TextEditingValue(text: _memberDataList[0].houseConstructionAddress);
          _createdByController.value=TextEditingValue(text: _memberDataList[0].createdBy);
          _createdDateController.value=TextEditingValue(text: _memberDataList[0].entryDate);
          _aprovedByController.value=TextEditingValue(text: _memberDataList[0].approvedBy==null?"":_memberDataList[0].approvedBy);
          _aprovedDateController.value=TextEditingValue(text: _memberDataList[0].approvedDate);
          _verticalGroupValue=_memberDataList[0].type=="1"?'গৃহহীন':'ভূমিহীন';
          oldImage=_memberDataList[0].image;
          _isLoading=false;
          _status=true;
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
  void loadFinancialYear(){
    if(loginResponse.yearJsonData.isNotEmpty){
      for(int i=0;i<loginResponse.yearJsonData.length;i++){
        setState(() {
          _yearJsonData.add(loginResponse.yearJsonData[i]);
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
    matches.addAll(_yearJsonData);
    matches.retainWhere((s) =>   s.financialYear.contains(query.toLowerCase()));
    return matches;
  }
  void loadHouseInfo(BuildContext context){
    setState(() {
      _houseLoad=true;
    });
    _houseInfo.clear();
    Map<String,dynamic>task={
      'device_id':loginResponse.response.deviceId,
      'user_id':loginResponse.response.userId,
      'user_role':loginResponse.response.userRole,
      'member_id':memberData.memberId
    };
    ApiCall().getMemberById(task).then((value) {
      LandlessMemberList landlessMemberList;
      landlessMemberList=LandlessMemberList.fromJson(value);
      if(landlessMemberList.houseInformation.isNotEmpty){
        for(int j=0;j<landlessMemberList.houseInformation.length;j++){
          setState(() {
            _houseInfo.add(landlessMemberList.houseInformation[j]);
            _houseLoad=false;
          });
        }
        houseInfoList(context);
      }else{
        showToastMassage(context, "কোন তথ্য পাওয়া যায়নি।");
        setState(() {
          _houseLoad=false;
        });
      }

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    loadFinancialYear();
    loadEditTextData();
    loadUpdataList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton:_houseLoad?CircularProgressIndicator():FloatingActionButton.extended(
          onPressed: () => loadHouseInfo(context),
          label: Text('ঘর নির্মাণের তথ্য দেখুন',style: TextStyle(color: AppTheme.mainColor),),
          icon: Icon(
            Icons.visibility,
            color: AppTheme.mainColor,
          ),
          backgroundColor: AppTheme.mainInfo,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          elevation: 0.0,
          //centerTitle: true,
          title: Text(
            'সম্পূর্ণ তথ্য',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          actions:_isLoading?[]: [
            loginResponse.response.userRole!='1' && _memberDataList[0].status=='2'?new FlatButton(
              color: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.house,
                      size: 30,
                      color: AppTheme.white,
                    ),
                    Text(
                      'ঘরের তথ্য দিন',
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
                                    child: UploadHouseUpdate(
                                        loginResponse,
                                        _memberDataList[0].status,
                                        _memberDataList[0].memberId)),
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
                        new Container(
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
                        ),
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
                                            controller: _upojalaNamaControler,
                                            /*keyboardType: TextInputType.multiline,
                                      maxLines: null,*/
                                            decoration: !_status?const InputDecoration(
                                                hintText:
                                                "উপজেলা নাম",):const InputDecoration(
                                                hintText: "উপজেলা নাম",border: InputBorder.none),
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
                                                    ._unionNameController,
                                                decoration:!_status?
                                                InputDecoration(
                                                  hintText:
                                                  'ইউনিয়ন অথবা পৌরসভা নির্বাচন করুন',
                                                  suffixIcon: IconButton(
                                                    icon: Icon(Icons.clear),
                                                    onPressed: (){
                                                      setState(() {
                                                        _unionNameController.clear();
                                                      });
                                                    },
                                                  ),):InputDecoration(hintText: 'ইউনিয়ন অথবা পৌরসভা নির্বাচন করুন',border: InputBorder.none),
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
                                              this._unionNameController.text =
                                                  suggestion.upPourashavaName;
                                              setState(() {
                                                _upId=suggestion.upPourashavaId;
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
                                              'NID নম্বর ',
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
                                              _nidController,
                                              decoration: !_status?const InputDecoration(
                                                  hintText: "NID নম্বর লিখুন"):InputDecoration(
                                                hintText: "NID নম্বর লিখুন",border: InputBorder.none),
                                              enabled: !_status,
                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                        Flexible(
                                          child: TypeAheadFormField<YearJsonData>(
                                            textFieldConfiguration: TextFieldConfiguration(
                                              decoration:!_status? InputDecoration(
                                                hintText: "অর্থবছর নির্বাচন করুন",
                                                suffixIcon: IconButton(
                                                  icon: Icon(Icons.clear),
                                                  onPressed: (){
                                                    setState(() {
                                                      _yearController.clear();
                                                    });
                                                  },
                                                ),

                                              ): InputDecoration(
                                                hintText: "অর্থবছর নির্বাচন করুন",
                                                border: InputBorder.none
                                              ),
                                              enabled: !_status,
                                              controller: this._yearController,


                                            ),

                                            suggestionsCallback: (pattern) {
                                              //ledgerList.retainWhere((element) => element.ledgerName.toLowerCase().contains(pattern.toLowerCase()))
                                              return getSuggestionsYear(pattern);
                                            },
                                            itemBuilder: (context, suggestion) {
                                              return ListTile(
                                                title: Text(suggestion.financialYear),
                                              );
                                            },
                                            transitionBuilder: (context, suggestionsBox, controller) {
                                              return suggestionsBox;
                                            },
                                            onSuggestionSelected: (suggestion) {
                                              this._yearController.text = suggestion.financialYear;
                                              setState(() {
                                                _financialYearId=suggestion.financialYearId;
                                              });
                                            },
                                            validator: (value) =>
                                            value.isEmpty ? 'অর্থবছর নির্বাচন আবশ্যক' : null,
                                            //onSaved: (value) => this._selectedCity = value,
                                          ),/*new TextField(
                                            controller: _yearController,
                                            decoration: const InputDecoration(
                                                hintText: "অর্থবছর নির্বাচন করুন"),
                                            enabled: false,
                                          ),*/
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
                                              'জন্ম তারিখ',
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
                                              'গ্রাহকের ধরন',
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
                                            child: new DateTimeField(
                                              resetIcon:_status? null:Icon(Icons.clear),
                                              controller: _dateOfBarthController,
                                              decoration: !_status?const InputDecoration(
                                                  hintText: "জন্ম তারিখ"):InputDecoration(
                                                  hintText: "জন্ম তারিখ",border: InputBorder.none),
                                              format: formatDate,
                                              onShowPicker:
                                                  (context, currentValue) {
                                                return showDatePicker(
                                                    context: context,
                                                    helpText:
                                                    "জন্ম তারিখ নির্বাচন করুন",
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
                                          child:  RadioGroup<String>.builder(
                                            direction: Axis.vertical,
                                            groupValue: _verticalGroupValue,

                                            onChanged: (value) {
                                             if(!_status){
                                               setState(() {
                                                 _verticalGroupValue=value;
                                               });
                                             }
                                            },
                                            items: _type,
                                            itemBuilder: (item) => RadioButtonBuilder(
                                              item,
                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                    )),

                                Padding(
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
                                              'গ্রাহককের নাম',
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
                                            controller: _userNameController,
                                            decoration: !_status?const InputDecoration(
                                                hintText:
                                                    "গ্রাহককের নাম লিখুন"):InputDecoration(
                                                hintText:
                                                "গ্রাহককের নাম লিখুন",border: InputBorder.none),
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
                                              'মোবাইল নম্বর',
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
                                            controller: _userPhoneController,
                                            decoration: !_status?const InputDecoration(
                                                hintText: "মোবাইল নম্বর লিখুন"):InputDecoration(
                                                hintText: "মোবাইল নম্বর লিখুন",border: InputBorder.none),
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
                                              'পিতার নাম',
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
                                              'মাতার নাম',
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
                                                  _fathersNameController,
                                              decoration: !_status?const InputDecoration(
                                                  hintText: "পিতার নাম লিখুন"):InputDecoration(
                                                  hintText: "পিতার নাম লিখুন",border: InputBorder.none),
                                              enabled: !_status,
                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                        Flexible(
                                          child: new TextField(
                                            controller: _mothersNameController,
                                            decoration: !_status?const InputDecoration(
                                                hintText: "মাতার নাম লিখুন"):InputDecoration(
                                                hintText: "মাতার নাম লিখুন",border: InputBorder.none),
                                            enabled: !_status,
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                    )),
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
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'ঠিকানা',
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
                                            controller: _addressController,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            decoration: !_status?const InputDecoration(
                                                hintText: "ঠিকানা লিখুন"):InputDecoration(
                                                hintText: "ঠিকানা লিখুন",border: InputBorder.none),
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
                                              'বরাদ্ধকৃত ঘরের ঠিকানা',
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
                                                _boraddoAddressController,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            decoration: !_status?const InputDecoration(
                                                hintText:
                                                    "বরাদ্ধকৃত ঘরের ঠিকানা লিখুন"):InputDecoration(
                                                hintText:
                                                "বরাদ্ধকৃত ঘরের ঠিকানা লিখুন",border: InputBorder.none),
                                            enabled: !_status,
                                          ),
                                        ),
                                      ],
                                    )),
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
                                                  hintText: "তথ্য সংগ্রহকারী"):InputDecoration(
                                                  hintText: "তথ্য সংগ্রহকারী",border: InputBorder.none),
                                              enabled: false,
                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                        Flexible(
                                          child: new TextField(
                                            controller: _createdDateController,
                                            decoration:!_status? const InputDecoration(
                                                hintText: "তথ্য সংগ্রহের তারিখ"):InputDecoration(
                                                hintText: "তথ্য সংগ্রহের তারিখ",border: InputBorder.none),
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
                                                  hintText: "অনুমোদনকারী"):InputDecoration(
                                                  hintText: "অনুমোদনকারী",border: InputBorder.none),
                                              enabled: false,
                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                        Flexible(
                                          child: new TextField(
                                            controller: _aprovedDateController,
                                            decoration: !_status?const InputDecoration(
                                                hintText: "অনুমোদন তারিখ"):InputDecoration(
                                                hintText: "অনুমোদন তারিখ",border: InputBorder.none),
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
                                _memberDataList[0].status == '1'
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
                                            'member_id':
                                                _memberDataList[0].memberId
                                          };
                                          ApiCall()
                                              .approvedMember(task)
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
                                            'member_id':
                                                _memberDataList[0].memberId
                                          };
                                          ApiCall()
                                              .rejectMember(task)
                                              .then((value) {
                                            if (value['status'] == 200) {
                                              setState(() {
                                                loadEditTextData();
                                              });
                                              successToast(context,
                                                  "সফলভাবে বাতিলঅনুমোদন হয়েছে");
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
        ));
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
                        'type':_verticalGroupValue=='গৃহহীন'?'1':'2',
                        'financial_year_id':_financialYearId!=null?_financialYearId:memberData.financialYearId,
                        'up_pourashava_id':_upId==null?memberData.upPourashavaId:_upId,
                        'member_name':_userNameController.text,
                        'father_name':_fathersNameController.text,
                        'mother_name':_mothersNameController.text,
                        'date_of_birth':_dateOfBarthController.text.split(' ').first,
                        'nid':_nidController.text,
                        'mobile_number':_userPhoneController.text,
                        'address':_addressController.text,
                        'house_construction_address':_boraddoAddressController.text,
                        'old_image':oldImage,
                        'image':_image != null ? await MultipartFile.fromFile(_image.path,filename: _image.path.split('/').last):'',
                        "member_id":memberData.memberId
                      });
                      DioApiCall().dioUpdateMemberEntry(formData).then((value) {
                        if(value['status']==200){
                          setState(() {
                            loadEditTextData();
                            //_isLoading=false;
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
                      print(memberData.financialYearId);
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
              Text('ঘর নির্মানের তথ্য',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: AppTheme.mainColor,decoration: TextDecoration.underline),),
              _houseInfo.isNotEmpty?GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _houseInfo.length,
                  gridDelegate:
                  // crossAxisCount stands for number of columns you want for displaying
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {

                    // return your grid widget here, like how your images will be displayed
                    return GestureDetector(
                      onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MapImageShow(lat:_houseInfo[index].latitude,long:_houseInfo[index].longitude,image:_houseInfo[index].fileDirectory+_houseInfo[index].image,details:_houseInfo[index].details))),
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
                                      _houseInfo[index].fileDirectory+_houseInfo[index].image
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Card(
                                  color: _houseInfo[index].status=='1'?AppTheme.mainColor:AppTheme.nearlyWhite,
                                  child: Padding(
                                    padding: EdgeInsets.all(2),
                                    child: _houseInfo[index].status=='1'?Text('সম্পন্ন',style: TextStyle(color: Colors.white),)
                                        :Text('অসম্পন্ন',style: TextStyle(color: Colors.red),)
                                  ),
                                ),
                              ),
                            ),
                            // Padding(padding: EdgeInsets.all(5),
                            // child: Text("বিবরণ: "+_houseInfo[index].details),),
                            Padding(
                              padding: EdgeInsets.all(2),
                              child: Text('তারিখ: '+_houseInfo[index].entryDate),
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
