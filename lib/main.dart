// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, sort_child_properties_last, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, avoid_print, unused_element, unnecessary_import, unused_import
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
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

  bool _showChart = false;
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
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
      //App bar
    final dynamic appBar = Platform.isIOS ? CupertinoNavigationBar(
      middle: Text('Personal Expenses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
        GestureDetector(
          child: Icon(CupertinoIcons.add),
          onTap: ()=>showInputDataWidget(context),
        )
      ]),
    ) : AppBar(
      title: Text("Expense planner",),
      actions: [
          IconButton(
            onPressed: ()=>showInputDataWidget(context),
            icon: Icon(Icons.add)
            )
        ],
      );
        //transaction List
    final transactionList = Container(
            height: (mediaQuery.size.height-appBar.preferredSize.height - appBar.preferredSize.height - mediaQuery.padding.top)*0.7,
            child: TransactionList(useTransaction,_removeTransaction)
      );
        
        //the page body
    final pageBody = SafeArea (
      child: SingleChildScrollView(
          child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if(isLandScape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart',style: Theme.of(context).textTheme.headline6,),
                Switch.adaptive(value: _showChart, onChanged: (val){
                  setState(() {
                    _showChart = val;
                  });
                  
                })
              ],
            ),
            //chart portrait
            if(!isLandScape)  Container(
              height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top)*0.3,
              child: Chart(_recentTransaction)
              ),
              //transactionList Portrait
            if(!isLandScape) transactionList,
    
            if(isLandScape) _showChart ?
              //chart
            Container(
              height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top)*0.7,
              child: Chart(_recentTransaction)
              ) :
            // NewTransaction(),
            transactionList
        ]
      
        ),
        ),
    );    
    return Platform.isIOS ? CupertinoPageScaffold(
      child:pageBody,
      navigationBar: appBar, 
      ): Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS? Container(): FloatingActionButton(
        onPressed: ()=>showInputDataWidget(context),
        child: Icon(Icons.add)
        ),
    );
  }
}

