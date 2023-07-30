import 'package:carousel_slider/carousel_slider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mp_admin_rough2/dashboarditems/allorder.dart';
import 'package:mp_admin_rough2/dashboarditems/gps.dart';
import 'package:mp_admin_rough2/dashboarditems/workdone.dart';
import 'package:mp_admin_rough2/dashboarditems/pendingorders.dart';

import '../components/customcard.dart';
import '../dashboarditems/payment.dart';
import '../dashboarditems/pendingorders.dart';
import '../components/drawer.dart';
import '../dashboarditems/seller_request.dart';
import '../dashboarditems/sendnotice.dart';
import '../dashboarditems/verification.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  final auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> items = [
    {
      'title': 'All order',
      'color': Colors.cyanAccent,
      'action': AllOrder(),
    },
    {
      'title': 'Payment History',
      'color': Colors.cyanAccent,
      'action': PayMents(),
    },
    {
      'title': 'Send Notice',
      'color': Colors.cyanAccent,
      'action': SendNotice(),
    },
    {
      'title': 'GPS History',
      'color': Colors.cyanAccent,
      'action': GpSc(),
    },
    {
      'title': 'Seller Requests',
      'color': Colors.cyanAccent,
      'action': SellerRequest(),
    },
    {
      'title': 'Police Verification',
      'color': Colors.cyanAccent,
      'action': Verification(),
    },
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('Admin app '),
        actions: [
          IconButton(
              onPressed: () async {
                await auth.signOut();
              },
              icon: Icon(Icons.logout, color: Colors.white))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return CustomCard(
                  action: items[index]['action'],
                  title: items[index]['title'],
                  color: items[index]['color'],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        // backgroundColor: Theme.of(context).primaryColor,
        controller: controller,
        backgroundColor: Colors.blue,
        color: Colors.white,
        activeColor: Colors.white,
        items: [
          TabItem(
            icon: Icon(
              Icons.home,
              color: Colors.cyan,
            ),
          ),
        ],
      ),
    );
  }
}
