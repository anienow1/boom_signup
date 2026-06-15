import 'package:flutter/material.dart';
import 'package:boom_signup/themes.dart';

class DeleteConfirmationPopup {
  static Future<bool> show(BuildContext context, String person) async {
    return await showDialog(
          context: context,
          builder: (context) => _DeleteConfirmationDialog(person: person),
        ) ??
        false;
  }
}

class _DeleteConfirmationDialog extends StatelessWidget {
  const _DeleteConfirmationDialog({required this.person});

  final String person;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: _renderTitle(),
      content: _renderContent(),
      actions: [_renderCancelButton(context), _renderConfirmButton(context)],
    );
  }

  Widget _renderTitle() {
    return Text('Remove player?', style: AppTextStyles.dateStyle);
  }

  Widget _renderContent() {
    return Text(
      'This will remove "$person" from the signup.',
      style: AppTextStyles.noEvents.copyWith(color: AppColors.black),
    );
  }

  Widget _renderCancelButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(false),
      style: TextButton.styleFrom(foregroundColor: AppColors.textSecondary),
      child: Text(
        'Cancel',
        style: AppTextStyles.appBarButton.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _renderConfirmButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
      ),
      onPressed: () => Navigator.of(context).pop(true),
      child: Text(
        'Remove',
        style: AppTextStyles.appBarButton.copyWith(color: AppColors.white),
      ),
    );
  }
}

/*class DeleteConfirmationPopup {
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
} */