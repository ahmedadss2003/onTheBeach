import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TourInfo extends StatelessWidget {
  final String? departureTime;
  final String? returnTime;

  const TourInfo({super.key, this.departureTime, this.returnTime});

  String? formatHourAndMinute(String? timeString) {
    if (timeString == null) return null;
    try {
      final parsedTime = DateFormat("HH:mm:ss").parse(timeString);
      return DateFormat.jm().format(parsedTime);
    } catch (e) {
      return timeString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[50]!, Colors.blue[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          _buildInfoRow(
            'Departure Time',
            departureTime != null
                ? 'Around ${formatHourAndMinute(departureTime)}'
                : 'The trip will be determined with the tourist.',
            Icons.schedule,
          ),
          const SizedBox(height: 15),
          _buildInfoRow(
            'Return Time',
            returnTime != null
                ? 'Around ${formatHourAndMinute(returnTime)}'
                : 'The trip will be determined with the tourist.',
            Icons.schedule_send,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[600]!, Colors.cyan[500]!],
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
