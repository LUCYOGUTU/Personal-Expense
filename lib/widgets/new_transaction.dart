import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key, required this.addTransaction});

  final Function addTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) return;

    widget.addTransaction(
        titleController.text, double.parse(amountController.text));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Title:'),
            onSubmitted: (_) => _submitData(),
            controller: titleController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Amount:'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            // onChanged: (value) {
            //   amountInput = value;
            // },
            onSubmitted: (_) => _submitData(),
            controller: amountController,
          ),
          TextButton(
            onPressed: _submitData,
            child: const Text("Add Transaction"),
          )
        ],
      ),
    );
  }
}
