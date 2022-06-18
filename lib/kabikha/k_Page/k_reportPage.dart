import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/kabikha/k_Model/kabikha_report_model.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/model/public_data_model.dart';
import 'package:land_less/model/up_data.dart';
import 'package:land_less/model/year_data.dart';
import 'package:land_less/service/apiService.dart';
import 'package:land_less/service/khabikha_api.dart';
import 'package:land_less/utils/Constant.dart';
import 'package:land_less/widget/toast_massage.dart';

import 'kabikha_report_details.dart';
class KabikhaReportPage extends StatefulWidget {
  LoginResponse loginResponse;

  KabikhaReportPage(this.loginResponse);

  @override
  _KabikhaReportPageState createState() => _KabikhaReportPageState(loginResponse);
}

class _KabikhaReportPageState extends State<KabikhaReportPage> {
  LoginResponse loginResponse;

  _KabikhaReportPageState(this.loginResponse);

  TextEditingController _YearController=TextEditingController();
  TextEditingController _upojalaController=TextEditingController();
  TextEditingController _unionController=TextEditingController();
  TextEditingController controller=TextEditingController();
  bool _isLoading=false;
  bool _unionLoad=false;

  List<UpData>_unoUnionDataList=[];
  List<YearJsonData>_yearJsonData=[];
  String _financialYearId;
  List<PublicUpazilaData>_publicUpazilaData=[];
  String _selectUpazila;
  //Union
  List<PublicUpData>_publicUpData=[];
  String _selectUpData;
  List<String> _status = ["অনুমোদিত","প্রকল্প হস্তান্তরিত", "বাতিলকৃত"];
  String _selectStatus;
  List<KabikhaProjectData>_kabikhaData=[];
  void loadPublicData(){
    setState(() {
      _isLoading=true;
    });
    ApiCall().getPublicData().then((value) {
      if(value!=null){
        if(value.publicUpazilaData.isNotEmpty){
          for(int i=0;i<value.publicUpazilaData.length;i++){
            setState(() {
              _publicUpazilaData.add(value.publicUpazilaData[i]);
              _isLoading=false;
            });
          }
        }
      }

    });
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
  void loadUnionData(String upozila_Id){
    _publicUpData.clear();
    setState(() {
      _unionLoad=true;
    });
    ApiCall().getUnionData(upozila_Id).then((value) {
      print(value.toJson());
      if(value!=null){
        if(value.publicUpData.isNotEmpty){
          for(int i=0;i<value.publicUpData.length;i++){
            setState(() {
              _publicUpData.add(value.publicUpData[i]);
              _unionLoad=false;
            });
          }
        }
      }
    });
  }

  void loadPuMemberData(BuildContext context,Map<String,dynamic>task)async{
    KhabikhaApi().getAccordingToReportProjectById(task).then((value) {
      if(value!=null){
        _kabikhaData.clear();
        if(value.status==200){
          if(value.kabikhaProjectData.isNotEmpty){
            for(int i=0;i<value.kabikhaProjectData.length;i++){
              setState(() {
                _kabikhaData.add(value.kabikhaProjectData[i]);
                _isLoading=false;
              });
            }
          }
        }else if(value.status==401){
          setState(() {
            _isLoading=false;
          });
          showToastMassage(context, 'কোন তথ্য পাওয়া যায়নি');
        }else{
          setState(() {
            _isLoading=false;
          });
          showToastMassage(context, 'আবশ্যকীয় সকল তথ্য প্রদান করুন');
        }
      }
    });
  }

  List<PublicUpazilaData> getSuggestions(String query) {
    List<PublicUpazilaData> matches = List();
    matches.addAll(_publicUpazilaData);
    matches.retainWhere((s) =>   s.upazilaName.contains(query.toLowerCase()));
    return matches;
  }
  List<YearJsonData> getSuggestionsYear(String query) {
    List<YearJsonData> matches = List();
    matches.addAll(_yearJsonData);
    matches.retainWhere((s) =>   s.financialYear.contains(query.toLowerCase()));
    return matches;
  }
  List<PublicUpData> getSuggestionsUnion(String query) {
    List<PublicUpData> matches = List();
    matches.addAll(_publicUpData);
    matches.retainWhere((s) =>   s.upPourashavaName.contains(query.toLowerCase()));
    return matches;
  }

  void loadUnoUnionList(){
    if(loginResponse.upData.isNotEmpty){
      for(int i=0;i<loginResponse.upData.length;i++){
        setState(() {
          _unoUnionDataList.add(loginResponse.upData[i]);
        });
      }
    }
  }
  List<UpData> getSuggestionsUnoUnion(String query) {
    List<UpData> matches = List();
    matches.addAll(_unoUnionDataList);
    matches.retainWhere((s) =>   s.upPourashavaName.contains(query.toLowerCase()));
    return matches;
  }
  @override
  void initState() {
    // TODO: implement initState
    loadUnoUnionList();
    loadPublicData();
    loadFinancialYear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _isLoading?Center(child: CircularProgressIndicator(),):Container(
            height: loginResponse.response.userRole!='1'?MediaQuery.of(context).size.height*.6/2:MediaQuery.of(context).size.height*.75/2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFinancialYear(),
                    _statusDropdown()
                  ],
                ),
                SizedBox(height: 10,),
                loginResponse.response.userRole=='1'?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDropDownUp(),
                    _buildUnionField(),
                  ],
                ):_buildUnoUnionField(),

                SizedBox(height: 10,),
                okButton(context),
              ],
            ),
          ),
          _kabikhaData.isNotEmpty?Container(
            height:double.parse(_kabikhaData.length.toString())*225.0,
            child: listMember(context),
          ):Text('')
        ],
      ),
    );
  }

  Widget okButton(BuildContext context){
    return Center(
      child: Container(
        child: ElevatedButton.icon(
          label: Text("রিপোর্ট দেখুন",style: TextStyle(
              color: AppTheme.mainColor,
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),),
          icon: Icon(Icons.search_outlined,color: AppTheme.mainColor,),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              if (states.contains(MaterialState.selected))
                return AppTheme.subColors;
              return AppTheme.mainInfo;  // Use the default value.
            }),
          ),
          onPressed: (){
            setState(() {
              _isLoading=true;
            });
            var status;
            if(_selectStatus!=null){
              if(_selectStatus.trim()=='অনুমোদিত'){
                status='2';
              }else if(_selectStatus.trim()=='প্রকল্প হস্তান্তরিত'){
                status='3';
              }else{
                status='0';
              }
            }
            if(_financialYearId!=null){
              Map<String,dynamic>task={
                'device_id':loginResponse.response.deviceId,
                'user_id':loginResponse.response.userId,
                'user_role':loginResponse.response.userRole,
                'financial_year_id':_financialYearId,
                'upazila_id':_selectUpazila!=null?_selectUpazila:loginResponse.response.upazilaId,
                'up_pourashava_id':_selectUpData!=null?_selectUpData:'',
                'status':status!=null?status:""
              };
              print(task);
              setState(() {
                loadPuMemberData(context, task);
              });
            }else{
              setState(() {
                _isLoading=false;
              });
              showToastMassage(context, 'উপজেলা এবং অর্থবছর নির্বাচন করুন');
            }
          },

        ),
      ),
    );
  }
  Widget _buildFinancialYear() {
    return  Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 15),
      child: Container(
        width: MediaQuery.of(context).size.width*1.3/3,
        height: MediaQuery.of(context).size.height/15,
        child: TypeAheadFormField<YearJsonData>(
          textFieldConfiguration: TextFieldConfiguration(
            decoration: InputDecoration(
              labelText: "অর্থবছর",
              labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
              fillColor: Colors.white,
              hintText: "অর্থবছর নির্বাচন করুন",
              hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
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
            style: TextStyle(
                fontSize: 14,
                color: Colors.black
            ),
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
        ),
      ),
    );
  }
  Widget _buildDropDownUp() {
    return  Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Container(
        width: MediaQuery.of(context).size.width*1.3/3,
        height: MediaQuery.of(context).size.height/15,
        child: TypeAheadFormField<PublicUpazilaData>(
          textFieldConfiguration: TextFieldConfiguration(
            decoration: InputDecoration(
              labelText: "উপজেলা",
              labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
              fillColor: Colors.white,
              hintText: "উপজেলা নাম নির্বাচন করুন",
              hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: (){
                  setState(() {
                    _upojalaController.clear();
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
            style: TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w300
            ),
            controller: this._upojalaController,


          ),

          suggestionsCallback: (pattern) {
            //ledgerList.retainWhere((element) => element.ledgerName.toLowerCase().contains(pattern.toLowerCase()))
            return getSuggestions(pattern);
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion.upazilaName),
            );
          },
          transitionBuilder: (context, suggestionsBox, controller) {
            return suggestionsBox;
          },
          onSuggestionSelected: (suggestion) {
            this._upojalaController.text = suggestion.upazilaName;
            setState(() {
              _selectUpazila=suggestion.upazilaId;
              loadUnionData(suggestion.upazilaId);
            });
          },
          validator: (value) =>
          value.isEmpty ? 'উপজেলা নাম নাম আবশ্যক' : null,
          //onSaved: (value) => this._selectedCity = value,
        ),
      ),
    );
  }
  Widget _buildUnionField() {
    return  Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Container(
        width: MediaQuery.of(context).size.width*1.3/3,
        height: MediaQuery.of(context).size.height/15,
        child: TypeAheadFormField<PublicUpData>(
          textFieldConfiguration: TextFieldConfiguration(
            decoration: InputDecoration(
              labelText: "ইউনিয়ন/পৌরসভা",
              labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
              fillColor: Colors.white,
              hintText: "ইউনিয়ন / পৌরসভা নির্বাচন করুন",
              hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: (){
                  setState(() {
                    _unionController.clear();
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
            style: TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w300
            ),
            controller: this._unionController,


          ),
          loadingBuilder: (context){
            return _unionLoad?CircularProgressIndicator():Text("");
          },

          suggestionsCallback: (pattern) {
            //ledgerList.retainWhere((element) => element.ledgerName.toLowerCase().contains(pattern.toLowerCase()))
            return getSuggestionsUnion(pattern);
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
            this._unionController.text = suggestion.upPourashavaName;
            setState(() {
              _selectUpData=suggestion.upazilaId;
              loadUnionData(suggestion.upazilaId);
            });
          },
          validator: (value) =>
          value.isEmpty ? 'উপজেলা নাম নাম আবশ্যক' : null,
          //onSaved: (value) => this._selectedCity = value,
        ),
      ),
    );
  }
  Widget _buildUnoUnionField() {
    return  Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Container(
        width: MediaQuery.of(context).size.width*2.9/3,
        height: MediaQuery.of(context).size.height/15,
        child: TypeAheadFormField<UpData>(
          textFieldConfiguration: TextFieldConfiguration(
            decoration: InputDecoration(
              labelText: "ইউনিয়ন/পৌরসভা",
              labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
              fillColor: Colors.white,
              hintText: "ইউনিয়ন / পৌরসভা নির্বাচন করুন",
              hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: (){
                  setState(() {
                    _unionController.clear();
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
            style: TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w300
            ),
            controller: this._unionController,


          ),
          loadingBuilder: (context){
            return _unionLoad?CircularProgressIndicator():Text("");
          },

          suggestionsCallback: (pattern) {
            //ledgerList.retainWhere((element) => element.ledgerName.toLowerCase().contains(pattern.toLowerCase()))
            return getSuggestionsUnoUnion(pattern);
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
            this._unionController.text = suggestion.upPourashavaName;
            setState(() {
              _selectUpData=suggestion.upPourashavaId;
              //loadUnionData(suggestion.upazilaId);
            });
          },
          validator: (value) =>
          value.isEmpty ? 'উপজেলা নাম নাম আবশ্যক' : null,
          //onSaved: (value) => this._selectedCity = value,
        ),
      ),
    );
  }
  Widget _statusDropdown(){
    return Padding(
        padding: EdgeInsets.all(5),
        child:Container(
          height: MediaQuery.of(context).size.height/8,
          width: MediaQuery.of(context).size.width*1.4/3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 8,left:10,bottom: 5),
                child: Text(
                  'অবস্থান',
                  style: kLabelStyle,
                ),
              ),
              //SizedBox(height: 5.0),
              Padding(
                padding: EdgeInsets.only(left: 8,right: 8),
                child: Container(
                  width: MediaQuery.of(context).size.width*2.9/3,
                  //height: 100,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: Colors.white,
                      border: Border.all(color: AppTheme.mainColor,width: 2.0)
                  ),
                  child: DropdownButton<String>(
                    value: _selectStatus,
                    //icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 0,
                    isDense: false,
                    isExpanded: true,
                    hint: Padding(padding: EdgeInsets.only(left: 10),
                      child: Text('অবস্থান নির্বাচন করুন'),),
                    icon: Icon(Icons.arrow_drop_down,size: 30,color:AppTheme.mainColor,),
                    style: TextStyle(color: Colors.deepPurple),
                    /*underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),*/
                    onChanged: (value) {
                      setState(() {
                        _selectStatus= value;
                      });
                    },
                    items:_status
                        .map((String  map) {
                      return DropdownMenuItem<String>(
                        value: map,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(map,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 13),),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
  Widget listMember(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(13),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemCount:
            _kabikhaData.length,
        separatorBuilder: (context,int i)=>Divider(),
        itemBuilder: (context,int i){
          return _buildListTile(_kabikhaData[i]);
        },
      ),
    );
  }
  Widget _buildListTile(KabikhaProjectData memberData){

    return GestureDetector(
      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>KabikhaReportDetails(loginResponse,memberData.kabikhaProjectId))),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: Colors.white,
            border: Border.all(color: AppTheme.mainColor,width: 2.0)
        ),
        child: Card(
          elevation: 0.0,
          child: ListTile(
            /* leading: CircleAvatar(
              radius: 25,
              backgroundImage: memberData.i!=""?
              NetworkImage(memberData.fileDirectory+memberData.image):
              AssetImage('assets/images/person.png',),
              backgroundColor: Colors.transparent,
            ),*/
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("ইউনিয়ন: ",style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 16
                ),),
                Text(memberData.upPourashavaName,style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    fontSize: 15
                ),)
              ],
            ),
            subtitle: Container(
              //height: 125,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("উপজেলার: ",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black
                      ),),
                      Text(memberData.upazilaName,style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          color: Colors.black
                      ),),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("প্রকল্পের নাম: ",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black
                      ),),
                      Flexible(child: Text(memberData.projectName.toString(),style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          color: Colors.black
                      ),),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("প্রকল্পের ব্যয়: ",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black
                      ),),
                      Flexible(
                        child: Text(memberData.assignedAmount,style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            color: Colors.black
                        ),),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("প্রকল্প শুরুর তারিখ: ",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black
                      ),),
                      Flexible(
                        child: Text(memberData.projectStartDate,style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            color: Colors.black
                        ),),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("প্রকল্প শেষের তারিখ: ",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black
                      ),),
                      Flexible(
                        child: Text(memberData.projectEndDate,style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            color: Colors.black
                        ),),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("অর্থবছর: ",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black
                      ),),
                      Flexible(
                        child: Text(memberData.financialYear,style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            color: Colors.black
                        ),),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Text("অবস্থান: ",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black
                      ),),
                      cardAprovedOrNot(memberData.status)
                    ],
                  ),

                ],
              ),
            ),
            trailing: Padding(
              padding: EdgeInsets.only(top: 25),
              child: Icon(Icons.arrow_forward_ios,color: AppTheme.subColors,),
            ),
          ),
        ),
      ),
    );
  }

  Widget cardAprovedOrNot(String status){
    if(status=='1'){
      return Card(
        color:Colors.cyan,
        child: Padding(
            padding: EdgeInsets.all(2),
            child:Text('অনুমোদনের অপেক্ষায়',style: TextStyle(color: Colors.white),)
        ),
      );
    }else if(status=='3'){
      return Card(
        color:AppTheme.mainColor,
        child: Padding(
            padding: EdgeInsets.all(2),
            child:Text('সম্পন্ন প্রকল্প ',style: TextStyle(color: Colors.white),)
        ),
      );
    }else if(status=='2'){
      return Card(
        color:AppTheme.mainColor,
        child: Padding(
            padding: EdgeInsets.all(2),
            child:Text('অনুমোদিত প্রকল্প ',style: TextStyle(color: Colors.white),)
        ),
      );
    }
    else{
      return Card(
        color:AppTheme.nearlyWhite,
        child: Padding(
            padding: EdgeInsets.all(2),
            child:Text('বাতিলকৃত প্রকল্প ',style: TextStyle(color: Colors.red),)
        ),
      );
    }
  }
}
