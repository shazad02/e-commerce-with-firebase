// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rambo/providers/cekout_provider.dart';
import 'package:rambo/theme.dart';
import 'package:rambo/views/screen/cart/cart_screen.dart';

import 'package:rambo/views/screen/produk/licek.dart';
import 'package:rambo/views/screen/produk/listcek.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/produck_model.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/product_provider.dart';
import '../../../widget/custom_category.dart';
import '../../../widget/produk_card.dart';

import '../produk/listproduc.dart';
import '../splash/splash_screen.dart';

import 'components/appbar_dashboard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchPopulerProducts();
    Provider.of<ProductProvider>(context, listen: false).fetchMinumanProducts();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _logout() async {
    await _auth.signOut();
    // ignore: deprecated_member_use, use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SplashScrren(),
      ),
      (route) => false,
    );
  }

  Widget _allProduk() {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, _) {
        final List<Product> products = productProvider.populerProducts;

        if (products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return SizedBox(
          width: double.infinity,
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              Product product = products[index];
              return ProductCard(
                image: product.image,
                name: product.name,
                price: product.price,
                onAdd: () {
                  print('Tombol tambah diklik');
                },
                category: product.category,
                description: product.description,
              );
            },
          ),
        );
      },
    );
  }

  Widget _dashboardWanita() {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, _) {
        final List<Product> products = productProvider.priaProduk;

        if (products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return SizedBox(
          width: double.infinity,
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              Product product = products[index];
              return ProductCard(
                image: product.image,
                name: product.name,
                price: product.price,
                description: product.description,
                onAdd: () {
                  print('Tombol tambah diklik');
                },
                category: product.category,
              );
            },
          ),
        );
      },
    );
  }

  Widget ProduckCate() {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection("products")
          .where("category", whereIn: ["pria"]).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          QuerySnapshot<Map<String, dynamic>> querySnapshot = snapshot.data!;
          List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
              querySnapshot.docs;

          List<Product> products = documents
              .map((document) => Product.fromJson(document.data()))
              .toList();

          return SizedBox(
            width: double.infinity,
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];
                return ProductCard(
                  image: product.image,
                  name: product.name,
                  price: product.price,
                  description: product.description,
                  onAdd: () {
                    print('Tombol tambah diklik');
                  },
                  category: product.category,
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget wanitaCate() {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection("products")
          .where("category", whereIn: ["wanita"]).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          QuerySnapshot<Map<String, dynamic>> querySnapshot = snapshot.data!;
          List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
              querySnapshot.docs;

          List<Product> products = documents
              .map((document) => Product.fromJson(document.data()))
              .toList();

          return SizedBox(
            width: double.infinity,
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];
                return ProductCard(
                  image: product.image,
                  name: product.name,
                  price: product.price,
                  description: product.description,
                  onAdd: () {
                    print('Tombol tambah diklik');
                  },
                  category: product.category,
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _categoryButton() {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: ScrollController(),
          child: Row(
            children: [
              IconTextCard(
                text: 'Men',
                onTap: () {
                  categoryProvider.setCategory('Men');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListProduct(
                        isEqualTo: 'pria',
                        namescreen: 'Pria Area',
                      ),
                    ),
                  );
                },
              ),
              IconTextCard(
                text: 'Women',
                onTap: () {
                  categoryProvider.setCategory('Women Area');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListProduct(
                        isEqualTo: 'wanita',
                        namescreen: 'Women Area',
                      ),
                    ),
                  );
                },
              ),
              IconTextCard(
                text: 'Kids',
                onTap: () {
                  categoryProvider.setCategory('Kids');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListProduct(
                        isEqualTo: 'anak',
                        namescreen: 'Kids Area',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _cekButton() {
    return Consumer<CekProvider>(
      builder: (context, CekProvider, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: ScrollController(),
          child: Row(
            children: [
              IconTextCard(
                text: 'Belum Bayar',
                onTap: () {
                  CekProvider.setCategory('Belum Bayar');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Licek(
                        isEqualTo: 'Belum Bayar',
                        namescreen: 'Belum Bayar',
                      ),
                    ),
                  );
                },
              ),
              IconTextCard(
                text: 'Tunggu',
                onTap: () {
                  CekProvider.setCategory('Tunggu');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListCek(
                        isEqualTo: 'Tunggu',
                        namescreen: 'Tunggu',
                      ),
                    ),
                  );
                },
              ),
              IconTextCard(
                text: 'Sudah Bayar',
                onTap: () {
                  CekProvider.setCategory('Sudah Bayar');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListCek(
                        isEqualTo: 'Sudah Bayar',
                        namescreen: 'Sudah Bayar',
                      ),
                    ),
                  );
                },
              ),
              IconTextCard(
                text: 'Selesai',
                onTap: () {
                  CekProvider.setCategory('Selesai');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListCek(
                        isEqualTo: 'Selesai',
                        namescreen: 'Selesai',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    late ProductProvider productProvider;
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bg1Color,
        elevation: 0,
        title: const AppbarDash(),
        actions: [
          GestureDetector(
            onTap: _logout,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.logout,
                  color: bg2Color,
                ),
              ),
            ),
          ),
          const Icon(
            Icons.search,
            size: 30.0,
            color: Colors.black87,
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.shopping_bag,
            size: 30.0,
            color: Colors.black87,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: bg2Color,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FutureBuilder<void>(
                    future: productProvider.getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final userModel = productProvider.userModelList.first;
                        return Text(
                          userModel.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(
                    Icons.home,
                    size: 24.0,
                    color: Colors.black87,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Home',
                    style: priceTextStyle.copyWith(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 24.0,
                    color: Colors.black87,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Edit Profile',
                    style: priceTextStyle.copyWith(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, '/edit');
              },
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(
                    Icons.shopping_cart,
                    size: 24.0,
                    color: Colors.black87,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Keranjang',
                    style: priceTextStyle.copyWith(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
            ),

            ListTile(
              title: Row(
                children: [
                  const Icon(
                    Icons.shopping_cart,
                    size: 24.0,
                    color: Colors.black87,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Belum Bayar',
                    style: priceTextStyle.copyWith(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Licek(
                      isEqualTo: 'Belum Bayar',
                      namescreen: 'Belum Bayar',
                    ),
                  ),
                );
              },
            ),

            ListTile(
              title: Row(
                children: [
                  const Icon(
                    Icons.motorcycle_outlined,
                    size: 24.0,
                    color: Colors.black87,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Menunggu Konfirmasi',
                    style: priceTextStyle.copyWith(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListCek(
                      isEqualTo: 'Tunggu',
                      namescreen: 'Tunggu',
                    ),
                  ),
                );
              },
            ),

            ListTile(
              title: Row(
                children: [
                  const Icon(
                    Icons.check_outlined,
                    size: 24.0,
                    color: Colors.black87,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Sudah Bayar',
                    style: priceTextStyle.copyWith(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListCek(
                      isEqualTo: 'Sudah Bayar',
                      namescreen: 'Sudah Bayar',
                    ),
                  ),
                );
              },
            ),

            ListTile(
              title: Row(
                children: [
                  const Icon(
                    Icons.favorite,
                    size: 24.0,
                    color: Colors.black87,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Selesai',
                    style: priceTextStyle.copyWith(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListCek(
                      isEqualTo: 'Selesai',
                      namescreen: 'Selesai',
                    ),
                  ),
                );
              },
            ),

            ListTile(
              title: Row(
                children: [
                  const Icon(
                    Icons.rule,
                    size: 24.0,
                    color: Colors.black87,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Ditolak',
                    style: priceTextStyle.copyWith(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListCek(
                      isEqualTo: 'Ditolak',
                      namescreen: 'Ditolak',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: GestureDetector(
                onTap: _logout,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.logout,
                      color: bg2Color,
                    ),
                  ),
                ),
              ),
            ),

            // Add more ListTiles for additional items in the drawer
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _categoryButton(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Semua Product",
                      style: primaryTextStyle.copyWith(
                          fontSize: 20, color: Colors.black87),
                    ),
                  ],
                ),
              ),

              _allProduk(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Pria",
                      style: primaryTextStyle.copyWith(
                          fontSize: 20, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              ProduckCate(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Wanita",
                      style: primaryTextStyle.copyWith(
                          fontSize: 20, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              _dashboardWanita(),
              const SizedBox(height: 10),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Wanita",
              //         style: primaryTextStyle.copyWith(
              //             fontSize: 20, color: Colors.black87),
              //       ),
              //     ],
              //   ),
              // ),
              // ProduckCate(),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Pesanan",
              //         style: primaryTextStyle.copyWith(fontSize: 20),
              //       ),
              //     ],
              //   ),
              // ),
              // _cekButton(),
              // const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
