import 'package:finiance_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({super.key, required this.recentTransactions});
  List<Map<String, Object>> get groupedTransactionValues {
//groupedTransaction yields a List
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        //subString makes the day to start from M & W, instead of Mon & Wedk
        'amount': totalSum,
//DateFormat.E gives us a short cut to the week days
      };
    });
//The index is 1 lower than the lenght
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as num);
      //To convert object to num add as num to it
    });
    //fold helps to change a list to another type, by certain logic
  }

  @override
  Widget build(BuildContext context) {
    print('data: $groupedTransactionValues');
    return
        //The chart Bar takes 40% since the list Column takes 60%
        Card(
      elevation: 7,
      margin: EdgeInsets.all(20),
      // child: Row(
      //    children: groupedTransactionValues.map((data) {
      //      return ChartBar(
      //          label: data['day'].toString(),
      //          spendingAmount:
      //            data['amount'] == null
      //              ? 0.0
      //             : 
      //              double.parse(data['amount'].toString()),
      //          spendingPctOfTotal: totalSpending);
      //      //$concartinate automatcally converts it to a string
      //    }).toList(),
      //  ),
    );
  }
}
