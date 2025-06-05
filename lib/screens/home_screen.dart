import 'package:flutter/material.dart';
import 'package:calendar_test/widgets/weekly_calendar.dart';
import 'package:calendar_test/screens/event_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(70, 130, 180, 1),
        centerTitle: true,
        title: const Text(
          "Agenda Semanal",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'OpenSans',
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_box_rounded,
              color: Color.fromRGBO(255, 255, 255, 1),
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EventFormScreen()),
              );
            },
          ),
        ],
      ),
      body: const AgendaSemanaWidget(),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
    );
  }
} 