import 'package:flutter/material.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/tr/tr_model/trListModel.dart';
import 'package:land_less/tr/tr_model/tr_details_by_id.dart';
import 'package:land_less/tr/tr_screen/details_tr_list_item.dart';
import 'package:land_less/view_model/trProvider.dart';
import 'package:provider/provider.dart';
class TrListPage extends StatefulWidget {
  LoginResponse loginResponse;

  TrListPage(this.loginResponse);

  @override
  _TrListPageState createState() => _TrListPageState(loginResponse);
}

class _TrListPageState extends State<TrListPage> {
  LoginResponse loginResponse;

  _TrListPageState(this.loginResponse);

  TextEditingController controller=TextEditingController();

  Widget _dialogContent;
  @override
  Widget build(BuildContext context) {
    final  trInfoList=Provider.of<TrProvider>(context);
    trInfoList.TrInfoListFromApiProvider(loginResponse.response.deviceId, loginResponse.response.userId,
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
            child: trInfoList.trList!=[]?Stack(
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
                            //onChanged: onSearchTextChanged,
                          ),
                          trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                            controller.clear();
                            //onSearchTextChanged('');
                          },),
                        ),
                      ),
                    ),
                  ),
                ),
                trInfoList.trList!=null?
                Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: ListView.separated(
                      itemCount: trInfoList.trList.length,
                      separatorBuilder: (context,int i)=>Divider(),
                      itemBuilder: (context,int i){
                        return _buildListTile(trInfoList.trList[i]);
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
            ):_dialogContent!=null?_dialogContent:Text('')
        )
    );
  }

  Widget _buildListTile(TrData memberData){

    return GestureDetector(
      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TrDetails(memberData,loginResponse))).then((value) =>setState(() {})),
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
                      Text("প্রকল্প নাম: ",style: TextStyle(
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
                      Text("প্রকল্প ব্যয়: ",style: TextStyle(
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
                      Text("প্রকল্প শেষের নির্ধারিত তারিখ: ",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black
                      ),),
                      Flexible(
                        child: Text(memberData.completionOfProject,style: TextStyle(
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
