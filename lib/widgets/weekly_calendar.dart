import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/event_model.dart';
import '../services/event_service.dart';
import 'eventos_lista_widget.dart';

class AgendaSemanaWidget extends StatefulWidget {
  final DateTime? initialDate;
  
  const AgendaSemanaWidget({
    super.key,
    this.initialDate,
  });

  @override
  State<AgendaSemanaWidget> createState() => _AgendaSemanaWidgetState();
}

class _AgendaSemanaWidgetState extends State<AgendaSemanaWidget> {
  late DateTime dataSelecionada;

  @override
  void initState() {
    super.initState();
    dataSelecionada = widget.initialDate ?? DateTime.now();
  }

  void updateSelectedDate(DateTime newDate) {
    setState(() {
      dataSelecionada = newDate;
    });
  }

  List<DateTime> getSemana(DateTime referencia) {
    final inicioSemana = referencia.subtract(Duration(days: referencia.weekday - 1));
    return List.generate(7, (index) => inicioSemana.add(Duration(days: index)));
  }

  List<Event> getEventosDoDia(DateTime data) {
    return EventService.getAllEvents().where((event) => 
      event.date.year == data.year && 
      event.date.month == data.month && 
      event.date.day == data.day
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final semana = getSemana(dataSelecionada);
    final eventosDoDia = getEventosDoDia(dataSelecionada);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360;

    return Stack(
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.03
                ,
              ),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(70, 130, 180, 1),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          DateFormat.yMMMM().format(dataSelecionada),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isSmallScreen ? 16 : 20,
                            fontFamily: 'OpenSans',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                          size: isSmallScreen ? 20 : 24,
                        ),
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: dataSelecionada,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Color.fromRGBO(70, 130, 180, 1),
                                    onPrimary: Colors.white,
                                    surface: Colors.white,
                                    onSurface: Colors.black,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setState(() {
                              dataSelecionada = picked;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: semana.map((data) {
                      final selecionado = isMesmoDia(data, dataSelecionada);
                      return GestureDetector(
                        onTap: () {
                          setState(() => dataSelecionada = data);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.01,
                            horizontal: screenWidth * 0.02,
                          ),
                          decoration: BoxDecoration(
                            color: selecionado ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Text(
                                DateFormat.E().format(data).toUpperCase(),
                                style: TextStyle(
                                  color: selecionado ? Colors.black : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: isSmallScreen ? 10 : 12,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.005),
                              Text(
                                '${data.day}',
                                style: TextStyle(
                                  color: selecionado ? Colors.black : Colors.white,
                                  fontSize: isSmallScreen ? 14 : 16,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
              ),
            ),
          ],
        ),
        Positioned(
          top: screenHeight * 0.18,
          left: 0,
          right: 0,
          bottom: 0,
          child: EventosListaWidget(
            eventos: eventosDoDia,
            isSmallScreen: isSmallScreen,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ),
      ],
    );
  }

  bool isMesmoDia(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}