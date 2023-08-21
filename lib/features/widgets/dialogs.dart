import 'package:flutter/material.dart';

class dialogs {
  // nofition successfully
  static showSnackBarSuccessfully(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.green[400],
      ),
    );
  }

  // nofition not successful
  static showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red[400],
      ),
    );
  }

  // loading page
  static void showProcessBar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => Center(child: CircularProgressIndicator()));
  }

  static void showSuccess(BuildContext context) {
    AlertDialog(
      title: const Text('Are you sure ?'),
      actions: <Widget>[
        ElevatedButton(onPressed: () {}, child: const Text('Yes')),
        ElevatedButton(onPressed: () {}, child: const Text('No')),
      ],
    );
  }

  // options choose
  static void dialogSuccess(BuildContext context) {
    AlertDialog(
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
