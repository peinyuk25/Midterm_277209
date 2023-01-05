import 'package:flutter/material.dart';
import 'package:homestay_raya/User.dart';

import 'package:intl/intl.dart';

class CustomerDetails extends StatefulWidget {
  final User user;

  const CustomerDetails({super.key, required this.user});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  final TextEditingController _idEditingController = TextEditingController();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _regdateEditingController =
      TextEditingController();

  @override
  void initState() {
    _idEditingController.text = widget.user.id.toString();
    _nameEditingController.text = widget.user.name.toString();
    _emailEditingController.text = widget.user.email.toString();
    _phoneEditingController.text = widget.user.phone.toString();
    _regdateEditingController.text = widget.user.regdate.toString();
  }

  final df = DateFormat('dd/MM/yyyy hh:mm a');
  String titleCenter = "Loading...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Details"),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Customer Details",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "User ID",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: _idEditingController,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "User Name",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: _nameEditingController,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.abc),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "User Email",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: _emailEditingController,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.email_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "User Phone",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: _phoneEditingController,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.phone_android_sharp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Date and Time Registered",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: _regdateEditingController,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.date_range),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          )),
    );
  }
}
