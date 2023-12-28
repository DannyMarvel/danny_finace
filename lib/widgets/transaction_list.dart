import 'package:finiance_app/widgets/user_transaction.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
//.. Means move out of the Widget file then search for transaction file

class TransactionList extends StatelessWidget {
  TransactionList(
      {super.key, required this.userTransactions, required this.deleteTx});
  final List<Transaction> userTransactions;
  final Function deleteTx;

  

  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? 
//Means taking 60% of the available height of the screen.          
   Center(
    child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
     children: [
                  Text('No Transactions added yet'),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'asset1/images/shiba logo.png',
                    //fit: BoxFit.cover,
                    height: 70,
                    width: 100,
                  ),
                ],
              ),
            )
        : SingleChildScrollView(
          child: Column(
            
              children: userTransactions.map(
                (tx) {
                  //tx is passed as an input to the function we pass to map
                  return Card(
                      elevation: 7,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                            radius: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: FittedBox(
                                  child: Text('\$${tx.amount.toStringAsFixed(2)}')),
                            )),
                        title: Text(
                          tx.title,
                          style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(DateFormat.yMMMd().format(tx.date)),
                        trailing: MediaQuery.of(context).size.width>500? ElevatedButton.icon(
                         icon: Icon(Icons.delete),
                         label: Text('Delete'),
                         style: ButtonStyle(foregroundColor:MaterialStateProperty.all<Color>(Colors.red) , ),
                          
                          onPressed: () => deleteTx(tx.id), 
                          ):
                        
                         IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteTx(tx.id),
                      //Pass a reference to the function                  
                          color: Theme.of(context).errorColor,
                        ),
                      ),
                    );
                  
                },
             
              ).toList(),
              //map() will always give you an iterable which you must convert .toList()
            ),
        );
  }
}
