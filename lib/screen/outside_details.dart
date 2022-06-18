import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/model/public_member_ById.dart';
import 'package:land_less/service/apiService.dart';
class OutsideDetails extends StatefulWidget {
  String memberId;

  OutsideDetails(this.memberId);

  @override
  _OutsideDetailsState createState() => _OutsideDetailsState(memberId);
}

class _OutsideDetailsState extends State<OutsideDetails> {
  String memberId;


  _OutsideDetailsState(this.memberId);

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

  List<PuSingleMemberData>_puSingleMember=[];
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
    ApiCall().getPublicMemberById(memberId).then((value) {
      if(value.status==200){
        if(value.puSingleMemberData.isNotEmpty){
          for(int i=0;i<value.puSingleMemberData.length;i++){
            setState(() {
              _puSingleMember.add(value.puSingleMemberData[i]);
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
                                      decoration: InputDecoration(
                                        hintText: "উপজেলা নাম",
                                      ),

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
                                            hintText: "NID নম্বর লিখুন"),
                                        enabled: !_status,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: new TextField(
                                      controller: _yearController,
                                      decoration: const InputDecoration(
                                          hintText: "অর্থবছর নির্বাচন করুন"),
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
                                        decoration: const InputDecoration(
                                            hintText: "জন্ম তারিখ"),
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
                                          "গ্রাহককের নাম লিখুন"),
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
                                          hintText: "মোবাইল নম্বর লিখুন"),
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
                                            hintText: "পিতার নাম লিখুন"),
                                        enabled:false,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: new TextField(
                                      controller: _mothersNameController,
                                      decoration: const InputDecoration(
                                          hintText: "মাতার নাম লিখুন"),
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
                                          hintText: "ঠিকানা লিখুন"),
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
                                          "বরাদ্ধকৃত ঘরের ঠিকানা লিখুন"),
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
                                            hintText: "তথ্য সংগ্রহকারী"),
                                        enabled: false,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: new TextField(
                                      controller: _createdDateController,
                                      decoration: const InputDecoration(
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
                                          hintText: "অনুমোদনকারী"),
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
}

