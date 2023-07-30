import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendNotice extends StatefulWidget {
  const SendNotice({Key? key}) : super(key: key);

  @override
  State<SendNotice> createState() => _SendNoticeState();
}

class _SendNoticeState extends State<SendNotice> {
  final ref = FirebaseFirestore.instance.collection('notice');
  bool remember = false;
  String title = '', desc = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Send Notifications',
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  onChanged: (String text) {
                    title = text;
                  },
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: "Email",
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: (String text) {
                    desc = text;
                  },
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.multiline,
                  minLines: 10,
                  maxLines: 10,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: "Description",
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        await ref.add({
                          'title': title,
                          'desc': desc,
                        });
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  content: Text('Notice sent successfully'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Ok'),
                                    ),
                                  ],
                                ));
                      } catch (e) {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  content: Text('${e.toString()}'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Try Again'),
                                    ),
                                  ],
                                ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                        shape: RoundedRectangleBorder()),
                    child: Text('Send')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}