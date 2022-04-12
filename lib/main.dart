import 'dart:io';
import 'package:expenseplannerapp/widget/Transaction_list.dart';
import 'package:expenseplannerapp/widget/chart.dart';
import 'package:expenseplannerapp/widget/new_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model/transactions.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Recorder',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: const TextStyle(
              fontFamily: 'OPenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: const TextStyle(
                  fontFamily: 'OPenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showchart = false;
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   title: 'Monthly data',
    //   amount: 12000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Food',
    //   amount: 59000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Monthly data',
    //   amount: 12000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Food',
    //   amount: 59000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Monthly data',
    //   amount: 12000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Food',
    //   amount: 59000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Monthly data',
    //   amount: 12000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Food',
    //   amount: 59000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Monthly data',
    //   amount: 12000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Food',
    //   amount: 59000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Monthly data',
    //   amount: 12000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Food',
    //   amount: 59000,
    //   date: DateTime.now(),
    // ),
  ];

  Iterable<Transaction> get _recentTransaction {
    return _userTransaction
        .where(
          (tx) => tx.date.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime choosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: choosenDate,
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLasndScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final CuAppBar = CupertinoNavigationBar(
      middle: Text('Expenses Recorder'),
      trailing: GestureDetector(
        child: Icon(CupertinoIcons.add),
        onTap: () => _startTransaction(context),
      ),
    );
    final PreferredSizeWidget appBar = Platform.isIOS
        ? PreferredSize(
            preferredSize: Size.fromHeight(mediaQuery.size.height * 0.08),
            child: CupertinoNavigationBar(
              middle: Text('Expenses Recorder'),
              trailing: GestureDetector(
                child: Icon(CupertinoIcons.add),
                onTap: () => _startTransaction(context),
              ),
            ),
          )
        : AppBar(
            title: const Text('Expenses Recorder'),
            actions: [
              IconButton(
                onPressed: () => _startTransaction(context),
                icon: const Icon(
                  Icons.add,
                ),
              )
            ],
          );

    final chartContainer = Container(
      child: Chart(_userTransaction),
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.3,
    );
    final txListContainer = Container(
      child: TransactionList(_userTransaction, _deleteTransaction),
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.6,
    );
    final pagebody = SafeArea(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLasndScape)
                Switch.adaptive(
                    value: _showchart,
                    onChanged: (val) {
                      setState(() {
                        _showchart = val;
                      });
                    }),
            ],
          ),
          if (isLasndScape)
            _showchart
                ? Container(
                    child: Chart(_userTransaction),
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                  )
                : Container(
                    child:
                        TransactionList(_userTransaction, _deleteTransaction),
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.5,
                  ),
          if (!isLasndScape) chartContainer,
          if (!isLasndScape) txListContainer,
        ],
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pagebody,
            navigationBar: CuAppBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pagebody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startTransaction(context),
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
          );
  }
}
