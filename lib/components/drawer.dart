import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mp_admin_rough2/Auth/login.dart';
import 'package:mp_admin_rough2/Screens/Feedbacks.dart';
import 'package:mp_admin_rough2/Screens/customers.dart';
import 'package:mp_admin_rough2/Screens/sellers.dart';
import '../Screens/Reports.dart';
import '../Screens/customers.dart';

Widget drawer(context) {
  return Drawer(
    child: Column(
      children: [
        DrawerHeader(
          child: CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('images/home.jpg'),
          ),
        ),
        // ListTile(
        //   title: Text('Profit'),
        //   onTap: () {},
        // ),
        Divider(),
        ListTile(
          title: Text('Reports'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Reports()));
          },
        ),
        ListTile(
          title: Text('Feedbacks'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Feedbacks()));
          },
        ),
        ListTile(
          title: Text('Customers'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Customers()));
          },
        ),
        ListTile(
          title: Text('Sellers'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AllSellers()));
          },
        ),
        ListTile(
          title: Text('Logout'),
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (_) => LogIn()));
          },
        ),
      ],
    ),
  );
}
