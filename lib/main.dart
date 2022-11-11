// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, sort_child_properties_last, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/user_transaction.dart';
void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String inputTitle;

  late String inputAmount;

  void showInputData(){
    
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense planner"),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.add)
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        Container(
          width: double.infinity,
          
          child:Card(
            color: Colors.blueGrey,
            child: Text("Chart"),
            elevation: 5,
            ),
          ),
          UserTransactionState()
          // NewTransaction(),
          // TransactionList()
        
      ]
        
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add)
        ),
    );
  }
}

