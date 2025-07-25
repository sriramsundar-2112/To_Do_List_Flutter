import 'package:flutter/material.dart';

class NoTasksWidget extends StatelessWidget {
  final String message;
  const NoTasksWidget({Key? key, this.message = 'No tasks found!'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 100, color: Colors.grey[400]),
          const SizedBox(height: 24),
          Text(message, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey)),
        ],
      ),
    );
  }
} 