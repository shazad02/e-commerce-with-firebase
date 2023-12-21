import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/product_provider.dart';
import '../../../theme.dart';
import '../cart/cart_screen.dart';
import '../dashboard/components/appbar_dashboard.dart';
import '../dashboard/dashboard_screen.dart';
import '../produk/licek.dart';
import '../produk/listcek.dart';
import '../splash/splash_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _logout() async {
    await _auth.signOut();

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScrren(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    Widget _profile() {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bg2Color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<void>(
                        future: productProvider.getUserData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // Display a loading indicator while fetching data
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            // Handle error case
                            return Text('Error: ${snapshot.error}');
                          } else {
                            // Access the name property from userModelList
                            final userModel =
                                productProvider.userModelList.first;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nama: ${userModel.name}",
                                      style: primaryTextStyle2.copyWith(
                                          color: bg1Color, fontSize: 25),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              1 /
                                              100,
                                    ),
                                    Text(
                                      "Email: ${userModel.email}",
                                      style: primaryTextStyle2.copyWith(
                                          color: bg1Color, fontSize: 15),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              1 /
                                              100,
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/edit');
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 28.0,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 28.0,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget _profilEdit() {
      return Column(
        children: [
          Text(
            "Profile Screen",
            style: primaryTextStyle.copyWith(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          _profile(),
          Container(
            decoration: BoxDecoration(
              color: bg2Color,
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 5,
                    ),
                    color: bg2Color,
                    width: double.infinity,
                    height: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget _aplikasiSNK() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Umum",
                  style: primaryTextStyle2.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),
          Container(
            decoration: BoxDecoration(
              color: bg2Color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  Row(
                    children: [
                      Text(
                        "Syarat & Ketentuan",
                        style: primaryTextStyle2.copyWith(fontSize: 17),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1 / 100,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 17,
                        color: bg6color,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 5,
                    ),
                    color: bg2Color,
                    width: double.infinity,
                    height: 3,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  Row(
                    children: [
                      Text(
                        "Kebijakan Privasi",
                        style: primaryTextStyle2.copyWith(fontSize: 17),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1 / 100,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 17,
                        color: bg6color,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 5,
                    ),
                    color: bg2Color,
                    width: double.infinity,
                    height: 3,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget _btnLogout() {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg1Color,
          side: const BorderSide(
            color: bg2Color,
          ),
          elevation: 10,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          _logout;
        },
        child: const Text(
          'Log Out',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      );
    }

    Widget allItem() {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: bg1Color,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  _profilEdit(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 5,
                        ),
                        color: bg2Color,
                        width: double.infinity,
                        height: 3,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 28.0,
                            child: Icon(
                              Icons.shopping_cart,
                              color: Colors.black87,
                              size: 28.0,
                            ),
                          ),
                          Text(
                            "Keranjang",
                            style: primaryTextStyle.copyWith(
                                fontSize: 20, color: Colors.black87),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
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
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 5,
                        ),
                        color: bg2Color,
                        width: double.infinity,
                        height: 3,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 28.0,
                            child: Icon(
                              Icons.motorcycle_outlined,
                              color: Colors.black87,
                              size: 28.0,
                            ),
                          ),
                          Text(
                            "Sudah Upload",
                            style: primaryTextStyle.copyWith(
                                fontSize: 20, color: Colors.black87),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
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
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 5,
                        ),
                        color: bg2Color,
                        width: double.infinity,
                        height: 3,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 28.0,
                            child: Icon(
                              Icons.check_outlined,
                              color: Colors.black87,
                              size: 28.0,
                            ),
                          ),
                          Text(
                            "Konfirmasi",
                            style: primaryTextStyle.copyWith(
                                fontSize: 20, color: Colors.black87),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
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
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 5,
                        ),
                        color: bg2Color,
                        width: double.infinity,
                        height: 3,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 28.0,
                            child: Icon(
                              Icons.favorite,
                              color: Colors.black87,
                              size: 28.0,
                            ),
                          ),
                          Text(
                            "selesai",
                            style: primaryTextStyle.copyWith(
                                fontSize: 20, color: Colors.black87),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
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
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 5,
                        ),
                        color: bg2Color,
                        width: double.infinity,
                        height: 3,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 28.0,
                            child: Icon(
                              Icons.rule,
                              color: Colors.black87,
                              size: 28.0,
                            ),
                          ),
                          Text(
                            "Ditolak",
                            style: primaryTextStyle.copyWith(
                                fontSize: 20, color: Colors.black87),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
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
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 5,
                        ),
                        color: bg2Color,
                        width: double.infinity,
                        height: 3,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        backgroundColor: bg2Color,
        elevation: 0,
        centerTitle: true,
        title: const AppbarDash(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _logout,
                  child: const Icon(
                    Icons.logout,
                    size: 24.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: bg2Color,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FutureBuilder<void>(
                    future: productProvider.getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final userModel = productProvider.userModelList.first;
                        return Text(
                          userModel.name,
                          style: TextStyle(
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
                  SizedBox(
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
                    Icons.shopping_cart,
                    size: 24.0,
                    color: Colors.black87,
                  ),
                  SizedBox(
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
                    Icons.person,
                    size: 24.0,
                    color: Colors.black87,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Profile',
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
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
            // Add more ListTiles for additional items in the drawer
          ],
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              allItem(),
            ],
          ),
        ),
      ),
    );
  }
}
