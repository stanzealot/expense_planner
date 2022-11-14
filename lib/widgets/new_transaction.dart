// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  
  Function _addTransaction;
  NewTransaction(this._addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
   DateTime? _selectedDate ;
  void handleAddTransaction(){

    if(amountController.text.isEmpty){
      return;
    }
     final title = titleController.text;
     final amount = double.parse(amountController.text);
     if(title.isEmpty || amount <=0 || _selectedDate == null){
        return;
     }
    widget._addTransaction(title,amount,_selectedDate);
    //close the outermost screen
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
              elevation: 5,
              child: Container(
                padding:  EdgeInsets.only(
                  top: 10,
                  left:10,
                  right:10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: titleController,
                      onSubmitted: (_) => handleAddTransaction(),
                      ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Amount'),
                      controller: amountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal:true),
                      onSubmitted: (_) => handleAddTransaction(),
                    ),
                    Container(
                        height: 70,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                _selectedDate == null
                                    ? 'No Date Chosen!'
                                    : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                              ),
                            ),
                           AdaptiveFlatButton('Choose Date', _presentDatePicker)
                          ],
                              ),
                      ),
                      ElevatedButton(
                      onPressed: handleAddTransaction, 
            
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white
                    
                      ),
                      child: const Text("Add Transaction")
                      )
            ]),)),
    );
  }
}