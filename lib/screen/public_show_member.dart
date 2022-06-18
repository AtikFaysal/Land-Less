import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/model/public_data_model.dart';
import 'package:land_less/model/public_member.dart';
import 'package:land_less/screen/outside_details.dart';
import 'package:land_less/service/apiService.dart';
import 'package:land_less/utils/Constant.dart';
import 'package:land_less/widget/toast_massage.dart';
class PublicShowData extends StatefulWidget {
  @override
  _PublicShowDataState createState() => _PublicShowDataState();
}

class _PublicShowDataState extends State<PublicShowData> {
  bool _isLoading=false;
  TextEditingController _unController=TextEditingController();
  TextEditingController controller=TextEditingController();
  //Upazila
  List<PublicUpazilaData>_publicUpazilaData=[];
  String _selectUpazila;
  //Union
  List<PublicUpData>_publicUpData=[];
  String _selectUpData;

  //Memebr
  List<PuMemberData>_member=[];
  List<PuMemberData>_searchListItem=[];

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
  void loadUnionData(String upozila_Id){
    _publicUpData.clear();
    ApiCall().getUnionData(upozila_Id).then((value) {
      print(value.toJson());
      if(value!=null){
        if(value.publicUpData.isNotEmpty){
          for(int i=0;i<value.publicUpData.length;i++){
            setState(() {
              _publicUpData.add(value.publicUpData[i]);
            });
          }
        }
      }
    });
  }

  void loadPuMemberData(BuildContext context,String upozila_id,String upId)async{
    final Map<String, dynamic> data = {
      'upazila_id':upozila_id==null?'':upozila_id,
      'up_pourashava_id':upId==null?'':upId
    };
    ApiCall().getPublicMember(data).then((value) {
      if(value!=null){
        _member.clear();
        if(value.status==200){
          if(value.puMemberData.isNotEmpty){
            for(int i=0;i<value.puMemberData.length;i++){
              setState(() {
                _member.add(value.puMemberData[i]);
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
  onSearchTextChanged(String text) async {
    _searchListItem.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _member.forEach((PuMemberData  data) {
      if (data.nid.contains(text) || data.memberName.contains(text))
        _searchListItem.add(data);
    });

    setState(() {});
  }
  List<PublicUpazilaData> getSuggestions(String query) {
    List<PublicUpazilaData> matches = List();
    matches.addAll(_publicUpazilaData);
    matches.retainWhere((s) =>   s.upazilaName.contains(query.toLowerCase()));
    return matches;
  }
  @override
  void initState() {
    // TODO: implement initState
    loadPublicData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('গ্রাহক অনুসন্ধান',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView(
        children: [
          _isLoading?Center(child: CircularProgressIndicator(),):Container(
            height: MediaQuery.of(context).size.height/3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDropDownUp(),
                SizedBox(height: 10,),
                upDropdown(),
                SizedBox(height: 10,),
                okButton(context),
              ],
            ),
          ),
          _member.isNotEmpty?Container(
            height:double.parse(_member.length.toString())*225.0,
            child: listMember(context),
          ):Text('')
        ],
      ),
    );
  }
  Widget _buildDropDownUp() {
    return  Padding(
      padding: const EdgeInsets.only(left: 13,right: 13,top: 15),
      child: Container(
        width: MediaQuery.of(context).size.width*2.9/3,
        height: MediaQuery.of(context).size.height/15,
        child: TypeAheadFormField<PublicUpazilaData>(
          textFieldConfiguration: TextFieldConfiguration(
            decoration: InputDecoration(
              labelText: "উপজেলা নাম নির্বাচন করুন",
              labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w300),
              fillColor: Colors.white,
              hintText: "উপজেলা নাম নির্বাচন করুন",
              hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),
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
            style: TextStyle(
                fontSize: 18,
                color: Colors.black
            ),
            controller: this._unController,


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
            this._unController.text = suggestion.upazilaName;
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
  Widget upDropdown(){
    return Padding(
        padding: EdgeInsets.all(5),
        child:Container(
          height: MediaQuery.of(context).size.height/8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 8,left:10,bottom: 5),
                child: Text(
                  'ইউনিয়ন / পৌরসভা নির্বাচন করুন',
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
                    value: _selectUpData,
                    //icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 0,
                    isDense: false,
                    isExpanded: true,
                    hint: Padding(padding: EdgeInsets.only(left: 10),
                      child: Text('ইউনিয়ন / পৌরসভা নির্বাচন করুন'),),
                    icon: Icon(Icons.arrow_drop_down,size: 30,color:AppTheme.mainColor,),
                    style: TextStyle(color: Colors.deepPurple),
                    /*underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),*/
                    onChanged: (value) {
                      setState(() {
                        _selectUpData= value;
                      });
                    },
                    items:_publicUpData
                        .map((PublicUpData  map) {
                      return DropdownMenuItem<String>(
                        value: map.upPourashavaId.toString(),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(map.upPourashavaName,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 17),),
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

  Widget okButton(BuildContext context){
    return Center(
      child: Container(
        child: ElevatedButton.icon(
          label: Text("অনুসন্ধান করুন",style: TextStyle(
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
            if(_selectUpazila!=null){
              setState(() {
                loadPuMemberData(context,_selectUpazila, _selectUpData);
              });
            }else{
              setState(() {
                _isLoading=false;
              });
              showToastMassage(context, 'উপজেলা এবং ইউনিয়ন পছন্দ করুন');
            }
          },

        ),
      ),
    );
  }
  Widget listMember(BuildContext context){
    return Padding(
        padding: EdgeInsets.all(13),
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            itemCount: _member.length,
            separatorBuilder: (context,int i)=>Divider(),
            itemBuilder: (context,int i){
              return _buildListTile(_member[i]);
            },
          ),
    );
  }
  Widget _buildListTile(PuMemberData memberData){

    return GestureDetector(
      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OutsideDetails(memberData.memberId))),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: Colors.white,
            border: Border.all(color: AppTheme.mainColor,width: 2.0)
        ),
        child: Card(
          elevation: 0.0,
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: memberData.image!=""?
              NetworkImage(memberData.fileDirectory+memberData.image):
              AssetImage('assets/images/person.png',),
              backgroundColor: Colors.transparent,
            ),
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
                  SizedBox(height: 5,),
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
                      Text("গ্রাহককের নাম: ",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black
                      ),),
                      Flexible(child: Text(memberData.memberName.toString(),style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          color: Colors.black
                      ),),)
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("NID নম্বর: ",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black
                      ),),
                      Flexible(
                        child: Text(memberData.nid,style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            color: Colors.black
                        ),),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("মোবাইল নম্বর: ",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black
                      ),),
                      Flexible(
                        child: Text(memberData.mobileNumber,style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            color: Colors.black
                        ),),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("গ্রাহকের ধরন: ",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black
                      ),),
                      Flexible(
                        child: Text(memberData.type=='1'?'গৃহহীন':'ভূমিহীন',style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            color: Colors.black
                        ),),
                      ),
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
}
