import 'package:flutter/material.dart';

class DeleteConfirmationPopup {
  static Future<bool> show(BuildContext context, String person) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmation Check"),
        content: Text("Are you sure you want to remove \"$person\"?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () =>
                Navigator.of(context).pop(false), // Closes without action
          ),
          TextButton(
            child: const Text("Confirm"),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    ) ?? false;
  }
}