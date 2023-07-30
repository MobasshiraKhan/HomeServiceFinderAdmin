import 'package:flutter/material.dart';

class SubmitValues extends StatelessWidget {
  final String email, phn, pass;

  const SubmitValues(
      {Key? key, required this.email, required this.phn, required this.pass})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('Email=' + email),
          Text('Phone=' + phn),
          Text('Password=' + pass),
        ],
      ),
    );
  }
}
