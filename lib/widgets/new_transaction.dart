import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key, required this.addTransaction});

  final Function addTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  DateTime? selectedDate = DateTime.now();

  void _submitData() {
    if (amountController.text.isEmpty) return;

    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }

    widget.addTransaction(
      titleController.text,
      double.parse(amountController.text),
      selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 16.0,
          right: 16.0,
          left: 16.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Transaction',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title:',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _submitData(),
              controller: titleController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount:',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              // onChanged: (value) {
              //   amountInput = value;
              // },
              onSubmitted: (_) => _submitData(),
              controller: amountController,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate == null
                      ? 'No Date Chosen'
                      : DateFormat.yMd().format(
                          selectedDate!,
                        ),
                ),
                TextButton(
                  onPressed: _datePicker,
                  child: Text(
                    'Choose Date',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
            OutlinedButton(
              onPressed: _submitData,
              style: OutlinedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                "Add Transaction",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            )
          ],
        ),
      ),
    );
  }
}
