import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransactions;

  TransactionList(this.transactions, this.deleteTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (ctx, contraints) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No transactions added yet!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Container(
                      height: contraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.gif',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                );
              })
            : ListView.builder(
                itemBuilder: (ctx, idx) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text('₹${transactions[idx].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[idx].title,
                        style: Theme.of(ctx).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[idx].date),
                      ),
                      trailing: MediaQuery.of(context).size.width > 400
                          ? TextButton.icon(
                              onPressed: () =>
                                  deleteTransactions(transactions[idx].id),
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(ctx).errorColor,
                              ),
                              label: Text(
                                "Delete",
                                style:
                                    TextStyle(color: Theme.of(ctx).errorColor),
                              ),
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(ctx).errorColor,
                              onPressed: () =>
                                  deleteTransactions(transactions[idx].id),
                            ),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
