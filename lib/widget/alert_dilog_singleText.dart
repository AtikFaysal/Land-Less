import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:land_less/AppTheme/app_theme.dart';
 singleTextAlertDailog(BuildContext context,String title,String description){
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Center(child: Text(title,style: TextStyle(fontWeight: FontWeight.w600),),),
        content:Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Text(description),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 100),
            child:  RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
                side: BorderSide(color: AppTheme.mainColor)),
            onPressed: () =>Navigator.of(context).pop(),
            color: AppTheme.subColors,
            textColor: Colors.white,
            child: Text("ঠিক আছে".toUpperCase(),
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400)),
          ),)
        ],
      );
    },
  );
}