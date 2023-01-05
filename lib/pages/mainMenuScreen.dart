import 'package:flutter/material.dart';
import 'package:homestay_raya/User.dart';
import 'package:homestay_raya/pages/customerDetail.dart';
import 'package:homestay_raya/pages/customerScreen.dart';
import 'package:homestay_raya/pages/homeScreen.dart';
import 'package:homestay_raya/pages/sellerScreen.dart';

class MainMenuScreen extends StatefulWidget {
  final User user;
  const MainMenuScreen({super.key, required this.user});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      elevation: 10,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(widget.user.email.toString()),
            accountEmail: Text(widget.user.name.toString()),
            currentAccountPicture: const Icon(Icons.person, size: 30.0),
          ),
          ListTile(
            title: const Text('Home Page'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => HomeScreen(user: widget.user)));
            },
          ),
          ListTile(
            title: const Text('Services: Seller Side'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) =>
                          NewServiceScreen(user: widget.user)));
            },
          ),
          ListTile(
            title: const Text('Services: Customer Side'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => CustomerScreen(user: widget.user)));
            },
          ),
          ListTile(
            title: const Text('Customer Details'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) =>
                          CustomerDetails(user: widget.user)));
            },
          ),
        ],
      ),
    );
  }
}
