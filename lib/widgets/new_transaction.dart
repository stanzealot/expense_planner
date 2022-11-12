import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  
  Function _addTransaction;
  NewTransaction(this._addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void handleAddTransaction(){
     final title = titleController.text;
     final amount = double.parse(amountController.text);
     if(title.isEmpty || amount <=0){
        return;
     }
    widget._addTransaction(title,amount);
    //close the outermost screen
    Navigator.of(context).pop();
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
                    Container(
                      height: 70,
                      child: Row(
                        children: [
                          Text('No date choosen'),
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Theme.of(context).primaryColor
                            ),
                            onPressed: (){}, 
                            child: Text('Choose Date',style: TextStyle(fontWeight: FontWeight.bold),)
                            )
                        ],
                      ),
                    ),
                   ElevatedButton(
                    onPressed: handleAddTransaction, 
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Theme.of(context).textTheme.button?.color,
                    ),
                    child: const Text("Add Transaction")
                    )
          ]),));
  }
}