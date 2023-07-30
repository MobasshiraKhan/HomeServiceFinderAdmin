import 'package:flutter/material.dart';

class WorkDone extends StatelessWidget {
  const WorkDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Orders'),
      ),
      body: Center(
        child: Text('Here will be shown all pending orders by the sellers'),
      ),
    );
  }
}
