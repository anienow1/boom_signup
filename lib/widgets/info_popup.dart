import 'package:boom_signup/database/event_handler.dart';
import 'package:boom_signup/utils.dart';
import 'package:flutter/material.dart';

class InformationPopup {
  static Future<SignupDialogResult?> showSignupDialog(
    BuildContext context,
  ) async {
    return await showDialog<SignupDialogResult>(
      context: context,
      builder: (context) => SignupAlertDialog(),
    );
  }
}

class SignupDialogResult {
  final String name;
  final String time;
  final Weekday day;

  SignupDialogResult({
    required this.name,
    required this.time,
    required this.day,
  });
}

class SignupAlertDialog extends StatefulWidget {
  SignupAlertDialog({super.key});

  final Weekday initialDay = dateToWeekday(DateTime.now());

  @override
  State<SignupAlertDialog> createState() => _SignupAlertDialogState();
}

class _SignupAlertDialogState extends State<SignupAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  late Weekday _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initialDay;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sign Up'),
      content: _renderContent(),
      actions: [_renderCancelButton(), _renderSaveButton()],
    );
  }

  Widget _renderContent() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _renderNameBox(),
            const SizedBox(height: 12),
            _renderTimeBox(),
            const SizedBox(height: 12),
            _renderDayDropDown(),
          ],
        ),
      ),
    );
  }

  Widget _renderNameBox() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Name',
        hintText: 'Enter your name',
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a name.';
        }
        return null;
      },
    );
  }

  Widget _renderTimeBox() {
    return TextFormField(
      controller: _timeController,
      decoration: const InputDecoration(
        labelText: 'Time',
        hintText: 'Enter a time (e.g. 5:00 PM)',
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a time.';
        }
        return null;
      },
    );
  }

  Widget _renderDayDropDown() {
    return DropdownButtonFormField<Weekday>(
      initialValue: widget.initialDay,
      hint: Text("Select a weekday"),
      decoration: const InputDecoration(labelText: 'Day'),
      items: Weekday.values
          .map(
            (day) =>
                DropdownMenuItem(value: day, child: Text(weekdayToString(day))),
          )
          .toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedDay = value;
          });
        }
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a day.';
        }
        return null;
      },
    );
  }

  Widget _renderCancelButton() {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('Cancel'),
    );
  }

  Widget _renderSaveButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          Navigator.of(context).pop(
            SignupDialogResult(
              name: _nameController.text.trim(),
              time: _timeController.text.trim(),
              day: _selectedDay,
            ),
          );
        }
      },
      child: const Text('Save'),
    );
  }
}
