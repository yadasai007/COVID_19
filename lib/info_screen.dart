import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/myHeader.dart';
import 'constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/coronadr.svg",
              textTop: "Get to know more",
              textBottom: " about Covid-19",
              check: false,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Symptoms", style: kTitleTextstyle),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: SymptomIcon(
                      symptomIcon: "assets/images/headache.png",
                      symptom: "Headache"),
                ),
                Expanded(
                  child: SymptomIcon(
                      symptomIcon: "assets/images/caugh.png", symptom: "Cough"),
                ),
                Expanded(
                  child: SymptomIcon(
                      symptomIcon: "assets/images/fever.png", symptom: "Fever"),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Prevention", style: kTitleTextstyle),
            ),
            SizedBox(height: 20),
            PreventCard(
              text:
                  "Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks",
              image: "assets/images/wear_mask.png",
              title: "Wear face mask",
            ),
            PreventCard(
              text:
                  "Since the start of the coronavirus outbreak usage of handwash and sanitizers are been increased",
              image: "assets/images/wash_hands.png",
              title: "Wash your hands",
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class SymptomIcon extends StatelessWidget {
  SymptomIcon({this.symptom, this.symptomIcon});
  final String symptomIcon;
  final String symptom;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 10.0,
                      color: kActiveShadowColor)
                ]),
            child: Image.asset(
              symptomIcon,
              fit: BoxFit.contain,
            ),
          ),
          Text(
            symptom,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class PreventCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  const PreventCard({
    Key key,
    this.image,
    this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 156,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: 136,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: kShadowColor,
                  ),
                ],
              ),
            ),
            Image.asset(image),
            Positioned(
              left: 130,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 136,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: kTitleTextstyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        text,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset("assets/icons/forward.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
