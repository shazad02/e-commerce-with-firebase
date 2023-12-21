import 'package:rambo/theme.dart';
import 'package:rambo/widget/button_cus.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/product_provider.dart';
import '../../cart/cart_screen.dart';

class DetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  final String category;
  final String description;

  const DetailScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int count = 1;
  late ProductProvider productProvider;

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        backgroundColor: bg6color,
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.name,
          style: primaryTextStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              color: Colors.black87),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 24.0,
            color: Colors.black87,
          ),
        ),
        actions: [
          Row(
            children: [
              const Icon(
                Icons.search,
                size: 24.0,
                color: Colors.black87,
              ),
              SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.shopping_bag,
                size: 24.0,
                color: Colors.black87,
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 350,
              child: Stack(
                children: [
                  Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.category,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                            Text(
                              widget.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Rp ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  widget.price.toInt().toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.description,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        color: bg2Color,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (count > 1) {
                                  count--;
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: bg1Color,
                            ),
                          ),
                          Text(
                            count.toString(),
                            style: primaryTextStyle,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                count++;
                              });
                            },
                            icon: const Icon(
                              Icons.add,
                              color: bg1Color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ButtonCus(
                        textButton: "Add To Bag",
                        onPressed: () {
                          productProvider.getCardData(
                            name: widget.name,
                            image: widget.image,
                            quenty: count,
                            price: widget.price,
                            category: widget.category,
                          );
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const CartScreen(),
                            ),
                          );
                        }),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
