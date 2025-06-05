import 'package:hive_flutter/adapters.dart' as hive_adapters;
import 'package:hive_flutter/hive_flutter.dart';
import '../models/event_model.dart';

class EventService {
  static const String _boxName = 'events';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(EventAdapter());
    await Hive.openBox<Event>(_boxName);
  }

  static Box<Event> get _box => Hive.box<Event>(_boxName);

  static Future<void> addEvent(Event event) async {
    await _box.add(event);
  }

  static List<Event> getAllEvents() {
    return _box.values.toList();
  }

  static Future<void> deleteEvent(int index) async {
    await _box.deleteAt(index);
  }

  static Future<void> updateEvent(int index, Event event) async {
    await _box.putAt(index, event);
  }
} 