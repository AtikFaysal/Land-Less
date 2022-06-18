
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/kabikha/k_Model/kabikha_data.dart';
import 'package:land_less/kabikha/k_Page/details_kabikha.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/service/dioApiCall.dart';
import 'package:land_less/widget/toast_massage.dart';
import 'package:location/location.dart';
class ImageWithLocation extends StatefulWidget {
  LoginResponse loginResponse;
  String kabikhaProjectId;

  ImageWithLocation(this.loginResponse,this.kabikhaProjectId);

  @override
  _ImageWithLocationState createState() => _ImageWithLocationState(loginResponse,kabikhaProjectId);
}

class _ImageWithLocationState extends State<ImageWithLocation> {
  LoginResponse loginResponse;
  String kabikhaProjectId;

  _ImageWithLocationState(this.loginResponse,this.kabikhaProjectId);

  bool _isLoading=false;
  File _image;
  Position _position;

  final _picker = ImagePicker();
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
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error(
            'Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void getAddressAndLocation(Position position)async{
    setState(() {
      _position=position;
    });
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");
  }

  @override
  void initState() {
    // TODO: implement initState
    _determinePosition().then((value) {
      getAddressAndLocation(value);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white.withOpacity(0.92),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 1),
        child: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: Colors.white.withOpacity(0.01),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Center(
              child: Icon(Icons.clear,color: Colors.red,)
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: _isLoading?Center(child: CircularProgressIndicator(),):SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imagePickerButton(context),
              SizedBox(height: 10,),
              okButton(context)
            ],
          ),
        ),
      ),
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
        ):new OutlineButton(
            child: new Text('প্রকল্পের ছবি নির্বাচন করুন',style: TextStyle(color: AppTheme.subColors,fontSize: 18,fontWeight: FontWeight.w500),),
            onPressed: ()=>_showPicker(context),
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
        )
    );
  }
  Widget okButton(BuildContext context){
    return Center(
      child: Container(
        child: ElevatedButton.icon(
          label: Text("আপলোড করুন",style: TextStyle(
              color: AppTheme.mainColor,
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),),
          icon: Icon(Icons.house,color: AppTheme.mainColor,),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              if (states.contains(MaterialState.selected))
                return AppTheme.subColors;
              return AppTheme.mainInfo;  // Use the default value.
            }),
          ),
          onPressed: ()async{
            setState(() {
              _isLoading=true;
            });
            if(_image!=null && _position!=null){
              FormData formData=FormData.fromMap({
                'device_id':loginResponse.response.deviceId,
                'user_id':loginResponse.response.userId,
                'user_role':loginResponse.response.userRole,
                'kabikha_project_id':kabikhaProjectId,
                'latitude':_position.latitude,
                'longitude':_position.longitude,
                'image':await MultipartFile.fromFile(_image.path,filename: _image.path.split('/').last)
              });
              DioApiCall().dioKabikhaLocation(formData).then((value){
                if(value['status']==200){
                  setState(() {
                    _isLoading=false;
                  });
                  successToast(context, ' সফলভাবে প্রকল্পের তথ্য সংরক্ষণ হয়েছে');
                  Navigator.pop(context,true);
                }else if(value['status']==401){
                  setState(() {
                    _isLoading=false;
                  });
                  showToastMassage(context, 'দুঃখিত ! প্রকল্পের তথ্য সংরক্ষণ হয়নি');
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
                }else if(value['status']==550){
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
              showToastMassage(context, "all Field Requierd");
            }
          },

        ),
      ),
    );
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
