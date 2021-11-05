import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountcontroller = TextEditingController();
  var _selectedDate;

  void _submitData() {
    if (_amountcontroller.text.isEmpty) return;
    var title = _titleController.text;
    var amount = double.parse(_amountcontroller.text);

    if (title.isEmpty || amount <= 0 || _selectedDate == null) return;

    widget.addTransaction(
      title,
      amount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date != null)
        setState(() {
          _selectedDate = date;
        });
      else
        return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: _amountcontroller,
                onSubmitted: (_) => _submitData(),
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
              ),
              Container(
                height: 80,
                child: Row(
                  children: [
                    Text(_selectedDate == null
                        ? 'No date chosen!'
                        : DateFormat.yMd().format(_selectedDate)),
                    SizedBox(
                      width: 10,
                    ),
                    Platform.isIOS
                        ? CupertinoButton(
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: selectDate)
                        : TextButton(
                            onPressed: selectDate,
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: Text("Add transaction"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).primaryColor,
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
