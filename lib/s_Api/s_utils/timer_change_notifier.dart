import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../view/dashboardScreen/dashboard.dart'; // Import the Material library for showDialog

class CountdownTimerState with ChangeNotifier {
  int _remainingSeconds = 600; // Initial countdown time in seconds
  int get remainingSeconds => _remainingSeconds;
  Timer? _timer; // Store a reference to the timer

  CountdownTimerState(BuildContext context) {
    startCountdown(context);
  }

  void startCountdown(BuildContext context) {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        timer.cancel(); // Stop the timer when it reaches 0
        // Show a dialog after the timer is canceled

          _showDialog(context);

      }
    });
  }
  void stopTimer(){
    _timer?.cancel();
  }

  // Helper function to show the dialog
  void _showDialog(BuildContext context) {
    // Use the context of the root widget or provide a context here
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text('Session Timeout:'),
          content: Text('Your session has expired due to inactivity. Please restart the send process to continue using our services. Thank you!'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    DashboardScreen()), (Route<dynamic> route) => false); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
