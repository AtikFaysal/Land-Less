import 'package:flutter/material.dart';
import 'package:land_less/AppTheme/app_theme.dart';
//import 'package:flutter_svg/flutter_svg.dart';
//import 'package:meditation_app/constants.dart';

class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Function press;
  const CategoryCard({
    Key key,
    this.svgSrc,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        //padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height*1.1/4,
        width: MediaQuery.of(context).size.width*1.3/2,
        decoration: BoxDecoration(
          color: AppTheme.subColors,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: Colors.amber,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  // SvgPicture.asset(svgSrc),
                  Image.asset(svgSrc,color:AppTheme.mainInfo,height: 120,width: 200,),
                  Spacer(),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 25,color: AppTheme.nearlyWhite),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}