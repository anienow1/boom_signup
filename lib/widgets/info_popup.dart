import 'package:boom_signup/database/event_handler.dart';
import 'package:boom_signup/themes.dart';
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
      backgroundColor: AppColors.white,
      title: _renderTitle(),
      content: _renderContent(),
      actions: [_renderCancelButton(), _renderSaveButton()],
    );
  }

  Widget _renderTitle() {
    return Row(
      children: [
        Container(width: 4, height: 22, color: AppColors.gustieGold),
        SizedBox(width: AppPadding.small),
        Text("Sign up", style: AppTextStyles.dateStyle),
      ],
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
            const SizedBox(height: AppPadding.small),
            _renderTimeBox(),
            const SizedBox(height: AppPadding.small),
            _renderDayDropDown(),
          ],
        ),
      ),
    );
  }

  Widget _renderNameBox() {
    return TextFormField(
      controller: _nameController,
      style: AppTextStyles.personStyle,
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
      style: AppTextStyles.personStyle,
      decoration: const InputDecoration(
        labelText: 'Time',
        hintText: 'Enter when you want to play.',
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
      style: AppTextStyles.personStyle,
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
      style: TextButton.styleFrom(foregroundColor: AppColors.textSecondary),
      child: Text(
        'Cancel',
        style: AppTextStyles.appBarButton.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
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