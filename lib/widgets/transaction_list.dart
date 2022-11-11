// ignore_for_file: unused_field, prefer_const_constructors, prefer_interpolation_to_compose_strings, sort_child_properties_last, use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
class TransactionList extends StatelessWidget {
   List<Transaction> transaction = []; 
  TransactionList(this.transaction);
  @override
  Widget build(BuildContext context) {
   
    return Container(
      height: 300,
      child:transaction.isEmpty? Column(
        children: [
          Text('Transactions yet to be add',style: Theme.of(context).textTheme.headline6,),
          SizedBox(height: 10,),
          Container(
            height: 200,
            
            child: Image.asset('lib/assets/images/waiting.png',fit: BoxFit.cover,),
            
            )
        ],
      ) 
      :ListView.builder(
        itemBuilder:(ctr,index){
          return Card(
                child: Row(children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2
                    )),
                    padding: EdgeInsets.all(10),
                    
                    child: Text(
                      '\$${transaction[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.purple),
                      
                      ),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(transaction[index].title,style: Theme.of(context).textTheme.headline6),
                    Text(DateFormat.yMMMd().format(transaction[index].date),style: TextStyle(color:Colors.grey),)
                  ],)
                ],)
                );
        },
        itemCount: transaction.length, 

            
              
           
          )
      )
      ;
  }
}