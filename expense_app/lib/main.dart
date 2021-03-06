import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              subtitle1: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                subtitle1: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _userTransactions = [
    Transaction(1, 'Teddy', 12.99, DateTime.now()),
    Transaction(2, 'Keyboard', 59.99, DateTime.now()),
  ];

  bool _showChart = true;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    setState(() {
      _userTransactions.add(
        Transaction(DateTime.now().millisecondsSinceEpoch, title, amount, date),
      );
    });
  }

  void _deleteTransaction(int id) {
    setState(() {
      _userTransactions =
          _userTransactions.where((element) => element.id != id).toList();
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: Text(
        'Expense App',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;
    final bool isLandscapeMode =
        mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (isLandscapeMode)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch.adaptive(
                  activeColor: Theme.of(context).accentColor,
                  value: _showChart,
                  onChanged: (bool value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                ),
              ],
            ),
          if (isLandscapeMode)
            _showChart
                ? Container(
                    height: availableHeight * 0.6,
                    child: Chart(_recentTransactions),
                  )
                : Container(
                    height: availableHeight * 0.7,
                    child:
                        TransactionList(_userTransactions, _deleteTransaction),
                  ),
          if (!isLandscapeMode)
            Container(
              height: availableHeight * 0.3,
              child: Chart(_recentTransactions),
            ),
          if (!isLandscapeMode)
            Container(
              height: availableHeight * 0.7,
              child: TransactionList(_userTransactions, _deleteTransaction),
            ),
        ],
      ),
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
    );
  }
}
