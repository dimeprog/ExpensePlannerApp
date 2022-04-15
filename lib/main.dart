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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool _showchart = false;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  //
  @override
  void didChangeApplifeCycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

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

  List<Widget> _buildLandScapeContent(MediaQueryData mediaQuery, var appBar) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Switch.adaptive(
              value: _showchart,
              onChanged: (val) {
                setState(() {
                  _showchart = val;
                });
              }),
        ],
      ),
      _showchart
          ? Container(
              child: Chart(_userTransaction),
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
            )
          : Container(
              child: TransactionList(_userTransaction, _deleteTransaction),
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.5,
            ),
    ];
  }

  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery, var appBar) {
    return [
      Container(
        child: Chart(_userTransaction),
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
      ),
      Container(
        child: TransactionList(_userTransaction, _deleteTransaction),
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.6,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    //
    final CuAppBar = CupertinoNavigationBar(
      middle: Text('Expenses Recorder'),
      trailing: GestureDetector(
        child: Icon(CupertinoIcons.add),
        onTap: () => _startTransaction(context),
      ),
    );
    //
    final appBar = Platform.isIOS
        ? PreferredSize(
            preferredSize: Size.fromHeight(10),
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
//
    final chartContainer = Container(
      child: Chart(_userTransaction),
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.3,
    );
    //
    final txListContainer = Container(
      child: TransactionList(_userTransaction, _deleteTransaction),
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.6,
    );
    //
    final pagebody = SafeArea(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isLandScape) ..._buildLandScapeContent(mediaQuery, appBar),
          if (!isLandScape) ..._buildPortraitContent(mediaQuery, appBar),
        ],
      ),
    );
    //
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
