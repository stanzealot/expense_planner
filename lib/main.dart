// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, sort_child_properties_last, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          )
        ),
        appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold
          )
        )

      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  final List<Transaction> useTransaction = [
    
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
  void showInputDataWidget(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder:(bCtx){
      return GestureDetector(
        onTap: (){},
        behavior: HitTestBehavior.opaque,
        child: NewTransaction(_addNewTransaction)
      );
    },);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense planner",
        
        ),

        actions: [
          IconButton(
            onPressed: ()=>showInputDataWidget(context),
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
          
          // NewTransaction(),
           TransactionList(useTransaction)
        
      ]
        
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>showInputDataWidget(context),
        child: Icon(Icons.add)
        ),
    );
  }
}

