import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:homestay_raya/User.dart';
import 'package:homestay_raya/config.dart';
import 'package:homestay_raya/pages/customerDetailScreen.dart';
import 'package:homestay_raya/pages/detailScreen.dart';
import 'package:homestay_raya/pages/mainMenuScreen.dart';
import 'package:homestay_raya/pages/sellerScreen.dart';
import 'package:homestay_raya/product.dart';
import 'package:http/http.dart' as http;

class CustomerScreen extends StatefulWidget {
  final User user;
  const CustomerScreen({super.key, required this.user});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  List<Product> productList = <Product>[];
  String titlecenter = "Loading...";
  //final df = DateFormat('dd/MM/yyyy hh:mm a');
  late double screenHeight, screenWidth, resWidth;
  int rowcount = 2;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      rowcount = 3;
    }
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(title: const Text("Buyers")),
          body: productList.isEmpty
              ? Center(
                  child: Text(titlecenter,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Your current products/services (${productList.length} found)",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const Text("Are you a Seller?",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    GestureDetector(
                      onTap: () {
                        goSellerScreen();
                      },
                      child: Container(
                        color: Theme.of(context).primaryColorLight,
                        padding: const EdgeInsets.all(4),
                        child: const Text('PRESS HERE',
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: rowcount,
                        children: List.generate(productList.length, (index) {
                          return Card(
                            elevation: 8,
                            child: InkWell(
                              onTap: () {
                                _showDetails(index);
                              },
                              child: Column(children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                Flexible(
                                  flex: 6,
                                  child: CachedNetworkImage(
                                    width: resWidth / 2,
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "${Config.SERVER}/homestayraya/assets/images/${productList[index].productId}.png",
                                    placeholder: (context, url) =>
                                        const LinearProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                Flexible(
                                    flex: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            truncateString(
                                                productList[index]
                                                    .productName
                                                    .toString(),
                                                15),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              "RM ${double.parse(productList[index].productPrice.toString()).toStringAsFixed(2)}"),
                                        ],
                                      ),
                                    ))
                              ]),
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                ),
          drawer: MainMenuScreen(user: widget.user),
        ));
  }

  String truncateString(String str, int size) {
    if (str.length > size) {
      str = str.substring(0, size);
      return "$str...";
    } else {
      return str;
    }
  }

  void goSellerScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => NewServiceScreen(
                  user: widget.user,
                )));
  }

  void _loadProducts() {
    http
        .get(
      Uri.parse("${Config.SERVER}/homestayraya/php/loadallproduct.php"),
    )
        .then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          var extractdata = jsondata['data'];
          if (extractdata['products'] != null) {
            productList = <Product>[];
            extractdata['products'].forEach((v) {
              productList.add(Product.fromJson(v));
            });
            titlecenter = "Found";
          } else {
            titlecenter = "No Service Available";
            productList.clear();
          }
        }
      } else {
        titlecenter = "No Service Available";
        productList.clear();
      }
      setState(() {});
    });
  }

  Future<void> _showDetails(int index) async {
    Product product = Product.fromJson(productList[index].toJson());
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => CustomersDetailsScreen(
                  product: product,
                  user: widget.user,
                )));
    _loadProducts();
  }
}
