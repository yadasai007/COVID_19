import 'package:flutter/material.dart';
import 'package:covid_19/constants.dart';

class Counter extends StatelessWidget {
  Counter({this.title, this.number, this.colour});
  final String title;
  final int number;
  final Color colour;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(6.0),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colour.withOpacity(0.26),
          ),
          child: Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: colour,
                width: 2,
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          '$number',
          style: TextStyle(fontSize: 25, color: colour),
        ),
        Text(
          title,
          style: kSubTextStyle,
        )
      ],
    );
  }
}
