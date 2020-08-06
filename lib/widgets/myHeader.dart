import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:covid_19/widgets/myClipper.dart';
import 'package:covid_19/constants.dart';

class MyHeader extends StatelessWidget {
  MyHeader({this.image, this.textBottom, this.textTop, this.check});
  final String image;
  final String textTop;
  final String textBottom;
  final bool check;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 40, right: 20, top: 50),
        height: 350,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF74ebd5),
              Color(0xFFACB6E5),
            ]),
            image:
                DecorationImage(image: AssetImage("assets/images/virus.png"))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (check) {
                  Navigator.pushNamed(context, "infoScreen");
                } else {
                  Navigator.pop(context);
                }
              },
              child: Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset("assets/icons/menu.svg")),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  SvgPicture.asset(
                    image,
                    width: 175,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitWidth,
                  ),
                  Positioned(
                      top: 20,
                      left: 125,
                      child: Text(
                        '$textTop\n $textBottom',
                        style: kHeadingTextStyle.copyWith(color: Colors.black),
                      )),
                  Container()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
