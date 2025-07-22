import 'package:flutter/material.dart';

class IncludedCard extends StatelessWidget {
  final List<String> includeList;
  final List<String> notIncludeList;

  const IncludedCard({
    super.key,
    required this.includeList,
    required this.notIncludeList,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return isMobile
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildIncludedCard(
                  'Included',
                  includeList,
                  Colors.green,
                  Icons.check_circle,
                ),
                const SizedBox(height: 15),
                _buildIncludedCard(
                  'Not Included',
                  notIncludeList,
                  Colors.red,
                  Icons.cancel,
                ),
              ],
            )
            : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildIncludedCard(
                    'Included',
                    includeList,
                    Colors.green,
                    Icons.check_circle,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildIncludedCard(
                    'Not Included',
                    notIncludeList,
                    Colors.red,
                    Icons.cancel,
                  ),
                ),
              ],
            );
      },
    );
  }

  Widget _buildIncludedCard(
    String title,
    List<String> items,
    MaterialColor color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color[200]!, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color[600], size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...items
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        title == 'Included' ? Icons.check : Icons.close,
                        color: color[600],
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          item,
                          style: TextStyle(
                            color: color[700],
                            fontSize: 12,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
