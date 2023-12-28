import 'package:flutter/material.dart';
import './transaction_list.dart';
import './new_transaction.dart';
import '../models/transaction.dart';
import 'package:finiance_app/widgets/user_transaction.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({super.key, required this.userTransactions});
  final List<Transaction> userTransactions;

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  //Start with underscore to mark as a private class

   _deleteTransaction(String id) {
    setState(() {
      widget.userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(
          addTx: () {},
        ),
        TransactionList(deleteTx: _deleteTransaction,
          userTransactions: widget.userTransactions,
        ),
      ],
    );
  }

  
}
