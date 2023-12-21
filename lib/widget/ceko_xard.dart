// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme.dart';
import '../views/screen/pay/pay_screen.dart';

// ignore: must_be_immutable
class CekoCar extends StatelessWidget {
  final String userName;
  final double totalPrice;
  final String kodeOrder;
  final String UserUid;
  final String lengkapUser;
  final String status;
  final DateTime time;

  CekoCar({
    super.key,
    required this.userName,
    required this.totalPrice,
    required this.kodeOrder,
    required this.UserUid,
    required this.lengkapUser,
    required this.status,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => PayScreen(
              kodeOrder: kodeOrder,
              userId: UserUid,
              lengkapUser: lengkapUser,
              total: totalPrice.toStringAsFixed(0),
            ),
          ),
        );
      },
      child: Container(
        child: Card(
          color: bg1Color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('dd-MM-yyyy HH:mm').format(time),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Status : $status",
                    style: primaryTextStyle2.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: bg2Color,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.numbers,
                          size: 24.0,
                        ),
                        Text(
                          "Id Order: ",
                          style: primaryTextStyle2.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: bg2Color,
                          ),
                        )
                      ],
                    ),
                    Text(
                      kodeOrder,
                      style: primaryTextStyle2.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: bg2Color,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Nama Pemesan : $userName",
                      style: primaryTextStyle2.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: bg2Color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Alamat : $lengkapUser",
                      style: primaryTextStyle2.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: bg2Color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Total harga : Rp.${totalPrice.toInt().toString()}",
                      style: primaryTextStyle2.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: bg2Color,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              Divider(
                height: 20,
                color: Colors.black87,
              )
            ],
          ),
        ),
      ),
    );
  }
}
