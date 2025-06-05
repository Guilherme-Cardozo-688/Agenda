import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/event_model.dart';

class EventosListaWidget extends StatelessWidget {
  final List<Event> eventos;
  final bool isSmallScreen;
  final double screenWidth;
  final double screenHeight;

  const EventosListaWidget({
    super.key,
    required this.eventos,
    required this.isSmallScreen,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: eventos.isEmpty
          ? Center(
              child: Text(
                'Nenhum evento para este dia',
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  color: Colors.grey,
                  fontFamily: 'OpenSans',
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(
                left: screenWidth * 0.04,
                right: screenWidth * 0.04,
                top: screenHeight * 0.02,
                bottom: screenHeight * 0.1,
              ),
              itemCount: eventos.length,
              itemBuilder: (context, index) {
                final evento = eventos[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Color(evento.backgroundColorValue),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          evento.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 16 : 20,
                            fontFamily: 'OpenSans',
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          evento.description,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 16,
                            fontFamily: 'OpenSans',
                            color: Colors.white,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: isSmallScreen ? 16 : 18,
                              color: Colors.white.withOpacity(0.8),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              '${evento.date.day}/${evento.date.month}/${evento.date.year}',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 16,
                                fontFamily: 'OpenSans',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            Icon(
                              Icons.access_time,
                              size: isSmallScreen ? 16 : 18,
                              color: Colors.white.withOpacity(0.8),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              DateFormat.Hm().format(evento.date),
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 16,
                                fontFamily: 'OpenSans',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
} 