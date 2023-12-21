// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:rambo/theme.dart';
import 'package:rambo/widget/pay_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/pay_model.dart';
import '../../../providers/product_provider.dart';

class PayScreen extends StatefulWidget {
  final String kodeOrder;
  final String userId;
  final String lengkapUser;
  final String total;
  const PayScreen(
      {Key? key,
      required this.kodeOrder,
      required this.userId,
      required this.lengkapUser,
      required this.total})
      : super(key: key);

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  bool _isLoading = false;

  Future<void> _refreshProducts(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    await Provider.of<ProductProvider>(context, listen: false)
        .fetchPayProducts();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchPayProducts();
  }

  Widget _payProduct() {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, _) {
        final List<PayModel> paymodels = productProvider.payProducts;

        if (_isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (paymodels.isEmpty) {
          return Center(
              child: GestureDetector(
            onTap: () {
              _refreshProducts(context);
            },
            child: Text(
              'Klik Referesh',
              style: primaryTextStyle.copyWith(
                  fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ));
        }

        return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 70 / 100,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: paymodels.length,
            itemBuilder: (context, index) {
              PayModel payModel = paymodels[index];
              return PayCard(
                image: payModel.image,
                nama: payModel.nama,
                nomor: payModel.nomor,
                penerima: payModel.penerima,
                orderId: payModel.id,
                kodeOrder: widget.kodeOrder,
                userId: widget.userId,
                lengkapUser: widget.lengkapUser,
                total: widget.total,
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        backgroundColor: bg1Color,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Metoded Pembayaran",
          style: primaryTextStyle.copyWith(
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 24.0,
            color: Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _payProduct(),
            ],
          ),
        ),
      ),
    );
  }
}
