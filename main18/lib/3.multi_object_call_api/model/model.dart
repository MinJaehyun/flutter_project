// To parse this JSON data, do
//
//     final bank = bankFromJson(jsonString);

import 'dart:convert';

List<Bank> bankFromJson(String str) => List<Bank>.from(json.decode(str).map((x) => Bank.fromJson(x)));

String bankToJson(List<Bank> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bank {
  final int id;
  final String fullName;
  final int account;
  final int balance;

  Bank({
    required this.id,
    required this.fullName,
    required this.account,
    required this.balance,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    id: json["id"],
    fullName: json["full_name"],
    account: json["account"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "account": account,
    "balance": balance,
  };
}
