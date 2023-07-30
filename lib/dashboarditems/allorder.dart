import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mp_admin_rough2/dashboarditems/submitvalues.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class AllOrder extends StatefulWidget {
  const AllOrder({Key? key}) : super(key: key);

  @override
  State<AllOrder> createState() => _AllOrderState();
}

class _AllOrderState extends State<AllOrder> with TickerProviderStateMixin {
  late TabController _tabController;
  int index = 0;
  List<String> tabs = [
    "All",
    "Requested",
    "Completed",
    "Processing",
    "Paid",
    "Cancelled"
  ];
  final uref = FirebaseFirestore.instance.collection('users');
  final ref = FirebaseFirestore.instance.collection('orders');
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        title: Text('All Orders'),
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
                        return Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            // leading: Image.asset(
                            //     'assets/images/' + providers[i]['image']),
                            title: Text('Seller Name: ${doc['seller_name']}'),
                            subtitle: Text('Location: ${doc['location']}'),
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
