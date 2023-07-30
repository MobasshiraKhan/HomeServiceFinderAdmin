import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final dynamic action;
  final Color? color;
  final String title;
  const CustomCard(
      {Key? key, required this.action, this.color, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return action;
        }));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.width /
            2, //screen er width er ordek jaiga nibe
        width: MediaQuery.of(context).size.width / 2,

        child: Center(
            child: Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
        decoration: BoxDecoration(
            color: color == null ? Colors.cyanAccent : color,
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}