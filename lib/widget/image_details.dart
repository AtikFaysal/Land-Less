import 'package:flutter/material.dart';
class DetailScreen extends StatelessWidget {
 final String src;
 final String details;

 DetailScreen(this.src,this.details);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: GestureDetector(
        child: Container(
          child: Stack(
            children: [
              Center(
                child: Hero(
                  tag: 'Details',
                  child: Image.network(
                    src,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(padding: EdgeInsets.only(bottom: 50),
                  child: Text("বিবরণ: "+details,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black),),)
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}