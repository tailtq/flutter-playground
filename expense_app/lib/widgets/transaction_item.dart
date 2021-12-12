import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  final Function deleteTransaction;

  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 6,
      child: ListTile(
        leading: CircleAvatar(
          radius: 26,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '\$${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
        trailing: MediaQuery.of(context).size.width > 360
            ? FlatButton.icon(
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                textColor: Theme.of(context).errorColor,
                onPressed: () => deleteTransaction(transaction.id),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTransaction(transaction.id),
              ),
      ),
    );
  }
}
