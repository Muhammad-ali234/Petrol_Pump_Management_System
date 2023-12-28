import 'package:petrol_pump/Pump/Credit_Debit/Models/transaction.dart';

class User {
  String name;
  String email;
  String contact;
  List<Transaction> transactions = [];

  User({required this.name, required this.email, required this.contact});
}
