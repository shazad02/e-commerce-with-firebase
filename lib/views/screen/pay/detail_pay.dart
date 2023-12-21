import 'dart:typed_data';

import 'package:rambo/theme.dart';
import 'package:rambo/views/screen/pay/data.dart';
import 'package:rambo/views/screen/pay/pay_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../providers/product_provider.dart';

class DetailPay extends StatefulWidget {
  final String image;
  final String name;
  final String penerima;
  final String orderId;
  final String nomor;
  final String kodeOrder;
  final String userId;
  final String lengkapUser;
  final String total;

  const DetailPay({
    Key? key,
    required this.image,
    required this.name,
    required this.penerima,
    required this.orderId,
    required this.kodeOrder,
    required this.userId,
    required this.nomor,
    required this.lengkapUser,
    required this.total,
  }) : super(key: key);

  @override
  State<DetailPay> createState() => _DetailPayState();
}

class _DetailPayState extends State<DetailPay> {
  int count = 1;
  String userName = '';
  late ProductProvider productProvider;
  Uint8List? _image;
  bool _uploading = false; // Flag to indicate if image upload is in progress

  Future<Uint8List?> pickImageFromGallery() async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (_file != null) {
      Uint8List? bytes = await _file.readAsBytes();
      return bytes;
    }
    return null; // Return null if image selection is canceled or encounters an error
  }

  Future<Uint8List?> pickImageFromCamera() async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: ImageSource.camera);
    if (_file != null) {
      Uint8List? bytes = await _file.readAsBytes();
      return bytes;
    }
    return null; // Return null if image capture is canceled or encounters an error
  }

  @override
  void initState() {
    super.initState();
    getUserAddress();
  }

  void getUserAddress() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('user').doc(userId).get();

      setState(() {
        userName = userSnapshot['name'];
      });
    }
  }

  Future<void> saveData() async {
    // Ubah method saveData
    setState(() {
      _uploading = true; // Set the uploading flag to true
    });

    if (_image != null) {
      try {
        String resp = await StoreData().saveData(
          kodeOrder: widget.kodeOrder,
          file: _image!,
          name: widget.name,
          orderId: widget.orderId,
          userId: widget.userId,
        );
        print(resp); // Example usage of the response value
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resp)),
        );
      } catch (error) {
        print('Error uploading image: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to upload image')),
        );
      } finally {
        setState(() {
          _uploading = false; // Set the uploading flag to false
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak Ada Gamabr Yang Dipilih')),
      );
    }
  }

  Future<void> selectImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pilih Gambar"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: const Text("Gallery"),
                  onTap: () async {
                    Navigator.pop(context);
                    Uint8List? img = await pickImageFromGallery();
                    setState(() {
                      _image = img;
                    });
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text("Kamera"),
                  onTap: () async {
                    Navigator.pop(context);
                    Uint8List? img = await pickImageFromCamera();
                    setState(() {
                      _image = img;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.name,
          style: primaryTextStyle.copyWith(color: bg2Color),
        ),
        centerTitle: false,
        backgroundColor: bg1Color,
        actions: [
          IconButton(
            onPressed: _uploading
                ? null
                : () async {
                    await saveData();
                    if (!_uploading) {
                      Navigator.pushNamed(context, '/home');
                    }
                  },
            icon: const Icon(
              Icons.check,
              size: 24.0,
              color: bg2Color,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => PayScreen(
                  kodeOrder: widget.kodeOrder,
                  userId: widget.userId,
                  lengkapUser: widget.lengkapUser,
                  total: widget.total,
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 24.0,
            color: bg2Color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 100,
            ),
            Center(
              child: Stack(
                children: [
                  _image != null
                      ? GestureDetector(
                          onTap: selectImage,
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 50 / 100,
                            width:
                                MediaQuery.of(context).size.height * 40 / 100,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              image: DecorationImage(
                                image: MemoryImage(_image!),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: selectImage,
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 50 / 100,
                            width:
                                MediaQuery.of(context).size.height * 40 / 100,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Center(
                                child: Text(
                              "Upload Barang Bukti",
                              style: primaryTextStyle.copyWith(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Data",
                    style: primaryTextStyle.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: bg2Color),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.apartment,
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Banking: ",
                              style: primaryTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              widget.name,
                              maxLines: 100,
                              overflow: TextOverflow.ellipsis,
                              style: primaryTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: bg2Color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.payment,
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "No Rekening: ",
                              style: primaryTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              widget.nomor,
                              maxLines: 100,
                              overflow: TextOverflow.ellipsis,
                              style: primaryTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: bg2Color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "User",
                    style: primaryTextStyle.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 30,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Alamat: ",
                              style: primaryTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              widget.lengkapUser,
                              maxLines: 100,
                              overflow: TextOverflow.ellipsis,
                              style: primaryTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: bg2Color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Icon(
                    Icons.payments,
                    size: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Pemabayaran: ",
                          style: primaryTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          widget.total,
                          maxLines: 100,
                          overflow: TextOverflow.ellipsis,
                          style: primaryTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: bg2Color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pemesan: ",
                          style: primaryTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          userName,
                          maxLines: 100,
                          overflow: TextOverflow.ellipsis,
                          style: primaryTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: bg2Color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
          ],
        ),
      ),
    );
  }
}
