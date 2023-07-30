import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class PayMents extends StatefulWidget {
  @override
  State<PayMents> createState() => _PayMentsState();
}

class _PayMentsState extends State<PayMents> with TickerProviderStateMixin {
  late TabController _tabController;

  int index = 0;

  List<String> tabs = ["All", "On Hold", "Completed", "Rejected"];

  final uref = FirebaseFirestore.instance.collection('users');

  final ref = FirebaseFirestore.instance.collection('payments');

  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        title: Text('Payments'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TabBar(
              physics: ClampingScrollPhysics(),
              isScrollable: true,
              controller: _tabController,
              indicatorColor: Colors.green,
              padding: EdgeInsets.all(10),
              tabs: tabs
                  .map((e) => Tab(
                        text: e,
                      ))
                  .toList(),
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              indicator: RectangularIndicator(
                color: Colors.blue,
                bottomLeftRadius: 100,
                bottomRightRadius: 100,
                topLeftRadius: 100,
                topRightRadius: 100,
              ),
              onTap: (i) {
                setState(() {
                  index = i;
                });
              },
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: index != 0
                  ? ref.where('state', isEqualTo: tabs[index]).snapshots()
                  : ref.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, i) {
                        DocumentSnapshot doc = snapshot.data!.docs[i];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Table(
                            border: TableBorder.all(),
                            children: [
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'Customer Name: ${doc['customer_name']}'),
                                ),
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Text('Account Number: ${doc['account']}'),
                                ),
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'Transaction Number: ${doc['transaction']}'),
                                ),
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Amount: ${doc['amount']} taka'),
                                ),
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('State: ${doc['state']}'),
                                ),
                              ]),
                            ],
                          ),
                        );
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
