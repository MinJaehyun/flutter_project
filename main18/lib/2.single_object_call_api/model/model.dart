// To parse this JSON data, do
//
//     final bank = bankFromJson(jsonString);

import 'dart:convert';

// note: 다중 json data 즉, [{...},{...},...] 를 다중 객체로 처리하기 위한 bankFromJson 메서드
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

  // note: 단일 json data 를 단일 객체로 만들기 위한 fromJson 메서드
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
