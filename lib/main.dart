import 'package:finiance_app/models/transaction.dart';
import 'package:finiance_app/widgets/chart.dart';
import 'package:finiance_app/widgets/new_transaction.dart';
import 'package:finiance_app/widgets/transaction_list.dart';
import 'package:finiance_app/widgets/user_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
//import './transaction.dart';
//when you import a file, you automatically unlock all non-private

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//You do this cause it might not work on some screen
//  SystemChrome.setPreferredOrientations([
//This is used to set permanent potrait orientation
//    DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Wave',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        errorColor: Colors.red,
        //accentColor: Colors.amber,
        fontFamily: 'RobotoMono',
        appBarTheme: AppBarTheme(
            // textTheme: ThemeData.light().textTheme.copyWith(
            //         subtitle1: TextStyle(
            //       fontFamily: 'RobotoMono',
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //     )),
            ),
//accentColor changes the inBuilt widget of flutter
//PrimarySwatch gives different shades to your color
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Benz',
    //   amount: 800,
    //   date: DateTime.now(),
    // )
  ];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
//where actually returns an iterable so you need to convert it to a list
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  _addNewTransaction(
    String txTitle,
    double txAmount,
    DateTime chosenDate,
  ) {
    print('here');
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );
    setState(() {
      //_userTransactions is final so it cannot change
      _userTransactions.add(newTx);
      print(_userTransactions.length);
    });
  }

  _startAddNewTransaction(BuildContext ctx) {
//_startAddNewTransaction is now part of the private state class _MyHomePage
    print('pressed');
    showModalBottomSheet(
        context: ctx,
        builder: (ctx) {
          return NewTransaction(addTx: _addNewTransaction);
        });
  }
//How to delete transactions

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    //Then we make isLandScape a boolean of true or false
    final appBar = AppBar(
      title: Text('Danny Marvel Finance'),
      actions: [
        IconButton(
          onPressed: //()=> _startAddNewTransaction,
              () {
            //_startAddNewTransaction;

            _startAddNewTransaction(context);
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
//Wrap with SingleChildScrollView to enable scrolling
//You can also use a ListView()
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          //The default behaviour of a column is to put the container in the centre
          children: [
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
//The val acts for the boolean on/off, while the value is set to showChart
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandScape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
//The padding.top is from the status bar
                child: Card(
                  child: Image.asset(
                    'asset1/images/shibarium.jpg',
                    fit: BoxFit.cover,
//fit the whole card
                    height: 300,
                    width: 900,
                  ),
                  elevation: 10,
                ),
                //Chart is the main widget just testing image
                //Chart(
                //recentTransactions: _recentTransactions,
                //),
              ),
            if (!isLandScape)
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.6,
                  //The appBar should always be deducted from the height to aid balancing
                  child: TransactionList(
                      userTransactions: _userTransactions,
                      deleteTx: _deleteTransaction)),
            if (isLandScape)
              _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
//The padding.top is from the status bar
                      child: Chart(
                        recentTransactions: _recentTransactions,
                      ),
                    )
                  :
                  //Remeber Control Space Shit in a widget
                  //Card() is a prestyled beautiful container
                  Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.6,
                      //The appBar should always be deducted from the height to aid balancing
                      child: TransactionList(
                          userTransactions: _userTransactions,
                          deleteTx: _deleteTransaction)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startAddNewTransaction(context);
        },
      ),
    );
  }
}
