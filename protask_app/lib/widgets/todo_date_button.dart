import 'package:flutter/material.dart';

class TodoDateButton extends StatelessWidget {
  final String title;
  final DateTime date;
  final bool isSelected;
  final VoidCallback onPressed;

  const TodoDateButton({
    super.key,
    required this.title,
    required this.date,
    required this.isSelected,
    required this.onPressed,
  });

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 95,
        height: 65,
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.shade800 : Colors.grey.shade100,
          border: Border.all(
            color: isSelected ? Colors.grey.shade800 : Colors.grey.shade300,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              _formatDate(date),
              style: TextStyle(
                fontSize: 13,
                color: isSelected ? Colors.grey.shade300 : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
