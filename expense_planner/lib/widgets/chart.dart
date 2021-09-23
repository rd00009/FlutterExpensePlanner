import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTrans;
  Chart(this.recentTrans);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;
      for (int i = 0; i < recentTrans.length; i++) {
        if (recentTrans[i].date.day == weekDay.day &&
            recentTrans[i].date.month == weekDay.month &&
            recentTrans[i].date.year == weekDay.year) {
          totalAmount += recentTrans[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount
      };
    });
  }

  double get MaxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsetsDirectional.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((e) {
            // return Text('${e['day']} ${e['amount']}');
            return Flexible(
              fit: FlexFit.tight,
              child: Bar(
                  e['day'].toString(),
                  (e['amount'] as double),
                  MaxSpending > 0
                      ? ((e['amount'] as double) / MaxSpending)
                      : 0),
            );
          }).toList(),
        ),
      ),
    );
  }
}
