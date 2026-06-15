class Event {
  final DateTime date;
  late List<Entry>? entries;
  final String? id;

  Event(this.date, {this.entries, this.id});

  void addPerson(Entry entry) {
    entries ??= [];
    entries!.add(entry);
  }

  List<Entry> get entryList => entries ?? [];

  factory Event.fromMap(Map<String, dynamic> map, String id) {
    final dateString = map['date'] as String?;
    if (dateString == null) {
      throw FormatException('Event data missing required date field');
    }
    DateTime temp = DateTime.parse(dateString);
    final date = DateTime(temp.year, temp.month, temp.day);

    final entriesList = map['entries'] as List<dynamic>?;

    return Event(
      date,
      entries: entriesList
          ?.map(
            (entry) => Entry.fromMap(
              Map<String, dynamic>.from(entry as Map<dynamic, dynamic>),
            ),
          )
          .toList(),
      id: id,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Event) return false;
    if (id != null && other.id != null) return id == other.id;
    return date == other.date;
  }

  @override
  int get hashCode => id?.hashCode ?? date.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'entries': entries == null ? [] : entries!.toMap(),
    };
  }
}

class Entry {
  final String person;
  final String preferredTime;
  final String? id;

  Entry(this.person, this.preferredTime, {this.id});

  factory Entry.fromMap(Map<String, dynamic> map) {
    final person = map['person'] as String? ?? '';
    final preferredTime = map['preferredTime'] as String? ?? '';
    return Entry(person, preferredTime, id: map['id'] as String?);
  }

  Map<String, dynamic> toMap() {
    return {'person': person, 'preferredTime': preferredTime, 'id': id};
  }
}

extension EntryListSerialization on List<Entry> {
  List<Map<String, dynamic>> toMap() {
    return map((entry) => entry.toMap()).toList();
  }
}
