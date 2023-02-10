import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/models/transaction.dart';
import 'package:personal_expense/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({
    super.key,
    required this.recentTransactions,
  });

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );
      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get maxSpending {
    return _groupedTransactions.fold(0.0, (previousValue, element) {
      return previousValue + double.parse(element['amount'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ..._groupedTransactions
                .map((data) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      labelWeekday: data['day'].toString(),
                      spendingAmount: double.parse(data['amount'].toString()),
                      spendingTotalPercentage: maxSpending == 0.0
                          ? 0.0
                          : double.parse(data['amount'].toString()) /
                              maxSpending,
                    ),
                  );
                })
                .toList()
                .reversed,
          ],
        ),
      ),
    );
  }
}
