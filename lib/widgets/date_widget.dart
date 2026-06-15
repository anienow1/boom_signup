import 'package:boom_signup/models/event.dart';
import 'package:boom_signup/themes.dart';
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
            constraints: BoxConstraints(minHeight: 175),
            decoration: TableDecorations.table,
            child: _renderBox(context),
          )
        : SizedBox.shrink();
  }

  Widget _renderBox(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_renderDate(), _renderTable(context)],
    );
  }

  Widget _renderDate() {
    return Padding(
      padding: EdgeInsets.only(
        top: AppPadding.normal,
        left: AppPadding.normal,
        right: AppPadding.normal,
        bottom: AppPadding.small,
      ),
      child: Text(
        DateFormat('EEEE, MMMM d').format(widget.event.date),
        style: AppTextStyles.dateStyle,
      ),
    );
  }

  Widget _renderTable(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: AppPadding.normal,
        left: AppPadding.normal,
        bottom: AppPadding.normal,
      ),
      child: Table(
        border: TableBorder.all(
          color: AppColors.divider,
          width: 1,
          borderRadius: BorderRadius.circular(4),
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[_renderTableHeader(), _renderAllPeople()],
      ),
    );
  }

  TableRow _renderTableHeader() {
    return TableRow(
      decoration: TableDecorations.tableHeader,
      children: [
        Padding(
          padding: AppPadding.tableCellPadding,
          child: Text('PLAYERS & TIMES', style: AppTextStyles.tableHeader),
        ),
      ],
    );
  }

  TableRow _renderAllPeople() {
    return TableRow(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < widget.event.entryList.length; i++)
              _renderPerson(widget.event.entryList[i], i),
          ],
        ),
      ],
    );
  }

  Widget _renderPerson(Entry entry, int index) {
    final bool isLast = index == widget.event.entryList.length - 1;
    return Container(
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: AppColors.divider, width: 1),
              ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.small,
        vertical: AppPadding.extraSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_renderEntryLabel(entry), _renderDeleteButton(entry)],
      ),
    );
  }

  Widget _renderEntryLabel(Entry entry) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 3,
          height: 20,
          margin: const EdgeInsets.only(right: AppPadding.small),
          color: AppColors.gustieGold,
        ),
        Text(
          '${entry.person}  ·  ${entry.preferredTime}',
          style: AppTextStyles.personStyle,
        ),
      ],
    );
  }

  Widget _renderDeleteButton(Entry entry) {
    return IconButton(
      onPressed: () => widget.onEntryDelete(widget.event, entry),
      icon: Image.asset('lib/assets/x-icon.png', width: 16, height: 16),
      padding: const EdgeInsets.all(AppPadding.extraSmall),
      constraints: const BoxConstraints(),
      splashRadius: 18,
    );
  }

  /* Widget _renderAllPeople() {
    return Column(
      children: [
        for (Entry entry in widget.event.entryList) _renderPerson(entry),
      ],
    );
  }

  Widget _renderPerson(Entry entry, int index) {
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
  } */
}
