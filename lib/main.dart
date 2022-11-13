// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, sort_child_properties_last, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, avoid_print, unused_element

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
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
 
  final List<Transaction> useTransaction = [];

  List<Transaction> get _recentTransaction {
    return useTransaction.where((trans) {
      return trans.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }
  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate){
     final newTrn = Transaction(
      id: DateTime.now().toString(), 
      title: txTitle, 
      amount: txAmount, 
      date: chosenDate,
      );
      setState(() {
        useTransaction.add(newTrn);
      });
    
  }

  void _removeTransaction(String id){
    setState(() {
      useTransaction.removeWhere((element) => element.id == id);
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
    final appBar = AppBar(
        title: Text("Expense planner",
        
        ),

        actions: [
          IconButton(
            onPressed: ()=>showInputDataWidget(context),
            icon: Icon(Icons.add)
            )
        ],
      );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            //chart
          Container(
            height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top)*0.3,
            child: Chart(_recentTransaction)
            ),
          // NewTransaction(),
          Container(
            height: (MediaQuery.of(context).size.height-appBar.preferredSize.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top)*0.7,
            child: TransactionList(useTransaction,_removeTransaction)
            )
        
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

