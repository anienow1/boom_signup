import 'package:boom_signup/database/event_handler.dart';
import 'package:boom_signup/database/firestore_services.dart';
import 'package:boom_signup/models/event.dart';
import 'package:boom_signup/utils.dart';
import 'package:boom_signup/widgets/delete_confirmation_popup.dart';
import 'package:boom_signup/widgets/info_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:boom_signup/widgets/date_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Event> events = [];
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = true;
  bool hasNoEntries = false;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadEvents() async {
    _isLoading = true;
    List<Event> dbEvents = await FirestoreDatabase.instance.getEvents();

    final weekdays = Weekday.values;
    final weekdayEvents = await Future.wait(
      weekdays.map((day) => getDate(day, dbEvents)),
    );

    hasNoEntries = true;
    for (Event event in weekdayEvents) {
      if (event.entries != null && event.entries!.isNotEmpty) {
        hasNoEntries = false;
        break;
      }
    }

    setState(() {
      events.clear();
      events.addAll(weekdayEvents);
      events.sort(sortEventsWithTodayFirst);
      _isLoading = false;
    });
  }

  Future<Event> getDate(Weekday day, List<Event> dbEvents) async {
    Event? event = EventHandler.fetchWeekdayEvent(dbEvents, day);
    if (event != null) return event;
    final newEvent = Event(EventHandler.getNextWeekday(day));
    final newId = await FirestoreDatabase.instance.insertEvent(newEvent);
    return Event(newEvent.date, entries: newEvent.entries, id: newId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Image.asset(
          ("lib/assets/gac-icon.png"),
          width: 24,
          height: 24,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: _renderPopupButton(),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: .stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              "Boom Signup",
              style: TextStyle(color: Colors.black, fontSize: 32),
              textAlign: .center,
            ),
          ),
          _isLoading
              ? Container()
              : hasNoEntries
              ? Container(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text("No entries yet!"),
                )
              : AlignedGridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 1,
                  mainAxisSpacing: 12.0,
                  crossAxisSpacing: 12.0,
                  padding: const EdgeInsets.only(
                    right: 16,
                    bottom: 16,
                    left: 16,
                  ),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return DateWidget(
                      events[index],
                      onEntryDelete: onEntryDelete,
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _renderPopupButton() {
    return ElevatedButton(
      onPressed: () {
        _infoEntered(context);
      },
      child: Row(
        children: [
          Image.asset(("lib/assets/add-icon.png"), width: 24, height: 24),
          Padding(padding: EdgeInsets.only(right: 8)),
          Text('Signup (Click Here)'),
          Padding(padding: EdgeInsets.only(right: 8)),
          Image.asset(("lib/assets/add-icon.png"), width: 24, height: 24),
        ],
      ),
    );
  }

  Future<void> _infoEntered(BuildContext context) async {
    final data = await InformationPopup.showSignupDialog(context);
    if (data != null) {
      Event? eventToEdit;
      for (Event event in events) {
        if (dateToWeekday(event.date) == data.day) {
          eventToEdit = event;
          break;
        }
      }
      if (eventToEdit == null) {
        debugPrint('No matching event found for day ${data.day}.');
        return;
      }
      String id = DateTime.now().microsecondsSinceEpoch.toString();
      Entry entry = Entry(data.name, data.time, id: id);
      eventToEdit.addPerson(entry);
      await FirestoreDatabase.instance.addEntry(eventToEdit, entry);
      await _loadEvents();
    }
  }

  Future<void> onEntryDelete(Event event, Entry entry) async {
    final confirmed = await DeleteConfirmationPopup.show(context, entry.person);
    if (confirmed) {
      if (event.id != null && entry.id != null) {
        await FirestoreDatabase.instance.deleteEntry(event, entry);
        await _loadEvents();
      }
    }
  }
}
