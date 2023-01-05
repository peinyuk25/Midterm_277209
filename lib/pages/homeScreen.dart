import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homestay_raya/User.dart';
import 'package:homestay_raya/pages/customerDetail.dart';
import 'package:homestay_raya/pages/customerScreen.dart';
import 'package:homestay_raya/pages/loginScreen.dart';
import 'package:homestay_raya/pages/mainMenuScreen.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Home",
            style: TextStyle(fontSize: 30),
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: _logoutDialog, icon: Icon(Icons.logout))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome to Homestay Raya!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Please choose the service:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              MaterialButton(
                onPressed: () {
                  _loginPage();
                },
                color: Theme.of(context).colorScheme.primary,
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  _servicePage();
                },
                color: Theme.of(context).colorScheme.primary,
                child: const Text(
                  "Services",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        drawer: MainMenuScreen(user: widget.user),
      ),
    );
  }

  void _loginPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => LoginScreen(user: widget.user)));
  }

  void _servicePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => CustomerScreen(user: widget.user)));
  }

  void _customerProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => CustomerDetails(user: widget.user)));
  }

  User user_unregistered = User(
    id: "0",
    name: "unregistered",
    email: "unregistered",
    phone: "unregistered",
    regdate: "unregistered",
  );

  void _logoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Logout",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => HomeScreen(user: user_unregistered)));
    Fluttertoast.showToast(
        msg: "Logout Successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 14.0);
  }
}
