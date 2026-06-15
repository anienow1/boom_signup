import 'package:boom_signup/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatefulWidget {
  const DateWidget(this.event, {required this.onEntryDelete, super.key});

  final Event event;
  final void Function(Event, Entry) onEntryDelete;

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.event.entries != null && widget.event.entries!.isNotEmpty
        ? Container(
            constraints: BoxConstraints(minHeight: 200),
            decoration: BoxDecoration(
              border: Border.all(),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: _renderBox(context),
          )
        : Container();
  }

  Widget _renderBox(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 8),
          child: Text(
            DateFormat("EEEE").format(widget.event.date),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        _renderTable(context),
      ],
    );
  }

  Widget _renderTable(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8, left: 8, bottom: 8),
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1.5), // Twice as wide
        },

        border: TableBorder.all(color: Colors.grey, width: 1),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            children: [
              _titleCellFormat("Date"),
              _titleCellFormat('Players and Times'),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Container(
                  alignment: .center,
                  padding: EdgeInsets.all(8.0),
                  child: Text(DateFormat.yMd().format(widget.event.date)),
                ),
              ),
              TableCell(child: _renderAllPeople()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _titleCellFormat(String text) {
    return TableCell(
      child: Container(
        decoration: BoxDecoration(color: Colors.black),
        padding: EdgeInsets.all(8.0),
        alignment: .center,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
        ),
      ),
    );
  }

  Widget _renderAllPeople() {
    return Column(
      children: [
        for (Entry entry in widget.event.entryList) _renderPerson(entry),
      ],
    );
  }

  Widget _renderPerson(Entry entry) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "${entry.person} (${entry.preferredTime})",
          style: TextStyle(color: Colors.black),
        ),
        IconButton(
          onPressed: () {
            widget.onEntryDelete(widget.event, entry);
          },
          icon: Image.asset(("lib/assets/x-icon.png"), width: 18, height: 18),
        ),
      ],
    );
  }
}
