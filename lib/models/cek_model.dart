// ignore_for_file: non_constant_identifier_names

class CekModel {
  late final String UserUid;
  late final String kodeOrder;
  late final double totalPrice;
  late final String userName;
  late final String lengkapUser;
  late final String status;
  late final DateTime time;

  CekModel({
    required this.UserUid,
    required this.totalPrice,
    required this.kodeOrder,
    required this.userName,
    required this.lengkapUser,
    required this.status,
    required this.time,
  });

  Map<String, dynamic> toJson() => {
        'UserUid': UserUid,
        'totalPrice': totalPrice,
        'userName': userName,
        'kodeOrder': kodeOrder,
        'lengkapUser': lengkapUser,
        'status': status,
        'time': time,
      };

  static CekModel fromJson(Map<String, dynamic> json) => CekModel(
        UserUid: json['UserUid'] ?? '',
        totalPrice: json['totalPrice'] ?? '',
        userName: json['userName'] ?? '',
        kodeOrder: json['kodeOrder'] ?? '',
        lengkapUser: json['lengkapUser'] ?? '',
        time: json['time'] != null ? json['time'].toDate() : DateTime.now(),
        status: json['status'] ?? '',
      );
}
