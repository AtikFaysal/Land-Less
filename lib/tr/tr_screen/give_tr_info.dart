import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/model/up_data.dart';
import 'package:land_less/model/year_data.dart';
import 'package:land_less/service/tr_apiService.dart';
import 'package:land_less/widget/texttile.dart';
import 'package:land_less/widget/toast_massage.dart';
class TrGiveInfoPage extends StatefulWidget {
  LoginResponse loginResponse;

  TrGiveInfoPage(this.loginResponse);

  @override
  _TrGiveInfoPageState createState() => _TrGiveInfoPageState(loginResponse);
}

class _TrGiveInfoPageState extends State<TrGiveInfoPage> {
  LoginResponse loginResponse;

  _TrGiveInfoPageState(this.loginResponse);
  bool _isLoading=false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final formatDate = DateFormat("yyyy-MM-dd");
  TextEditingController _YearController=TextEditingController();
  TextEditingController _unController=TextEditingController();
  TextEditingController _nameControler=TextEditingController();
  TextEditingController _addressControler=TextEditingController();
  TextEditingController _commentControler=TextEditingController();
  TextEditingController _amountControler=TextEditingController();
  String _name,_address,_comment,_amount,_projectStartDate,_projectCompletionDate,_projectEndDate;

  List<YearJsonData>_yearJsonData=[];
  String _financialYearId;
  List<UpData>_upList=[];
  String _upPourosovaId;

  void loadFinancialYear(){
    if(loginResponse.yearJsonData.isNotEmpty){
      for(int i=0;i<loginResponse.yearJsonData.length;i++){
        setState(() {
          _yearJsonData.add(loginResponse.yearJsonData[i]);
        });
      }
    }
  }
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
  List<YearJsonData> getSuggestionsYear(String query) {
    List<YearJsonData> matches = List();
    matches.addAll(_yearJsonData);
    matches.retainWhere((s) =>   s.financialYear.contains(query.toLowerCase()));
    return matches;
  }

  void clearData(){
    _YearController.clear();
    _unController.clear();
    _nameControler.clear();
    _addressControler.clear();
    _commentControler.clear();
    _amountControler.clear();
  }
  @override
  void initState() {
    // TODO: implement initState
    loadFinancialYear();
    loadUpData();
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
                _buildProjectName(),
                SizedBox(height: 20,),
                _buildProjectConstractionAddress(),
                SizedBox(height: 20,),
                _buildComment(),
                SizedBox(height: 20,),
                _buildAssignAmountNumber(),
                SizedBox(height: 20,),
                _buildProjectStartdate(),
                SizedBox(height: 20,),
                _buildProjectCompletionData(),
                SizedBox(height: 20,),
                //_buildProjectEnddate(),
                //SizedBox(height: 20,),
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
          Map<String,dynamic>task={
            'device_id':loginResponse.response.deviceId,
            'user_id':loginResponse.response.userId,
            'user_role':loginResponse.response.userRole,
            'financial_year_id':_financialYearId,
            'up_pourashava_id':_upPourosovaId,
            'project_name':_name,
            'project_construction_address':_address,
            'comments':_comment,
            'assigned_amount':_amount,
            'project_start_date':_projectStartDate,
            //'project_end_date':_projectEndDate,
            'completion_of_project':_projectCompletionDate
          };
          TrApi().trProjectEntry(task).then((value) {
            if(value['status']==200){
              setState(() {
                clearData();
                _isLoading=false;
              });
              successToast(context, ' সফলভাবে প্রকল্পের তথ্য সংরক্ষণ হয়েছে');
            }else if(value['status']==401){
              setState(() {
                _isLoading=false;
              });
              showToastMassage(context, 'দুঃখিত ! প্রকল্পের তথ্য সংরক্ষণ হয়নি');
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
  Widget _buildProjectName() {
    return TextFormField(
      controller: _nameControler,
      decoration: InputDecoration(
        labelText: "প্রকল্পের নাম",
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
      maxLength: null,
      validator: (String value) {
        if (value.isEmpty) {
          return 'প্রকল্পের নাম আবশ্যক';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildProjectStartdate(){
    return DateTimeField(
      //controller: _dateControler,
      validator: (value) {
        if (value==null) {
          return 'প্রকল্প শুরুর তারিখ নির্বাচন করুন';
        }

        return null;
      },
      onChanged: (value){
        setState(() {
          _projectStartDate=value.toString();
        });
      },
      onSaved: (value) {
        _projectStartDate = value.toString();
      },
      decoration: InputDecoration(
        labelText: "প্রকল্প শুরুর তারিখ নির্বাচন করুন",
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
            helpText: "প্রকল্প শুরুর তারিখ নির্বাচন করুন",
            firstDate: DateTime(1950),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },

    );
  }
  Widget _buildProjectCompletionData(){
    return DateTimeField(
      //controller: _dateControler,
      validator: (value) {
        if (value==null) {
          return 'প্রকল্প শেষ হওয়ার নির্ধারিত তারিখ নির্বাচন করুন';
        }

        return null;
      },
      onChanged: (value){
        setState(() {
          _projectCompletionDate=value.toString();
        });
      },
      onSaved: (value) {
        _projectCompletionDate = value.toString();
      },
      decoration: InputDecoration(
        labelText: "প্রকল্প শেষ হওয়ার নির্ধারিত তারিখ নির্বাচন করুন",
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
            helpText: "প্রকল্প শেষ হওয়ার নির্ধারিত তারিখ নির্বাচন করুন",
            firstDate: DateTime(1950),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },

    );
  }
  Widget _buildProjectEnddate(){
    return DateTimeField(
      //controller: _dateControler,
      validator: (value) {
        if (value==null) {
          return 'প্রকল্প শেষের তারিখ নির্বাচন করুন';
        }

        return null;
      },
      onChanged: (value){
        setState(() {
          _projectEndDate=value.toString();
        });
      },
      onSaved: (value) {
        _projectEndDate = value.toString();
      },
      decoration: InputDecoration(
        labelText: "প্রকল্প শেষের তারিখ নির্বাচন করুন",
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
            helpText: "প্রকল্প শেষের তারিখ নির্বাচন করুন",
            firstDate: DateTime(1950),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },

    );
  }
  Widget _buildAssignAmountNumber() {
    return TextFormField(
      controller: _amountControler,
      decoration: InputDecoration(
        labelText: "প্রকল্পে বরাদ্দের পরিমাণ",
        labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
        fillColor: Colors.white,
        hintText: 'ex-1000.0',
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
        _amount = value;
      },
    );
  }
  Widget _buildProjectConstractionAddress() {
    return TextFormField(
      controller: _addressControler,
      maxLines: 3,
      maxLength: 100,
      decoration: InputDecoration(
        labelText: "প্রকল্প বাস্তবায়নের ঠিকানা",
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
          return 'প্রকল্পের বাস্তবায়নের ঠিকানা আবশ্যক';
        }

        return null;
      },
      onSaved: (String value) {
        _address = value;
      },
    );
  }
  Widget _buildComment() {
    return TextFormField(
      controller: _commentControler,
      maxLines: 3,
      maxLength: 100,
      decoration: InputDecoration(
        labelText: "মন্তব্য",
        labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
        fillColor: Colors.white,
        hintText: "মন্তব্য লিখুন ",
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
          return 'মন্তব্য আবশ্যক';
        }

        return null;
      },
      onSaved: (String value) {
        _comment = value;
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
}
