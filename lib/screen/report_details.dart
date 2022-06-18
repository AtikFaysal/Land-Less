import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/model/house_information.dart';
import 'package:land_less/model/landless_memberList.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/model/member_data.dart';
import 'package:land_less/model/public_member_ById.dart';
import 'package:land_less/service/apiService.dart';
import 'package:land_less/widget/image_details.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
class HouseReportDetails extends StatefulWidget {
  LoginResponse loginResponse;
  String memberId;

  HouseReportDetails(this.memberId,this.loginResponse);

  @override
  _HouseReportDetailsState createState() => _HouseReportDetailsState(memberId,loginResponse);
}

class _HouseReportDetailsState extends State<HouseReportDetails> {
  LoginResponse loginResponse;
  String memberId;


  _HouseReportDetailsState(this.memberId,this.loginResponse);

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

  List<MemberData>_puSingleMember=[];
  List<HouseInformation>_houseInfo=[];
  bool _isLoading=false;
  final formatDate = DateFormat("yyyy-MM-dd");
  final FocusNode myFocusNode = FocusNode();

  bool _status=false;
  String _verticalGroupValue;

  List<String> _type = ["গৃহহীন", "ভূমিহীন"];

  void loadEditTextData(){
    setState(() {
      _isLoading=true;
    });
    _puSingleMember.clear();
    _houseInfo.clear();
    Map<String,dynamic>task={
      'device_id':loginResponse.response.deviceId,
      'user_id':loginResponse.response.userId,
      'user_role':loginResponse.response.userRole,
      'member_id':memberId
    };
    ApiCall().getMemberById(task).then((value) {
      if(value['status']==200){
        LandlessMemberList landlessMemberList;
        landlessMemberList=LandlessMemberList.fromJson(value);
        for(int i=0;i<landlessMemberList.memberData.length;i++){
          setState(() {
            _puSingleMember.add(landlessMemberList.memberData[i]);
          });
        }
        for(int j=0;j<landlessMemberList.houseInformation.length;j++){
          setState(() {
            _houseInfo.add(landlessMemberList.houseInformation[j]);
          });
        }
          setState(() {
            _upojalaNamaControler.value=TextEditingValue(text: _puSingleMember[0].upazilaName.toString());
            _unionNameController.value=TextEditingValue(text: _puSingleMember[0].upPourashavaName);
            _nidController.value=TextEditingValue(text: _puSingleMember[0].nid);
            _yearController.value=TextEditingValue(text:"2020-2021");
            _dateOfBarthController.value=TextEditingValue(text:_puSingleMember[0].dateOfBirth);
            _userNameController.value=TextEditingValue(text: _puSingleMember[0].memberName);
            _userPhoneController.value=TextEditingValue(text: _puSingleMember[0].mobileNumber);
            _fathersNameController.value=TextEditingValue(text: _puSingleMember[0].fatherName);
            _mothersNameController.value=TextEditingValue(text: _puSingleMember[0].motherName);
            _mothersNameController.value=TextEditingValue(text: _puSingleMember[0].motherName);
            _addressController.value=TextEditingValue(text: _puSingleMember[0].address);
            _boraddoAddressController.value=TextEditingValue(text: _puSingleMember[0].houseConstructionAddress);
            _createdByController.value=TextEditingValue(text: _puSingleMember[0].createdBy);
            _createdDateController.value=TextEditingValue(text: _puSingleMember[0].entryDate);
            _aprovedByController.value=TextEditingValue(text: _puSingleMember[0].approvedBy==null?"":_puSingleMember[0].approvedBy);
            _verticalGroupValue=_puSingleMember[0].type=="1"?'গৃহহীন':'ভূমিহীন';
            _isLoading=false;
          });
        }
      }
    );

  }

  @override
  void initState() {
    // TODO: implement initState
    loadEditTextData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton:FloatingActionButton.extended(
          onPressed: () => houseInfoList(context),
          label: Text('ঘর নির্মাণের তথ্য দেখুন'),
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
                                      image: new DecorationImage(
                                        image: _puSingleMember[0]
                                            .image !=
                                            ''
                                            ? NetworkImage(
                                            _puSingleMember[0].fileDirectory+
                                                _puSingleMember[0].image)
                                            : ExactAssetImage(
                                            'assets/images/person.png'),
                                        fit: BoxFit.cover,
                                      )
                                  ),
                                )
                              ],
                            ),

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
                                        'উপজেলা',
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
                                        'ইউনিয়ন',
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
                                    child: new TextFormField(

                                      controller: _upojalaNamaControler,
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: AppTheme.nearlyBlack),
                                      decoration: const InputDecoration(
                                          hintText: "উপজেলা নাম",border: InputBorder.none),

                                      enabled:false,
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding:
                                      EdgeInsets.only(left: 10.0),
                                      child: new TextFormField(

                                        controller: _unionNameController,
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: AppTheme.nearlyBlack),
                                        decoration: InputDecoration(
                                          hintText: "ইউনিয়ন নাম",
                                            border: InputBorder.none
                                        ),

                                        enabled:false,
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
                                        decoration: const InputDecoration(
                                            hintText: "NID নম্বর লিখুন",border: InputBorder.none),
                                        enabled: !_status,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: new TextField(
                                      controller: _yearController,
                                      decoration: const InputDecoration(
                                          hintText: "অর্থবছর নির্বাচন করুন",border: InputBorder.none),
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
                                        controller: _dateOfBarthController,
                                        resetIcon: null,
                                        decoration: const InputDecoration(
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
                                        enabled: false,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child:  RadioGroup<String>.builder(
                                      direction: Axis.vertical,
                                      groupValue: _verticalGroupValue,

                                      onChanged: (value) {
                                        if(_status){
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
                                      decoration: const InputDecoration(
                                          hintText:
                                          "গ্রাহককের নাম লিখুন",border: InputBorder.none),
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
                                      decoration: const InputDecoration(
                                          hintText: "মোবাইল নম্বর লিখুন",border: InputBorder.none),
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
                                        decoration: const InputDecoration(
                                            hintText: "পিতার নাম লিখুন",border: InputBorder.none),
                                        enabled:false,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: new TextField(
                                      controller: _mothersNameController,
                                      decoration: const InputDecoration(
                                          hintText: "মাতার নাম লিখুন",border: InputBorder.none),
                                      enabled: false,
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
                                      decoration: const InputDecoration(
                                          hintText: "ঠিকানা লিখুন",border: InputBorder.none),
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
                                      decoration: const InputDecoration(
                                          hintText:
                                          "বরাদ্ধকৃত ঘরের ঠিকানা লিখুন",border: InputBorder.none),
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
                                            hintText: "তথ্য সংগ্রহকারী",border: InputBorder.none),
                                        enabled: false,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: new TextField(
                                      controller: _createdDateController,
                                      decoration: const InputDecoration(
                                          hintText: "তথ্য সংগ্রহের তারিখ",border: InputBorder.none),
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
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'অনুমোদনকারী',
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
                                      controller: _aprovedByController,
                                      keyboardType:
                                      TextInputType.multiline,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                          hintText: "অনুমোদনকারী",border: InputBorder.none),
                                      enabled: false,
                                    ),
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
        ));
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
                      onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailScreen(_houseInfo[index].fileDirectory+_houseInfo[index].image,_houseInfo[index].details))),
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
                           /* Padding(padding: EdgeInsets.all(5),
                              child: Text("বিবরণ: "+_houseInfo[index].details),),*/
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

