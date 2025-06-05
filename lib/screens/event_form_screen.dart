import 'package:flutter/material.dart';
import 'package:calendar_test/models/event_model.dart';
import 'package:calendar_test/services/event_service.dart';

class EventFormScreen extends StatefulWidget {
  const EventFormScreen({super.key});

  @override
  State<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Color _selectedBackgroundColor = Colors.white;

  final List<Color> _availableColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveEvent() {
    if (_formKey.currentState!.validate()) {
      final event = Event(
        name: _nameController.text,
        description: _descriptionController.text,
        date: _selectedDate,
        colorValue: Colors.blue.value,
        backgroundColorValue: _selectedBackgroundColor.value,
        status: 'Upcoming',
      );
      EventService.addEvent(event);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add task",
          style: TextStyle(
            fontSize: isSmallScreen ? 18 : 20,
            fontFamily: 'OpenSans',
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(70, 130, 180, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nome do Evento',
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.02,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    fontFamily: 'OpenSans',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um nome para o evento';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.02,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    fontFamily: 'OpenSans',
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma descrição para o evento';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                ListTile(
                  title: Text(
                    'Data do Evento',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 18 : 20,
                      fontFamily: 'OpenSans',
                      color: const Color.fromRGBO(70, 130, 180, 1),
                    ),
                  ),
                  trailing: Icon(
                    Icons.calendar_today,
                    size: isSmallScreen ? 24 : 30,
                    color: const Color.fromRGBO(70, 130, 180, 1),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.02,
                  ),
                  onTap: () => _selectDate(context),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Cor de Fundo',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 18,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Wrap(
                  spacing: screenWidth * 0.02,
                  runSpacing: screenHeight * 0.01,
                  children: _availableColors.map((color) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedBackgroundColor = color;
                        });
                      },
                      child: Container(
                        width: isSmallScreen ? 32 : 40,
                        height: isSmallScreen ? 32 : 40,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _selectedBackgroundColor == color ? Colors.black : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: screenHeight * 0.03),
                ElevatedButton(
                  onPressed: _saveEvent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(70, 130, 180, 1),
                    minimumSize: Size(double.infinity, screenHeight * 0.06),
                  ),
                  child: Text(
                    'Save Task',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      fontFamily: 'OpenSans',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
