import 'dart:convert';
import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/AppTheme/light_color.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/model/post_landless_member.dart';
import 'package:land_less/model/up_data.dart';
import 'package:land_less/model/year_data.dart';
import 'package:land_less/screen/landless_people_list.dart';
import 'package:land_less/service/apiService.dart';
import 'package:land_less/service/dioApiCall.dart';
import 'package:land_less/widget/extension.dart';
import 'package:land_less/widget/texttile.dart';
import 'package:http/http.dart' as http;
import 'package:land_less/widget/toast_massage.dart';
class GiveLandlessInfo extends StatefulWidget {
  LoginResponse loginResponse;

  GiveLandlessInfo(this.loginResponse);

  @override
  _GiveLandlessInfoState createState() => _GiveLandlessInfoState(loginResponse);
}

class _GiveLandlessInfoState extends State<GiveLandlessInfo> {
  LoginResponse loginResponse;

  _GiveLandlessInfoState(this.loginResponse);
  final _picker = ImagePicker();
  TextEditingController _unController=new TextEditingController();
  TextEditingController _nameControler=new TextEditingController();
  TextEditingController _fatherController=new TextEditingController();
  TextEditingController _motherController=new TextEditingController();
  TextEditingController _nidController=new TextEditingController();
  TextEditingController _dateControler=new TextEditingController();
  TextEditingController _phoneController=new TextEditingController();
  TextEditingController _addressController=new TextEditingController();
  TextEditingController _boraddoController=new TextEditingController();
  TextEditingController _YearController=new TextEditingController();
  bool _isLoading=false;
  String _name;
  String _father;
  String _mother;
  String _nationalIdNo;
  String _phoneNumber;
  String _address;
  String _constractAddress;
  String _selectUpId;
  String _birthDate;
  File _image;

  List<UpData>_upList=[];
  String _upPourosovaId;
  List<YearJsonData>_yearJsonData=[];
  String _financialYearId;

  String _verticalGroupValue='গৃহহীন';

  List<String> _status = ["গৃহহীন", "ভূমিহীন"];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final formatDate = DateFormat("yyyy-MM-dd");

  void loadUpData(){
    for(int i=0;i<loginResponse.upData.length;i++){
      setState(() {
        _upList.add(loginResponse.upData[i]);
      });
    }
  }
  List<UpData> getSuggestions(String query) {
    List<UpData> matches = List();
    matches.addAll(_upList);
    matches.retainWhere((s) =>   s.upPourashavaName.contains(query.toLowerCase()));
    return matches;
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
  void clearData(){
    _nameControler.clear();
    _fatherController.clear();
    _motherController.clear();
    _nidController.clear();
    _dateControler.clear();
    _unController.clear();
    _YearController.clear();
    _phoneController.clear();
    _addressController.clear();
    _boraddoController.clear();
    _image=null;
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
  Widget _buildName() {
    return TextFormField(
      controller: _nameControler,
      decoration: InputDecoration(
        labelText: "গ্রাহকের নাম",
        labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
              color: Colors.green.shade400,
              width: 2
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
            color: AppTheme.mainColor,
            width: 2.0,
          ),
        ),
      ),
      //maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'নাম আবশ্যক';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      controller: _fatherController,
      decoration: InputDecoration(
        labelText: "পিতার নাম",
        labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
              color: Colors.green.shade400,
              width: 2
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
            color: AppTheme.mainColor,
            width: 2.0,
          ),
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'পিতার নাম আবশ্যক';
        }

        /*if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }*/

        return null;
      },
      onSaved: (String value) {
        _father = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      controller: _motherController,
      decoration: InputDecoration(
        labelText: "মাতার নাম",
        labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
              color: Colors.green.shade400,
              width: 2
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
            color: AppTheme.mainColor,
            width: 2.0,
          ),
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'মাতার নাম আবশ্যক';
        }

        return null;
      },
      onSaved: (String value) {
        _mother = value;
      },
    );
  }

  Widget _buildIdCardNumber() {
    return TextFormField(
      controller: _nidController,
      decoration: InputDecoration(
        labelText: "NID নম্বর",
        labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
              color: Colors.green.shade400,
              width: 2
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
            color: AppTheme.mainColor,
            width: 2.0,
          ),
        ),
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'NID নম্বর আবশ্যক';
        }

        return null;
      },
      onSaved: (String value) {
        _nationalIdNo = value;
      },
    );
  }

  Widget _buildBirthdate(){
    return DateTimeField(
      //controller: _dateControler,
      validator: (value) {
        if (value==null) {
          return 'জন্ম তারিখ নির্বাচন করুন';
        }

        return null;
      },
      onChanged: (value){
        setState(() {
          _birthDate=value.toString();
        });
      },
      onSaved: (value) {
        _birthDate = value.toString();
      },
      decoration: InputDecoration(
        labelText: "জন্ম তারিখ নির্বাচন করুন",
        labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
        fillColor: Colors.white,
        suffixIcon: Icon(Icons.calendar_today),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
              color: Colors.green.shade400,
              width: 2
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
            color: AppTheme.mainColor,
            width: 2.0,
          ),
        ),
      ),
      format: formatDate,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            helpText: "জন্ম তারিখ নির্বাচন করুন",
            firstDate: DateTime(1950),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },

    );
  }
  Widget _buildPhoneNumber() {
    return TextFormField(
      controller: _phoneController,
      decoration: InputDecoration(
        labelText: "ফোন নম্বর",
        labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
              color: Colors.green.shade400,
              width: 2
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
            color: AppTheme.mainColor,
            width: 2.0,
          ),
        ),
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'ফোন নম্বর আবশ্যক';
        }

        return null;
      },
      onSaved: (String value) {
        _phoneNumber = value;
      },
    );
  }
  Widget _buildAddress() {
    return TextFormField(
      controller: _addressController,
      maxLines: 3,
      maxLength: 100,
      decoration: InputDecoration(
        labelText: "ঠিকানা",
        labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
        fillColor: Colors.white,
        hintText: "বাড়ী/হোল্ডিং নং,গ্রাম ,ওয়ার্ড নং,ডাকঘর ,উপজেলা ,জেলা ",
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
              color: Colors.green.shade400,
              width: 2
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
            color: AppTheme.mainColor,
            width: 2.0,
          ),
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'ঠিকানা আবশ্যক';
        }

        return null;
      },
      onSaved: (String value) {
        _address = value;
      },
    );
  }
  Widget _buildFixHomeAddress() {
    return TextFormField(
      controller: _boraddoController,
      maxLines: 3,
      maxLength: 100,
      decoration: InputDecoration(
        labelText: "বরাদ্ধকৃত ঘরের ঠিকানা",
        labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
        fillColor: Colors.white,
        hintText: "বাড়ী/হোল্ডিং নং,গ্রাম ,ওয়ার্ড নং,ডাকঘর ,উপজেলা ,জেলা ",
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
              color: Colors.green.shade400,
              width: 2
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
            color: AppTheme.mainColor,
            width: 2.0,
          ),
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'ঠিকানা আবশ্যক';
        }

        return null;
      },
      onSaved: (String value) {
        _constractAddress = value;
      },
    );
  }
  Widget _buildDropDownUp() {
    return  TypeAheadFormField<UpData>(
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
          labelText: "ইউনিয়ন অথবা পৌরসভা নাম লিখুন",
          labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
          fillColor: Colors.white,
          hintText: "ইউনিয়ন অথবা পৌরসভা নাম লিখুন",
          //hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: (){
              setState(() {
                _unController.clear();
              });
            },
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide(
                color: Colors.green.shade400,
                width: 2
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide(
              color: AppTheme.mainColor,
              width: 2.0,
            ),
          ),
        ),
        /*style: TextStyle(
            fontSize: 18,
            color: Colors.black
        ),*/
        controller: this._unController,


      ),

      suggestionsCallback: (pattern) {
        //ledgerList.retainWhere((element) => element.ledgerName.toLowerCase().contains(pattern.toLowerCase()))
        return getSuggestions(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.upPourashavaName),
        );
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (suggestion) {
        this._unController.text = suggestion.upPourashavaName;
        setState(() {
          _upPourosovaId=suggestion.upPourashavaId;
        });
      },
      validator: (value) =>
      value.isEmpty ? 'ইউনিয়ন অথবা পৌরসভা নাম আবশ্যক' : null,
      //onSaved: (value) => this._selectedCity = value,
    );
  }
  Widget imagePickerButton(BuildContext context){
    return Center(
      child: _image!=null?GestureDetector(
        child: new Container(
          width: 140.0,
          height: 140.0,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            image: new DecorationImage(
              image: FileImage(_image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        onTap: () =>_showPicker(context),
      ):new FlatButton(
          child: new Text('গ্রাহকের ছবি নির্বাচন করুন',style: TextStyle(color: AppTheme.subColors,fontSize: 18,fontWeight: FontWeight.w500),),
          onPressed: ()=>_showPicker(context),
        shape: RoundedRectangleBorder(side: BorderSide(
            color: AppTheme.mainColor,
            width: 1,
            style: BorderStyle.solid
        ), borderRadius: BorderRadius.circular(8)),
      )
    );
  }
  Widget _buildFinancialYear() {
    return  TypeAheadFormField<YearJsonData>(
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
          labelText: "অর্থবছর",
          labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
          fillColor: Colors.white,
          hintText: "অর্থবছর নির্বাচন করুন",
          //hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: (){
              setState(() {
                _YearController.clear();
              });
            },
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide(
                color: Colors.green.shade400,
                width: 2
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide(
              color: AppTheme.mainColor,
              width: 2.0,
            ),
          ),
        ),
        /*style: TextStyle(
            fontSize: 14,
            color: Colors.black
        ),*/
        controller: this._YearController,


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
        this._YearController.text = suggestion.financialYear;
        setState(() {
          _financialYearId=suggestion.financialYearId;
        });
      },
      validator: (value) =>
      value.isEmpty ? 'অর্থবছর নির্বাচন আবশ্যক' : null,
      //onSaved: (value) => this._selectedCity = value,
    );
  }
  List<YearJsonData> getSuggestionsYear(String query) {
    List<YearJsonData> matches = List();
    matches.addAll(_yearJsonData);
    matches.retainWhere((s) =>   s.financialYear.contains(query.toLowerCase()));
    return matches;
  }

  @override
  void initState() {
    // TODO: implement initState
    loadUpData();
    loadFinancialYear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: _isLoading?Center(child: CircularProgressIndicator(),):Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 /* Text('Give Shipment Details',style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: LightColor.orange,
                      fontSize: 25
                  ),),*/
                  SizedBox(height: 10,),
                  _buildFinancialYear(),
                  SizedBox(height: 20,),
                  _buildDropDownUp(),
                  SizedBox(height: 20,),
                  RadioGroup<String>.builder(
                    direction: Axis.horizontal,
                    groupValue: _verticalGroupValue,

                    onChanged: (value) {
                      setState(() {
                        _verticalGroupValue=value;
                      });
                    },
                    items: _status,
                    itemBuilder: (item) => RadioButtonBuilder(
                      item,
                    ),
                  ),
                  SizedBox(height: 20,),
                  _buildName(),
                  SizedBox(height: 20,),
                  _buildEmail(),
                  SizedBox(height: 20,),
                  _buildPassword(),
                  SizedBox(height: 20,),
                  _buildIdCardNumber(),
                  SizedBox(height: 20,),
                  _buildBirthdate(),
                  SizedBox(height: 20,),
                  _buildPhoneNumber(),
                  SizedBox(height: 20,),
                  _buildAddress(),
                  SizedBox(height: 20),
                  _buildFixHomeAddress(),
                  SizedBox(height: 20,),
                  imagePickerButton(context),
                  SizedBox(height: 20,),
                  _submitButton(context),
                ],
              ),
            ),
          ),
        ),
    );
  }
  Widget _submitButton(BuildContext context) {
    return FlatButton(
        onPressed: ()async {
          if (!_formKey.currentState.validate()) {
            return;
          }
          _formKey.currentState.save();
          //DBProvider.db.deleteAllCart();
          setState(() {
            _isLoading=true;
          });
       /*   Map<String,dynamic>task={
            'device_id':loginResponse.response.deviceId,
            'user_id':loginResponse.response.userId,
            'user_role':loginResponse.response.userRole,
            'type':_verticalGroupValue.trim()=='গৃহহীন'?"1":"2",
            'up_pourashava_id':_upPourosovaId,
            'member_name':_name,
            'father_name':_father,
            'mother_name':_mother,
            'date_of_birth':_birthDate.split(' ').first,
            'nid':_nationalIdNo,
            'mobile_number':_phoneNumber,
            'address':_address,
            'house_construction_address':_constractAddress,
            'image':_image != null ? _image: null,
          };*/
         if(_image!=null){
           FormData formData = new FormData.fromMap({
             'device_id':loginResponse.response.deviceId,
             'user_id':loginResponse.response.userId,
             'user_role':loginResponse.response.userRole,
             'type':_verticalGroupValue.trim()=='গৃহহীন'?"1":"2",
             'up_pourashava_id':_upPourosovaId,
             'financial_year_id':_financialYearId,
             'member_name':_name,
             'father_name':_father,
             'mother_name':_mother,
             'date_of_birth':_birthDate.split(' ').first,
             'nid':_nationalIdNo,
             'mobile_number':_phoneNumber,
             'address':_address,
             'house_construction_address':_constractAddress,
             'image':await MultipartFile.fromFile(_image.path,filename: _image.path.split('/').last),
           });
           DioApiCall().uploadMemberFromDio(formData).then((value) {
             if(value['status']==200){
               setState(() {
                 clearData();
                 _isLoading=false;
               });
               successToast(context, ' সফলভাবে গ্রাহকের তথ্য সংরক্ষণ হয়েছে');
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
               showToastMassage(context,'আবশ্যক তথ্যগুলো প্রদান করুন');
             }
           });
         }else{
           setState(() {
             _isLoading=false;
           });
           showToastMassage(context, 'আনুগহ করে ছবি সহ গ্রাহককের তথ্য প্রদান করুন');
         }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: AppTheme.mainInfo,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          width: AppTheme.fullWidth(context) * .7,
          child: TitleText(
            text: 'তথ্য আপলোড করুন',
            color: AppTheme.mainColor,
            fontWeight: FontWeight.w600,
          ),
        ));
  }

  Widget _icon(
      IconData icon, {
        Color color = LightColor.iconColor,
        double size = 20,
        double padding = 10,
        bool isOutLine = false,
        Function onPressed,
      }) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      // margin: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
            color: LightColor.iconColor,
            style: isOutLine ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color:
        isOutLine ? Colors.transparent : Theme.of(context).backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Color(0xfff8f8f8),
              blurRadius: 5,
              spreadRadius: 10,
              offset: Offset(5, 5)),
        ],
      ),
      child: Icon(icon, color: color, size: size),
    ).ripple(() {
      if (onPressed != null) {
        onPressed();
      }
    }, borderRadius: BorderRadius.all(Radius.circular(13)));
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
}
