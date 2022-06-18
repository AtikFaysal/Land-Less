import 'package:flutter/material.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/model/up_data.dart';
import 'package:land_less/service/apiService.dart';
import 'package:land_less/widget/toast_massage.dart';
class UserProfile extends StatefulWidget {
  LoginResponse loginResponse;

  UserProfile(this.loginResponse);

  @override
  _UserProfileState createState() => _UserProfileState(loginResponse);
}

class _UserProfileState extends State<UserProfile> {
  LoginResponse loginResponse;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _UserProfileState(this.loginResponse);
  String _oldPassword,_newPassword,_retypePassword;
  List<UpData>_upData=[];
  List<String>_testData=['Apple','Mango','Bannana','orange'];
  void loadUnionList(){
    if(loginResponse.upData.isNotEmpty){
      for(int i=0;i<loginResponse.upData.length;i++){
        print(loginResponse.upData[i].upPourashavaName);
        setState(() {
          _upData.add(loginResponse.upData[i]);
        });
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    loadUnionList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDailogUpdatePassword(context),
        label: Text('পাসওয়ার্ড পরিবর্তন করুন',style: TextStyle(color: AppTheme.mainColor),),
        icon: Icon(
          Icons.vpn_key,
          color: AppTheme.mainColor,
        ),
        backgroundColor: AppTheme.mainInfo,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        children: [
          Column(
            children: [
              new Container(
                height: 180.0,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
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
                                    image: loginResponse.response.userImage==null?AssetImage('assets/images/person.png'):NetworkImage(loginResponse.response.fileDirectory+loginResponse.response.userImage),
                                    //image: AssetImage('assets/images/person.png'),
                                    fit: BoxFit.cover,
                                  )),
                            )
                          ],
                        ),
                      ]),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10,bottom: 25),
                child: Container(
                  //height: MediaQuery.of(context).size.height/6,
                  width: MediaQuery.of(context).size.width*1.8/2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: Colors.white,
                      border: Border.all(color: AppTheme.subColors,width: 2.0)
                  ),
                  child: Card(
                    elevation: 0.0,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 10,left: 5,right: 5,bottom: 5),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('নাম: ',style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: AppTheme.mainColor
                              ),),
                              Text(loginResponse.response.fullName,style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                  color: AppTheme.nearlyBlack
                              ),),
                            ],
                          ) ,),
                        Padding(padding: EdgeInsets.all(5),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('ইউজার নেম: ',style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: AppTheme.mainColor
                              ),),
                              loginResponse.response.userName!=null?Text(loginResponse.response.userName,style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                  color: AppTheme.nearlyBlack
                              ),):Text(''),
                            ],
                          ) ,),
                        Padding(padding: EdgeInsets.all(5),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('মোবাইল নাম্বার: ',style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: AppTheme.mainColor
                              ),),
                              loginResponse.response.mobileNumber!=null?Text(loginResponse.response.mobileNumber,style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                  color: AppTheme.nearlyBlack
                              ),):Text(''),
                            ],
                          ) ,),
                        Padding(padding: EdgeInsets.all(5),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('ই-মেইল এড্রেস: ',style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: AppTheme.mainColor
                              ),),
                              loginResponse.response.userEmail!=null?Flexible(
                                child: Text(loginResponse.response.userEmail,style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18,
                                    color: AppTheme.nearlyBlack
                                ),),
                              ):Text(''),
                            ],
                          ) ,),
                        Padding(padding: EdgeInsets.all(5),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('NID নম্বর: ',style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: AppTheme.mainColor
                              ),),
                              loginResponse.response.nationalId!=null?Flexible(
                                child: Text(loginResponse.response.nationalId,style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18,
                                    color: AppTheme.nearlyBlack
                                ),),
                              ):Text(''),
                            ],
                          ) ,),
                        Padding(padding: EdgeInsets.all(5),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('ঠিকানা: ',style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: AppTheme.mainColor
                              ),),
                              loginResponse.response.address!=null?Flexible(
                                child: Text(loginResponse.response.address,style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18,
                                    color: AppTheme.nearlyBlack
                                ),),
                              ):Text(''),
                            ],
                          ) ,),
                        Padding(padding: EdgeInsets.all(5),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('উপজেলা: ',style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: AppTheme.mainColor
                              ),),
                              loginResponse.response.upazilaName!=null?Text(loginResponse.response.upazilaName,style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                  color: AppTheme.nearlyBlack
                              ),):Text(''),
                            ],
                          ) ,),
                      ],
                    ),
                  ),
                ),
              ),
              loginResponse.response.userRole=='3'?Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ইউনিয়ন তালিকা: ',style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: AppTheme.mainColor
                      ),),
                     Container(
                       height: double.parse(_testData.length.toString())*30,
                       width: MediaQuery.of(context).size.width/2,
                       child: _upData.isNotEmpty?ListView.separated(
                          separatorBuilder: (context,int i)=>Divider(),
                          itemCount: _upData.length,
                          itemBuilder: (context,int i){
                            return Text(_upData[i].upPourashavaName);
                          },
                        ):Text('')
                     )
                    ],
                  ),
                ),
              ):Text('')
            ],
          )
        ],
      )
    );
  }
  showDailogUpdatePassword(BuildContext context,){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Center(child: Text("পাসওয়ার্ড পরিবর্তন করুন",style: TextStyle(fontWeight: FontWeight.w600),),),
          content: Container(
            height: MediaQuery.of(context).size.height*1.2/4,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    //controller: _motherController,
                    decoration: InputDecoration(
                      labelText: "পূর্বের পাসওয়ার্ড ",
                      labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide(
                            color: AppTheme.mainColor,
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
                    onChanged: (value){
                      setState(() {
                        _oldPassword=value;
                      });
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'পূর্বের পাসওয়ার্ড আবশ্যক';
                      }

                      return null;
                    },
                    /* onSaved: (String value) {
                      _mother = value;
                    },*/
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    //controller: _motherController,
                    decoration: InputDecoration(
                      labelText: "নতুন পাসওয়ার্ড ",
                      labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide(
                            color: AppTheme.mainColor,
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
                    onChanged: (value){
                      setState(() {
                        _newPassword=value;
                      });
                    },
                    validator: (String value) {
                      if (value.isEmpty && value.length>8) {
                        return 'আট অক্ষরের নতুন পাসওয়ার্ড দিন';
                      }

                      return null;
                    },
                    /* onSaved: (String value) {
                      _mother = value;
                    },*/
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    //controller: _motherController,
                    decoration: InputDecoration(
                      labelText: "নতুন পাসওয়ার্ড পূনরায় লিখুন",
                      labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide(
                            color: AppTheme.mainColor,
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
                    onChanged: (value){
                      setState(() {
                        _retypePassword=value;
                      });
                    },
                    validator: (String value) {
                      if (value.isEmpty && value!=_newPassword) {
                        return 'আপনার পাসওয়ার্ড সঠিক নয়';
                      }

                      return null;
                    },
                    /* onSaved: (String value) {
                      _mother = value;
                    },*/
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 100),
              child:  RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    side: BorderSide(color: AppTheme.mainInfo)),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  Map<String,dynamic>task={
                    'device_id':loginResponse.response.deviceId,
                    'user_id':loginResponse.response.userId,
                    'user_name':loginResponse.response.userName,
                    'password':_newPassword,
                    'old_password':_oldPassword
                  };
                if(_newPassword.trim()==_retypePassword.trim()){
                  ApiCall().changePassword(task).then((value){
                    if(value.isNotEmpty){
                      if(value['status']==200){
                        successToast(context, 'পাসওয়ার্ড পরিবর্তন সফল হয়েছে');
                        Navigator.of(context).pop();
                      }else if(value['status']==203){
                        showToastMassage(context, 'পাসওয়ার্ড পরিবর্তন সফল হয়নি');
                      }else if(value['status']==403){
                        showToastMassage(context, 'আপনার পূর্বের পাসওয়ার্ড সঠিক নয়');
                      }else{
                        showToastMassage(context, 'আবশ্যকীয় সকল তথ্য প্রদান করুন');
                      }
                    }
                  });
                }else{
                  showToastMassage(context, 'নতুন পাসওয়ার্ড এবং পূনরায় লিখিত নতুন পাসওয়ার্ড সমান নয়');
                }
                },
                color: AppTheme.mainInfo,
                textColor: AppTheme.mainColor,
                child: Text("পরিবর্তন করুন".toUpperCase(),
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400)),
              ),)
          ],
        );
      },
    );
  }
}
