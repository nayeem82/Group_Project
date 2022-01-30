import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/product.dart';
import 'package:ecommerce/widgets.dart/actionbar.dart';
import 'package:ecommerce/widgets.dart/productcard.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                //display data
                return ListView(
                  padding: EdgeInsets.only(
                    top: 108.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data.docs.map((document) {
                    return ProductCard(
                      title: document.data()['name'],
                      imageUrl: document.data()['images'][0],
                      price: "\RM${document.data()['price']}",
                      productId: document.id,
                    );
                  }).toList(),
                );
              }

              // loading state
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          ActionBar(
            title: "Home",
            hasBackArrow: false,
          ),
        ],
      ),
    );
  }
}
