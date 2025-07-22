import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

class TourDescription extends StatelessWidget {
  final String description;

  const TourDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff1a73e8), width: 1.5),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 14,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: ExpandedTile(
              title: Text(
                'Description',
                style: TextStyle(
                  color: Color(0xFF1a73e8),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                description,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                ),
              ),
              controller: ExpandedTileController(),
              leading: Icon(
                Icons.description,
                size: 24,
                color: Color(0xFF1a73e8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
