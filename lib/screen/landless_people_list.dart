import 'package:flutter/material.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/model/member_data.dart';
import 'package:land_less/screen/details_landess_people.dart';
import 'package:land_less/service/apiService.dart';
import 'package:land_less/view_model/landless_people_provider.dart';
import 'package:provider/provider.dart';
class LandlessPeopleInfoList extends StatefulWidget {
  LoginResponse loginResponse;

  LandlessPeopleInfoList(this.loginResponse);

  @override
  _LandlessPeopleInfoListState createState() => _LandlessPeopleInfoListState(loginResponse);
}

class _LandlessPeopleInfoListState extends State<LandlessPeopleInfoList> {
  LoginResponse loginResponse;

  _LandlessPeopleInfoListState(this.loginResponse);
  TextEditingController controller=TextEditingController();

  List<MemberData>_memberData=[];
  List<MemberData>_searchListItem=[];
  bool _isLoading=false;

  void loadListData()async{
    print(loginResponse.response.upazilaId);
    ApiCall().memberListFromApi(loginResponse.response.deviceId, loginResponse.response.userId,
        loginResponse.response.userRole,loginResponse.response.upazilaId.toString()).then((value) {
          if(value.status==200){
            setState(() {
              _isLoading=true;
            });
            print(value.toString());
            if(value.memberData.isNotEmpty){
              for(int i=0;i<value.memberData.length;i++){
                setState(() {
                  _memberData.add(value.memberData[i]);
                });
              }
            }
            setState(() {
              _isLoading=false;
            });
          }else{
            throw Exception("Something Went Wrong!");
          }
    });
  }
  void sateLoadData(){
    setState(() {
      loadListData();
    });
  }
  onSearchTextChanged(String text) async {
    _searchListItem.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _memberData.forEach((MemberData  data) {
      if (data.nid.contains(text) || data.memberName.contains(text)||data.upazilaName.toString().contains(text))
        _searchListItem.add(data);
    });

    setState(() {});
  }
  Widget _dialogContent; // Declare this outside the method, globally in the class

// In your method:
  @override
  void initState() {
    // TODO: implement initState
    //sateLoadData();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final LandlessPeople landlessPeople=Provider.of<LandlessPeople>(context);
    landlessPeople.memberListFromApiProvider(loginResponse.response.deviceId, loginResponse.response.userId,
        loginResponse.response.userRole,loginResponse.response.upazilaId.toString()).then((value) {
      if(value!=null){
        _dialogContent = Center(child: CircularProgressIndicator());
      }else{
        _dialogContent = Center(
          child: Center(child: Text('কোনো তথ্য পাওয়া যায় নি...',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w300),)),
        );
      }
    });

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: landlessPeople.memberList!=[]?Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: new Container(
                color: Colors.white,
                child: new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Card(
                    elevation: 7.0,
                    child: new ListTile(
                      leading: new Icon(Icons.search),
                      title: new TextField(
                        controller: controller,
                        decoration: new InputDecoration(
                            hintText: 'অনুসন্ধান করুন', border: InputBorder.none),
                        onChanged: onSearchTextChanged,
                      ),
                      trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                        controller.clear();
                        onSearchTextChanged('');
                      },),
                    ),
                  ),
                ),
              ),
            ),
          landlessPeople.memberList!=null?Padding(
            padding: EdgeInsets.only(top: 80),
            child: ListView.separated(
              itemCount: landlessPeople.memberList.length,
              separatorBuilder: (context,int i)=>Divider(),
              itemBuilder: (context,int i){
                return _buildListTile(landlessPeople.memberList[i]);
              },
            )/*Column(
              children: [
                Expanded(child: _searchListItem.length!=0 || controller.text.isNotEmpty?
                    ListView.separated(
                      itemCount: _searchListItem.length,
                      separatorBuilder: (context,int i)=>Divider(),
                      itemBuilder: (context,int i){
                        return _buildListTile(_searchListItem[i]);
                      },
                    ):
                ListView.separated(
                  itemCount: _memberData.length,
                  separatorBuilder: (context,int i)=>Divider(),
                  itemBuilder: (context,int i){
                    return _buildListTile(_memberData[i]);
                  },
                )
                )
              ],
            ),*/
          ):_dialogContent!=null?_dialogContent:Text('')
          ],
        ):_dialogContent!=null?_dialogContent:Text('')/*Center(child: Text('কোনো তথ্য পাওয়া যায় নি...',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w300),),)*/
      )
    );
  }

  Widget _buildListTile(MemberData memberData){

    return GestureDetector(
      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LandlessPeopleDetails(memberData,loginResponse))).then((value) =>setState(() {})),
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
            child:Text('সম্পন্ন ঘর',style: TextStyle(color: Colors.white),)
        ),
      );
    }else if(status=='2'){
      return Card(
        color:AppTheme.mainColor,
        child: Padding(
            padding: EdgeInsets.all(2),
            child:Text('অনুমোদিত ঘর',style: TextStyle(color: Colors.white),)
        ),
      );
    }
    else{
      return Card(
        color:AppTheme.nearlyWhite,
        child: Padding(
            padding: EdgeInsets.all(2),
            child:Text('বাতিলকৃত ঘর',style: TextStyle(color: Colors.red),)
        ),
      );
    }
  }
}
