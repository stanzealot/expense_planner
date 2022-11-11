import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  Function _addTransaction;
  NewTransaction(this._addTransaction);

  void handleAddTransaction(){
     final title = titleController.text;
     final amount = double.parse(amountController.text);
     if(title.isEmpty || amount <=0){
        return;
     }
    _addTransaction(title,amount);
  }
  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(10),
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
                   TextButton(
                    onPressed: handleAddTransaction, 
          
                    style: TextButton.styleFrom(
                      primary: Colors.purple
                    ),
                    child: const Text("Add Transaction")
                    )
          ]),));
  }
}