import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction({super.key, required this.addTx});
  final Function addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;
    //Ordinary return stops code from running, stops function execution

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    //Navigator.of(context).pop();
    //of.context gives the right acces to the Navigator
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
//setstate sends a mesaage that a stateful wwidget changed and the buil UI should rerun again
    }
//.then() acts as a future function that recives the presentDatePicker and stores it where neccessary
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        // There is no padding in a card only margin
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10, 
          bottom: MediaQuery.of(context).viewInsets.bottom +10,
    //.bottom tells us how much space is occupied by our keyboard        
    //viewInsets give us access to anything overlapping our view such as text field, this          
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                //onChanged: (val) {
                //titleInput= val;
                //This means the onChaged 'val' changes the initial Textfield } ,
                controller: titleController,
                // onSubmitted:(_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                //onChanged: (val){
                //amountInput = val;},
                controller: amountController,
                keyboardType: TextInputType.number,
                // onSubmitted:(_) => submitData(),
                //For the submit it get an arguement but does not plan using it
              ),
              //The Text field is responsible for recieving the user input
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
    //Expanded makes a widget to occupy all the available space
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                        //.format() always takes the date note the constructor
                        //Concartination up there
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.pinkAccent),
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                child: Text(
                  'Add Transaction',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  final enteredTitle = titleController.text;
                  final enteredAmount = double.parse(amountController.text);
                  if (enteredTitle.isEmpty || enteredAmount <= 0) return;
                  //Ordinary return stops code from running, stops function execution
                  print('hello');
    
                  widget.addTx(
                    enteredTitle,
                    enteredAmount,
                    _selectedDate,
                  );
                  Navigator.of(context).pop();
                },
    
                //takes a string and convert it to a double
    
                style: TextButton.styleFrom(backgroundColor: Colors.purple),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
