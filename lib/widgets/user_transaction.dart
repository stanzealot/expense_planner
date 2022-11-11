// ignore_for_file: unused_element, non_constant_identifier_names

import 'package:flutter/material.dart';
import './transaction_list.dart';
import './new_transaction.dart';
import '../models/transaction.dart';
class UserTransactionState extends StatefulWidget {
  const UserTransactionState({super.key});

  
  @override
  State<UserTransactionState> createState() => __UserTransactionStateState();
}

class __UserTransactionStateState extends State<UserTransactionState> {
  final List<Transaction> useTransaction = [
    Transaction(id: "t1", title: "shoe", amount: 30.0, date: DateTime.now()),
    Transaction(id: "t2", title: "shirt", amount: 20.0, date: DateTime.now())
  ];

  void _addNewTransaction(String txTitle, double txAmount){
     final newTrn = Transaction(
      id: DateTime.now().toString(), 
      title: txTitle, 
      amount: txAmount, 
      date: DateTime.now()
      );
      setState(() {
        useTransaction.add(newTrn);
      });
    
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(useTransaction)
      ],
    );
  }
}