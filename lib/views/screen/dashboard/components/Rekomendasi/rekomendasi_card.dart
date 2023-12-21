import 'package:rambo/providers/product_provider.dart';
import 'package:rambo/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RekomendasiCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;
  int index;
  int count;
  final String category;

  RekomendasiCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.count,
    required this.index,
    required this.category,
  }) : super(key: key);

  @override
  State<RekomendasiCard> createState() => _RekomendasiCardState();
}

class _RekomendasiCardState extends State<RekomendasiCard> {
  late ProductProvider productProvider;
  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 5,
              right: 5,
              top: 5,
            ),
            padding: const EdgeInsets.only(
              left: 12,
              right: 2,
              top: 9,
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 20 / 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(0),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).splashColor,
                              spreadRadius: 3),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.network(
                          widget.imageUrl,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Baju ${widget.category}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       "Total: Rp. ${widget.price.toInt().toString()}",
                            //       maxLines: 2,
                            //       overflow: TextOverflow.ellipsis,
                            //       style: const TextStyle(
                            //         fontSize: 15,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(right: 15),
                            //       child: Text(
                            //         "X ${widget.count.toString()}",
                            //         style: primaryTextStyle.copyWith(
                            //             color: Colors.black87),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    productProvider
                                        .deleteCartProduk(widget.index);
                                  },
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    size: 26,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 6.5 / 100,
            margin: const EdgeInsets.only(
              left: 5,
              right: 5,
            ),
            color: const Color.fromARGB(255, 194, 194, 194),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(
                      children: [
                        Text(
                          "Qty ${widget.count.toString()}",
                          style: primaryTextStyle.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          size: 24.0,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Rp. ${widget.price.toInt().toString()}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Divider(
              height: 5,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
