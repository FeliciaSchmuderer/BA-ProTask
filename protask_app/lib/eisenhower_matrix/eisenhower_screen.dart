import 'package:flutter/material.dart';
import 'package:protask_app/constants/accomplishments_constants.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/eisenhower_matrix/eisenhower_quadrants.dart';

class EisenhowerScreen extends StatefulWidget {
  const EisenhowerScreen({super.key});

  @override
  State<EisenhowerScreen> createState() => _EisenhowerScreenState();
}

class _EisenhowerScreenState extends State<EisenhowerScreen> {
  // stores the currently selcted date for the matrix
  DateTime _selectedDate = DateTime.now();

  void _previousDay() {
    setState(() {
      _selectedDate = _selectedDate.subtract(
        const Duration(days: 1),
      );
    });
  }

  void _nextDay() {
    setState(() {
      _selectedDate = _selectedDate.add(
        const Duration(days: 1),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // tile
          const Text(
            'Eisenhower Matrix',
            style: TextStyle(
              fontSize: AppThemeConstants.titleFontSize,
              fontWeight: AppThemeConstants.titleFontWeight,
            ),
          ),

          const SizedBox(
            height: AppThemeConstants.spacingSmall,
          ),

          // option to switch between dates
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _previousDay,
                icon: const Icon(Icons.chevron_left),
              ),
              Text(
                '${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}',
                style: const TextStyle(
                  fontSize: AppThemeConstants.bodyFontSize,
                  fontWeight: AppThemeConstants.subtitleFontWeight,
                ),
              ),
              IconButton(
                onPressed: _nextDay,
                icon: Icon(Icons.chevron_right),
              ),
            ],
          ),

          const SizedBox(
            height: AppThemeConstants.spacingSmall,
          ),

          // the four Eisenhower quadrants
          LayoutBuilder(builder: (context, constraints) {
            final width = constraints.maxWidth;

            // two quadrants next to each other
            const columnCount = 2;

            // calculates the width of each quadrant
            final itemWidth = (width - 12) / columnCount;

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(
                  width: itemWidth,
                  child: const EisenhowerQuadrants(
                    title: 'Important & Urgent',
                  ),
                ),
                SizedBox(
                  width: itemWidth,
                  child: const EisenhowerQuadrants(
                    title: 'Important & Not Urgent',
                  ),
                ),
                SizedBox(
                  width: itemWidth,
                  child: const EisenhowerQuadrants(
                    title: 'Not Important & Urgent',
                  ),
                ),
                SizedBox(
                  width: itemWidth,
                  child: const EisenhowerQuadrants(
                    title: 'Not Important & Not Urgent',
                  ),
                ),
              ],
            );
          })
        ],
      ),
    );
  }
}
