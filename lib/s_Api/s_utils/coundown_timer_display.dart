import 'package:flutter/material.dart';
import 'package:moneytos/s_Api/s_utils/timer_change_notifier.dart';
import 'package:provider/provider.dart';

import '../../view/dashboardScreen/dashboard.dart';

class CountdownTimerDisplay extends StatefulWidget {
  @override
  State<CountdownTimerDisplay> createState() => _CountdownTimerDisplayState();
}

class _CountdownTimerDisplayState extends State<CountdownTimerDisplay> {
  void _showDialogAfterTimeout() {
    Future.delayed(Duration(seconds: CountdownTimerState(context).remainingSeconds), () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Time Out'),
            content: const Text('The countdown timer has expired.'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      DashboardScreen()), (Route<dynamic> route) => false); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    });
  }
  @override
  void initState() {
    super.initState();
    // Call a function to show the dialog after a timeout (e.g., 10 seconds)
    _showDialogAfterTimeout();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
    // final timerState = Provider.of<CountdownTimerState>(context);
    //
    // return Text(
    //   'Time left: ${timerState.remainingSeconds} sec',
    //   style: TextStyle(fontSize: 14),
    // );
  }
}
