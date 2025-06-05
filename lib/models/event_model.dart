import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

part 'event_model.g.dart';

@HiveType(typeId: 0)
class Event extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final int colorValue;

  @HiveField(4)
  final String status;

  @HiveField(5)
  final int backgroundColorValue;

  Event({
    required this.name,
    required this.description,
    required this.date,
    required this.colorValue,
    required this.status,
    required this.backgroundColorValue,
  });
} 